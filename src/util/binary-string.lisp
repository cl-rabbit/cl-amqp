(in-package :cl-amqp)

(defvar *previous-readtables* nil
  "A stack which holds the previous readtables that have been pushed
here by ENABLE-BINARY-STRING-SYNTAX.")

(defun string-to-ub8 (string)
  (let ((list (map 'list #'char-code string)))
    (make-array (length list) :element-type '(unsigned-byte 8)
                              :initial-contents list)))

(defun binary-string-reader (stream char arg)
  (string-to-ub8 (cl-interpol::interpol-reader stream char arg)))

(defun %enable-binary-string-syntax ()
  (push *readtable*
        *previous-readtables*)
  (setq *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\b #'binary-string-reader)
  (values))

(defmacro enable-binary-string-syntax ()
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (%enable-binary-string-syntax)))

(defun %disable-binary-string-syntax ()
  "Internal function used to restore previous readtable." 
  (if *previous-readtables*
    (setq *readtable* (pop *previous-readtables*))
    (setq *readtable* (copy-readtable nil)))
  (values))

(defmacro disable-binary-string-syntax ()
  `(eval-when (:compile-toplevel :load-toplevel :execute)
    (%disable-binary-string-syntax)))

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
