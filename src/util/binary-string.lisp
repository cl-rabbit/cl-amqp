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

(defun enable-binary-string-printing ()
  (set-pprint-dispatch
   'nibbles:simple-octet-vector
   (lambda (stream vector)
     (when *print-escape*
       (princ "#b\"" stream))
     (loop for byte across vector do
              (if (or (< byte 31)
                      (> byte 126))
                  (format stream "\\x~(~2,'0x~)" byte)
                  (princ (code-char byte) stream)))
     (when *print-escape*
       (princ "\"" stream)))))

(defun disable-binary-string-printing ()
  (set-pprint-dispatch 'nibbles:simple-octet-vector nil))
