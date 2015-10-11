(in-package :cl-amqp.test)

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

(plan 1)

(enable-binary-string-syntax)
(subtest "Testing binary string reader"
  (is #b"\x3\x0\x3\x0\x0\x0\001a\xce" #(3 0 3 0 0 0 1 97 206) :test #'equalp))

(finalize)
