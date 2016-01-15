(in-package :cl-amqp.test)

(enable-binary-string-syntax)

(plan 1)

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
        (is (frame-channel (first frames)) 2)))))

(finalize)
