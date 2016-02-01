(in-package :cl-amqp.test)

(enable-binary-string-syntax)

(plan 2)

(defclass test-method-assembler (method-assembler)
  ((consume-method-lambda :initarg :cm-lambda :reader consume-method-lambda)))

(defmethod consume-method ((mc test-method-assembler) method)
  (funcall (consume-method-lambda mc) method))

(subtest "Methods to/from frames"
  (subtest "Methods to frames"
    (subtest "Content method with content"
      (let* ((method (make-instance 'amqp-method-basic-publish :exchange "qwe"
                                                               :content #b"Hello World!"))
             (frames
               (method-to-frames method 1 14)))
        (is (length frames) 5 "Five frames")

        (is-type (first frames) 'method-frame)
        (is (frame-channel (first frames)) 1)
        (is-type (second frames) 'header-frame)
        (is (frame-channel (second frames)) 1)

        (is-type (third frames) 'body-frame)
        (is (frame-payload (third frames)) #b"Hello" :test #'equalp)
        (is (frame-channel (third frames)) 1)

        (is-type (fourth frames) 'body-frame)
        (is (frame-payload (fourth frames)) #b" Worl" :test #'equalp)
        (is (frame-channel (fourth frames)) 1)

        (is-type (fifth frames) 'body-frame)
        (is (frame-payload (fifth frames)) #b"d!" :test #'equalp)
        (is (frame-channel (fifth frames)) 1)))

    (subtest "Content method without content"
      (let* ((method (make-instance 'amqp-method-basic-publish :exchange "qwe"))
             (frames
               (method-to-frames method 2 14)))
        (is (length frames) 2 "Five frames")

        (is-type (first frames) 'method-frame)
        (is (frame-channel (first frames)) 2)
        (is-type (second frames) 'header-frame)
        (is (frame-channel (second frames)) 2)))

    (subtest "Non-content method"
      (let* ((method (make-instance 'amqp-method-queue-declare :queue "qwe"))
             (frames
               (method-to-frames method 2 14)))
        (is (length frames) 1 "Single frame")

        (is-type (first frames) 'method-frame)
        (is (frame-channel (first frames)) 2))))

  (subtest "Frames to methods"
    (subtest "Method without content"
      (let* ((method (make-instance 'amqp:amqp-method-basic-ack :delivery-tag 100))
             (frame (make-instance 'amqp:method-frame :channel 1 :payload method))
             (cb-fired)
             (assembler (make-instance 'test-method-assembler :cm-lambda (lambda (m)
                                                                           (setf cb-fired t)
                                                                           (is m method)))))
        (consume-frame assembler frame)
        (is (slot-value assembler 'amqp::state) :start)
        (is cb-fired t "callback fired")))

    (subtest "Content method without body"
      (let* ((method (make-instance 'amqp:amqp-method-basic-deliver :delivery-tag 100))
             (mframe (make-instance 'amqp:method-frame :channel 1 :payload method))
             (basic-properties (make-instance 'amqp:amqp-basic-class-properties :delivery-mode 2))
             (hframe (make-instance 'amqp:header-frame :channel 1 :body-size 0 :payload basic-properties))
             (cb-fired)
             (assembler (make-instance 'test-method-assembler :cm-lambda (lambda (m)
                                                                           (setf cb-fired t)
                                                                           (is m method)
                                                                           (is (amqp-method-content-properties m) basic-properties)))))
        (consume-frame assembler mframe)
        (consume-frame assembler hframe)
        (is (slot-value assembler 'amqp::state) :start)
        (is cb-fired t "callback fired")))

    (subtest "Content method with body"
      (let* ((method (make-instance 'amqp:amqp-method-basic-deliver :delivery-tag 100))
             (mframe (make-instance 'amqp:method-frame :channel 1 :payload method))
             (basic-properties (make-instance 'amqp:amqp-basic-class-properties :delivery-mode 2))
             (hframe (make-instance 'amqp:header-frame :channel 1 :body-size 12 :payload basic-properties))
             (cb-fired)
             (assembler (make-instance 'test-method-assembler :cm-lambda (lambda (m)
                                                                           (setf cb-fired t)
                                                                           (is m method)
                                                                           (is (amqp-method-content-properties m) basic-properties)
                                                                           (is (babel:octets-to-string (amqp-method-content m)) "Hello World!")))))
        (consume-frame assembler mframe)
        (is (slot-value assembler 'amqp::state) :header)
        (consume-frame assembler hframe)
        (is (slot-value assembler 'amqp::state) :body)
        (consume-frame assembler (make-instance 'body-frame :size 5 :payload #b"Hello"))
        (is (slot-value assembler 'amqp::state) :body)
        (consume-frame assembler (make-instance 'body-frame :size 5 :payload #b" Worl"))
        (consume-frame assembler (make-instance 'body-frame :size 2 :payload #b"d!"))
        (is (slot-value assembler 'amqp::state) :start)
        (is cb-fired t "callback fired")))

    (subtest "Frames sequence error"
      (let* ((method (make-instance 'amqp:amqp-method-basic-deliver :delivery-tag 100))
             (mframe (make-instance 'amqp:method-frame :channel 1 :payload method))
             (basic-properties (make-instance 'amqp:amqp-basic-class-properties :delivery-mode 2))
             (hframe (make-instance 'amqp:header-frame :channel 1 :body-size 12 :payload basic-properties))
             (cb-fired)
             (assembler (make-instance 'test-method-assembler :cm-lambda (lambda (m)
                                                                           (setf cb-fired t)
                                                                           (is m method)
                                                                           (is (amqp-method-content-properties m) basic-properties)
                                                                           (is (babel:octets-to-string (amqp-method-content m)) "Hello World!")))))
        (consume-frame assembler mframe)
        (is (slot-value assembler 'amqp::state) :header)
        (consume-frame assembler hframe)
        (is (slot-value assembler 'amqp::state) :body)
        (consume-frame assembler (make-instance 'body-frame :size 5 :payload #b"Hello"))
        (is-error (consume-frame assembler mframe) 'error)
        (is cb-fired nil "callback NOT fired")))

    (subtest "Max body size exceeded"
      (let* ((method (make-instance 'amqp:amqp-method-basic-deliver :delivery-tag 100))
             (mframe (make-instance 'amqp:method-frame :channel 1 :payload method))
             (basic-properties (make-instance 'amqp:amqp-basic-class-properties :delivery-mode 2))
             (hframe (make-instance 'amqp:header-frame :channel 1 :body-size #.(* 8 1024 1024) :payload basic-properties))
             (cb-fired)
             (assembler (make-instance 'test-method-assembler :cm-lambda (lambda (m)
                                                                           (setf cb-fired t)
                                                                           (is m method)
                                                                           (is (amqp-method-content-properties m) basic-properties)))))
        (consume-frame assembler mframe)
        (is-error (consume-frame assembler hframe) 'error)
        (is cb-fired nil "callback NOT fired")))))

(subtest "Method sync replies"
  (subtest "Async method"
    (let ((method (make-instance 'amqp-method-basic-publish)))
      (is (amqp-method-synchronous-p method) nil "Basic publish isn't sync method")))

  (subtest "Sync method with single reply"
    (let ((method (make-instance 'amqp-method-connection-start)))
      (multiple-value-bind (sync reply-matcher) (amqp-method-synchronous-p method)
        (is sync t "Connection.start is sync")
        (is (funcall reply-matcher (make-instance 'amqp-method-connection-start-ok)) t "Connection.StartOk is reply for Connection.Start")
        (is (funcall reply-matcher (make-instance 'amqp-method-channel-open-ok)) nil "Channel.OpenOk isn't reply for Connection.Start"))))

  (subtest "Sync method with multiple replies"
    (let ((method (make-instance 'amqp-method-basic-get)))
      (multiple-value-bind (sync reply-matcher) (amqp-method-synchronous-p method)
        (is sync t "Basic.Get is sync")
        (is (funcall reply-matcher (make-instance 'amqp-method-basic-get-ok)) t "Basic.GetOk is reply for Basic.Get")
        (is (funcall reply-matcher (make-instance 'amqp-method-basic-get-empty)) t "Basic.GetEmpty is reply for Basic.Get")
        (is (funcall reply-matcher (make-instance 'amqp-method-channel-open-ok)) nil "Channel.OpenOk isn't reply for Basic.Get")))))

(finalize)
