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
