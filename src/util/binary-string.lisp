(in-package :cl-amqp)

(defun string-to-ub8 (string)
  (let ((list (map 'list #'char-code string)))
    (make-array (length list) :element-type '(unsigned-byte 8)
                              :initial-contents list)))

(defun binary-string-reader (stream char arg)
  (string-to-ub8 (cl-interpol::interpol-reader stream char arg)))

(defun %enable-binary-string-syntax ()
  (setq *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\b #'binary-string-reader)
  (values))

(defmacro enable-binary-string-syntax ()
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (%enable-binary-string-syntax)))
