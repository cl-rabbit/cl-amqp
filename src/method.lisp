(in-package :cl-amqp)

(defun content-to-body-frames (content channel max-body-size)
  (let* ((frames-count (ceiling (length content) max-body-size))
         (content-length (length content)))
    (loop for i from 0 below frames-count
          as start-index = (* i max-body-size)
          as end-index = (+ start-index max-body-size)
          collect (make-instance 'body-frame :channel channel
                                             :payload (subseq content
                                                              start-index
                                                              (if (> end-index content-length)
                                                                  content-length
                                                                  end-index))))))

(defun method-to-frames (method channel max-frame-size)
  (let ((method-frame (make-instance 'amqp:method-frame :channel channel
                                                        :payload method)))
    (if (amqp-method-has-content-p method)
        (let ((content-header-frame (make-instance 'amqp:header-frame :channel channel
                                                                      :body-size (length (amqp-method-content method))
                                                                      :payload (amqp-method-content-properties method))))
          (if (amqp-method-content method)
              (append (list method-frame content-header-frame) (content-to-body-frames (amqp-method-content method) channel (- max-frame-size 9)))
              (list method-frame content-header-frame)))
        (list method-frame))))


(defclass method-assembler ()
  ((max-body-size :initarg :max-body-size :reader method-assembler-max-body-size :initform #.(* 4 1024 1024))
   (state :initform :start :accessor method-assembler-state)
   (current-method :accessor method-assembler-method)
   (body-bound :initform 0 :accessor method-assembler-body-bound)))

(defgeneric consume-method (mc method)
  (:method (mc method)
    method))

(defmethod reset-method-assembler-state ((ma method-assembler))
  (setf (method-assembler-state ma) :start
        (method-assembler-method ma) nil
        (method-assembler-body-bound ma) 0))

(defmethod consume-frame ((ma method-assembler) frame)
  (flet ((consume-method (ma method)
           (reset-method-assembler-state ma)
           (consume-method ma method)))
    (case (method-assembler-state ma)
      (:start ;; frame should be method-frame
       (assert (= (frame-type frame) +amqp-frame-method+))
       (if (amqp-method-has-content-p (frame-payload frame))
           (progn (setf (method-assembler-method ma) (frame-payload frame)
                        (method-assembler-state ma) :header)
                  nil)
           (consume-method ma (frame-payload frame))))
      (:header ;; frame should be header-frame
       (assert (= (frame-type frame) +amqp-frame-header+))
       (setf (slot-value (method-assembler-method ma) 'content-properties) (frame-payload frame))
       (if (= (slot-value frame 'body-size) 0)
           (consume-method ma (method-assembler-method ma))
           (progn
             (assert (< (slot-value frame 'body-size) (method-assembler-max-body-size ma)) nil "Method body is bigger than allowed") ;; TODO: specialize error
             (setf (slot-value (method-assembler-method ma) 'content) (nibbles:make-octet-vector (slot-value frame 'body-size))
                   (method-assembler-state ma) :body)
             nil)))
      (:body ;; frame should be body-frame
       (assert (= (frame-type frame) +amqp-frame-body+))
       (replace (the (simple-array (unsigned-byte 8)) (amqp-method-content (method-assembler-method ma)))
                (the (simple-array (unsigned-byte 8)) (frame-payload frame))
                :start1 (the fixnum (method-assembler-body-bound ma)))
       (incf (method-assembler-body-bound ma) (frame-payload-size frame))
       (when (= (method-assembler-body-bound ma) (length (amqp-method-content (method-assembler-method ma))))
         (consume-method ma (method-assembler-method ma)))))))
