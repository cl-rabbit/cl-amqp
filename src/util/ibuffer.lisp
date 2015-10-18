(in-package :cl-amqp)

(enable-binary-string-syntax)

(defstruct ibuffer
  (buffer #b"" :type nibbles:simple-octet-vector)
  (source-buffer)
  (start 0 :type fixnum)
  (end 0 :type fixnum)
  (cursor 0 :type fixnum))

(defun new-ibuffer-from-octets (octets length)
  (make-ibuffer :buffer octets
                :start 0
                :end length
                :cursor 0))

(defun new-ibuffer-from-ibuffer (ibuffer length)
  (make-ibuffer :buffer (ibuffer-buffer ibuffer)
                :source-buffer ibuffer
                :start (ibuffer-cursor ibuffer)
                :end (+ (ibuffer-cursor ibuffer) length)
                :cursor (ibuffer-cursor ibuffer)))

(defun new-ibuffer (source &optional length)
  (typecase source 
    (nibbles:simple-octet-vector (new-ibuffer-from-octets source (or length
                                                                     (length source))))
    (ibuffer (new-ibuffer-from-ibuffer source (or length
                                                  (- (ibuffer-end source) (ibuffer-cursor source)))))
    (t (error "Invalid source for ibuffer")))) ;; TODO: specialize error

(defun advance-cursor (ibuffer count)
  (declare (type ibuffer ibuffer))
  (incf (ibuffer-cursor ibuffer) count)
  (when-let ((source-buffer (ibuffer-source-buffer ibuffer)))
    (advance-cursor source-buffer count)))

(defun ibuffer-get-bytes (ibuffer)
  (declare (type ibuffer ibuffer))
  (prog1 (subseq (ibuffer-buffer ibuffer)
                 (ibuffer-cursor ibuffer)
                 (ibuffer-end ibuffer))
    (advance-cursor ibuffer (- (ibuffer-end ibuffer) (ibuffer-cursor ibuffer)))))

(defun ibuffer-consumed-p (ibuffer)
  (declare (type ibuffer ibuffer))
  (>= (ibuffer-cursor ibuffer)
      (ibuffer-end ibuffer)))

(defun ub8-to-sb8 (byte)
  (declare (optimize (speed 3) (debug 0) (safety 0))
           (type (unsigned-byte 8)byte))
  (if (logbitp 7 byte)
      (dpb byte (byte 8 0) -1)
      byte))

(defun ibuffer-decode-ub8 (ibuffer)
  (declare (type ibuffer ibuffer))
  (prog1 (aref (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 1)))

(defun ibuffer-decode-sb8 (ibuffer)
  (declare (type ibuffer ibuffer))
  (prog1 (ub8-to-sb8 (aref (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))
    (advance-cursor ibuffer 1)))

(defun ibuffer-decode-sb16 (ibuffer)  
  (declare (type ibuffer ibuffer))
  (prog1
      (nibbles:sb16ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 2)))

(defun ibuffer-decode-sb32 (ibuffer)  
  (declare (type ibuffer ibuffer))
  (prog1
      (nibbles:sb32ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 4)))

(defun ibuffer-decode-ub32 (ibuffer)  
  (declare (type ibuffer ibuffer))
  (prog1
      (nibbles:ub32ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 4)))

(defun ibuffer-decode-sb64 (ibuffer)  
  (declare (type ibuffer ibuffer))
  (prog1
      (nibbles:sb64ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 8)))

(defun ibuffer-decode-float (ibuffer)  
  (declare (type ibuffer ibuffer))
  (prog1
      (nibbles:ieee-single-ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 4)))

(defun ibuffer-decode-double (ibuffer)  
  (declare (type ibuffer ibuffer))
  (prog1
      (nibbles:ieee-double-ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))
    (advance-cursor ibuffer 8)))
