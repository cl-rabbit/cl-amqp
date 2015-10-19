(in-package :cl-amqp)

(defun new-obuffer ()
  (fast-io:make-output-buffer))

(defun obuffer-get-bytes (buffer)
  (fast-io:finish-output-buffer buffer))

(defun obuffer-encode-ub8 (buffer value)
  (fast-io:writeu8-be value buffer))

(defun obuffer-encode-sb8 (buffer value)
  (fast-io:write8-be value buffer))

(defun obuffer-encode-sb16 (buffer value)
  (fast-io:write16-be value buffer))

(defun obuffer-encode-sb32 (buffer value)
  (fast-io:write32-be value buffer))

(defun obuffer-encode-ub32 (buffer value)
  (fast-io:writeu32-be value buffer))

(defun obuffer-encode-sb64 (buffer value)
  (fast-io:write64-be value buffer))

(defun obuffer-add-bytes (buffer bytes)
  (fast-io:fast-write-sequence bytes buffer))

(defun obuffer-encode-single (buffer single)
  (let ((v (nibbles:make-octet-vector 4)))
    (setf (nibbles:ieee-single-ref/be v 0) single)
    (fast-io:fast-write-sequence v buffer)))

(defun obuffer-encode-double (buffer double)
  (let ((v (nibbles:make-octet-vector 8)))
    (setf (nibbles:ieee-double-ref/be v 0) double)
    (fast-io:fast-write-sequence v buffer)))
