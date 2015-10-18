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
  (declare (type ibuffer ibuffer)
           (type fixnum count)
           (optimize (speed 3) (debug 0) (safety 0)))
  (incf (ibuffer-cursor ibuffer) count)
  (when-let ((source-buffer (ibuffer-source-buffer ibuffer)))
    (advance-cursor source-buffer count)))

(defun ibuffer-consumed-p (ibuffer)
  (declare (type ibuffer ibuffer))
  (>= (ibuffer-cursor ibuffer)
      (ibuffer-end ibuffer)))

(defun ub8-to-sb8 (byte)
  (declare (optimize (speed 3) (debug 0) (safety 0))
           (type (unsigned-byte 8) byte))
  (if (logbitp 7 byte)
      (dpb byte (byte 8 0) -1)
      byte))

(defmacro assert-ibuffer-can-advance (ibuffer count)
  `(unless (<= (+ (ibuffer-cursor ,ibuffer) ,count)
               (ibuffer-end ,ibuffer))
     (error "iBuffer overflow"))) ;; TODO: specialize error

(defmacro define-ibuffer-decoder (name advance-count &body body)
  (let ((lambda-list (if (integerp advance-count)
                    '(ibuffer)
                    (list 'ibuffer advance-count))))
    `(defun ,name ,lambda-list
       (declare (type ibuffer ibuffer)
                (optimize (speed 3) (debug 0) (safety 0)))
       (assert-ibuffer-can-advance ibuffer ,advance-count)
       (prog1 (progn
                ,@body)
         (advance-cursor ibuffer ,advance-count)))))

(define-ibuffer-decoder ibuffer-get-bytes length
  (subseq (ibuffer-buffer ibuffer)
                 (ibuffer-cursor ibuffer)
                 (+ (ibuffer-cursor ibuffer) length)))

(define-ibuffer-decoder ibuffer-decode-utf8 length
  (trivial-utf-8:utf-8-bytes-to-string (ibuffer-buffer ibuffer) :start (ibuffer-cursor ibuffer)
                                                                :end (+ (ibuffer-cursor ibuffer) length)))

(define-ibuffer-decoder ibuffer-decode-ub8 1
  (aref (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))

(define-ibuffer-decoder ibuffer-decode-sb8 1
  (ub8-to-sb8 (aref (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer))))

(define-ibuffer-decoder ibuffer-decode-sb16 2  (nibbles:sb16ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))

(define-ibuffer-decoder ibuffer-decode-sb32 4
  (nibbles:sb32ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))

(define-ibuffer-decoder ibuffer-decode-ub32 4
  (nibbles:ub32ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))

(define-ibuffer-decoder ibuffer-decode-sb64 8
  (nibbles:sb64ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))

(define-ibuffer-decoder ibuffer-decode-float 4
  (nibbles:ieee-single-ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))

(define-ibuffer-decoder ibuffer-decode-double 8
  (nibbles:ieee-double-ref/be (ibuffer-buffer ibuffer) (ibuffer-cursor ibuffer)))
