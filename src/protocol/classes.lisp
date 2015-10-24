;; DO NOT EDIT. RUN GENERATE TO REGENERATE


(in-package :cl-amqp)

(defclass amqp-class-base ()
  ())

(defclass amqp-method-base ()
  ())


(defclass amqp-method-connection-start (amqp-method-base)
(
  (version-major :type amqp-octet :initarg :version-major :initform 0)
  (version-minor :type amqp-octet :initarg :version-minor :initform 9)
  (server-properties :type amqp-table :initarg :server-properties)
  (mechanisms :type amqp-longstr :initarg :mechanisms :initform "PLAIN")
  (locales :type amqp-longstr :initarg :locales :initform "en_US")
))

(defun decode-amqp-method-connection-start (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-start
      :version-major (amqp-octet-decoder ibuffer)
      :version-minor (amqp-octet-decoder ibuffer)
      :server-properties (amqp-table-decoder ibuffer)
      :mechanisms (amqp-longstr-decoder ibuffer)
      :locales (amqp-longstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-start (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-octet-encoder obuffer (slot-value method 'version-major))
      (amqp-octet-encoder obuffer (slot-value method 'version-minor))
      (amqp-table-encoder obuffer (slot-value method 'server-properties))
      (amqp-longstr-encoder obuffer (slot-value method 'mechanisms))
      (amqp-longstr-encoder obuffer (slot-value method 'locales))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-start))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-start))
  nil)

(defmethod method-class-id ((method amqp-method-connection-start))
  10)

(defmethod method-method-id ((method amqp-method-connection-start))
  10)

(defclass amqp-method-connection-start-ok (amqp-method-base)
(
  (client-properties :type amqp-table :initarg :client-properties)
  (mechanism :type amqp-shortstr :initarg :mechanism :initform "PLAIN")
  (response :type amqp-longstr :initarg :response)
  (locale :type amqp-shortstr :initarg :locale :initform "en_US")
))

(defun decode-amqp-method-connection-start-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-start-ok
      :client-properties (amqp-table-decoder ibuffer)
      :mechanism (amqp-shortstr-decoder ibuffer)
      :response (amqp-longstr-decoder ibuffer)
      :locale (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-start-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-table-encoder obuffer (slot-value method 'client-properties))
      (amqp-shortstr-encoder obuffer (slot-value method 'mechanism))
      (amqp-longstr-encoder obuffer (slot-value method 'response))
      (amqp-shortstr-encoder obuffer (slot-value method 'locale))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-start-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-start-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-start-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-start-ok))
  11)

(defclass amqp-method-connection-secure (amqp-method-base)
(
  (challenge :type amqp-longstr :initarg :challenge)
))

(defun decode-amqp-method-connection-secure (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-secure
      :challenge (amqp-longstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-secure (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longstr-encoder obuffer (slot-value method 'challenge))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-secure))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-secure))
  nil)

(defmethod method-class-id ((method amqp-method-connection-secure))
  10)

(defmethod method-method-id ((method amqp-method-connection-secure))
  20)

(defclass amqp-method-connection-secure-ok (amqp-method-base)
(
  (response :type amqp-longstr :initarg :response)
))

(defun decode-amqp-method-connection-secure-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-secure-ok
      :response (amqp-longstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-secure-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longstr-encoder obuffer (slot-value method 'response))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-secure-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-secure-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-secure-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-secure-ok))
  21)

(defclass amqp-method-connection-tune (amqp-method-base)
(
  (channel-max :type amqp-short :initarg :channel-max :initform 0)
  (frame-max :type amqp-long :initarg :frame-max :initform 0)
  (heartbeat :type amqp-short :initarg :heartbeat :initform 0)
))

(defun decode-amqp-method-connection-tune (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-tune
      :channel-max (amqp-short-decoder ibuffer)
      :frame-max (amqp-long-decoder ibuffer)
      :heartbeat (amqp-short-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-tune (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'channel-max))
      (amqp-long-encoder obuffer (slot-value method 'frame-max))
      (amqp-short-encoder obuffer (slot-value method 'heartbeat))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-tune))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-tune))
  nil)

(defmethod method-class-id ((method amqp-method-connection-tune))
  10)

(defmethod method-method-id ((method amqp-method-connection-tune))
  30)

(defclass amqp-method-connection-tune-ok (amqp-method-base)
(
  (channel-max :type amqp-short :initarg :channel-max :initform 0)
  (frame-max :type amqp-long :initarg :frame-max :initform 0)
  (heartbeat :type amqp-short :initarg :heartbeat :initform 0)
))

(defun decode-amqp-method-connection-tune-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-tune-ok
      :channel-max (amqp-short-decoder ibuffer)
      :frame-max (amqp-long-decoder ibuffer)
      :heartbeat (amqp-short-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-tune-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'channel-max))
      (amqp-long-encoder obuffer (slot-value method 'frame-max))
      (amqp-short-encoder obuffer (slot-value method 'heartbeat))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-tune-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-tune-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-tune-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-tune-ok))
  31)

(defclass amqp-method-connection-open (amqp-method-base)
(
  (virtual-host :type amqp-shortstr :initarg :virtual-host :initform "/")
  (capabilities :type amqp-shortstr :initarg :capabilities :initform "")
  (insist :type amqp-bit :initarg :insist :initform :false)
))

(defun decode-amqp-method-connection-open (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-open
      :virtual-host (amqp-shortstr-decoder ibuffer)
      :capabilities (amqp-shortstr-decoder ibuffer)
      :insist (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-connection-open (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'virtual-host))
      (amqp-shortstr-encoder obuffer (slot-value method 'capabilities))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'insist)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-open))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-open))
  nil)

(defmethod method-class-id ((method amqp-method-connection-open))
  10)

(defmethod method-method-id ((method amqp-method-connection-open))
  40)

(defclass amqp-method-connection-open-ok (amqp-method-base)
(
  (known-hosts :type amqp-shortstr :initarg :known-hosts :initform "")
))

(defun decode-amqp-method-connection-open-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-open-ok
      :known-hosts (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-open-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'known-hosts))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-open-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-open-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-open-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-open-ok))
  41)

(defclass amqp-method-connection-close (amqp-method-base)
(
  (reply-code :type amqp-short :initarg :reply-code)
  (reply-text :type amqp-shortstr :initarg :reply-text :initform "")
  (class-id :type amqp-short :initarg :class-id)
  (method-id :type amqp-short :initarg :method-id)
))

(defun decode-amqp-method-connection-close (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-close
      :reply-code (amqp-short-decoder ibuffer)
      :reply-text (amqp-shortstr-decoder ibuffer)
      :class-id (amqp-short-decoder ibuffer)
      :method-id (amqp-short-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-close (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'reply-code))
      (amqp-shortstr-encoder obuffer (slot-value method 'reply-text))
      (amqp-short-encoder obuffer (slot-value method 'class-id))
      (amqp-short-encoder obuffer (slot-value method 'method-id))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-close))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-close))
  nil)

(defmethod method-class-id ((method amqp-method-connection-close))
  10)

(defmethod method-method-id ((method amqp-method-connection-close))
  50)

(defclass amqp-method-connection-close-ok (amqp-method-base)
(
))

(defun decode-amqp-method-connection-close-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-connection-close-ok)
)

(defun encode-amqp-method-connection-close-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-connection-close-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-close-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-close-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-close-ok))
  51)

(defclass amqp-method-connection-blocked (amqp-method-base)
(
  (reason :type amqp-shortstr :initarg :reason :initform "")
))

(defun decode-amqp-method-connection-blocked (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-connection-blocked
      :reason (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-connection-blocked (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'reason))
  )
)

(defmethod synchronous-method-p ((method amqp-method-connection-blocked))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-blocked))
  nil)

(defmethod method-class-id ((method amqp-method-connection-blocked))
  10)

(defmethod method-method-id ((method amqp-method-connection-blocked))
  60)

(defclass amqp-method-connection-unblocked (amqp-method-base)
(
))

(defun decode-amqp-method-connection-unblocked (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-connection-unblocked)
)

(defun encode-amqp-method-connection-unblocked (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-connection-unblocked))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-unblocked))
  nil)

(defmethod method-class-id ((method amqp-method-connection-unblocked))
  10)

(defmethod method-method-id ((method amqp-method-connection-unblocked))
  61)

(defclass amqp-method-channel-open (amqp-method-base)
(
  (out-of-band :type amqp-shortstr :initarg :out-of-band :initform "")
))

(defun decode-amqp-method-channel-open (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-channel-open
      :out-of-band (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-channel-open (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'out-of-band))
  )
)

(defmethod synchronous-method-p ((method amqp-method-channel-open))
  t)

(defmethod method-has-content-p ((method amqp-method-channel-open))
  nil)

(defmethod method-class-id ((method amqp-method-channel-open))
  20)

(defmethod method-method-id ((method amqp-method-channel-open))
  10)

(defclass amqp-method-channel-open-ok (amqp-method-base)
(
  (channel-id :type amqp-longstr :initarg :channel-id :initform "")
))

(defun decode-amqp-method-channel-open-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-channel-open-ok
      :channel-id (amqp-longstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-channel-open-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longstr-encoder obuffer (slot-value method 'channel-id))
  )
)

(defmethod synchronous-method-p ((method amqp-method-channel-open-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-channel-open-ok))
  nil)

(defmethod method-class-id ((method amqp-method-channel-open-ok))
  20)

(defmethod method-method-id ((method amqp-method-channel-open-ok))
  11)

(defclass amqp-method-channel-flow (amqp-method-base)
(
  (active :type amqp-bit :initarg :active)
))

(defun decode-amqp-method-channel-flow (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-channel-flow
      :active (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-channel-flow (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'active)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-channel-flow))
  t)

(defmethod method-has-content-p ((method amqp-method-channel-flow))
  nil)

(defmethod method-class-id ((method amqp-method-channel-flow))
  20)

(defmethod method-method-id ((method amqp-method-channel-flow))
  20)

(defclass amqp-method-channel-flow-ok (amqp-method-base)
(
  (active :type amqp-bit :initarg :active)
))

(defun decode-amqp-method-channel-flow-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-channel-flow-ok
      :active (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-channel-flow-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'active)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-channel-flow-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-channel-flow-ok))
  nil)

(defmethod method-class-id ((method amqp-method-channel-flow-ok))
  20)

(defmethod method-method-id ((method amqp-method-channel-flow-ok))
  21)

(defclass amqp-method-channel-close (amqp-method-base)
(
  (reply-code :type amqp-short :initarg :reply-code)
  (reply-text :type amqp-shortstr :initarg :reply-text :initform "")
  (class-id :type amqp-short :initarg :class-id)
  (method-id :type amqp-short :initarg :method-id)
))

(defun decode-amqp-method-channel-close (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-channel-close
      :reply-code (amqp-short-decoder ibuffer)
      :reply-text (amqp-shortstr-decoder ibuffer)
      :class-id (amqp-short-decoder ibuffer)
      :method-id (amqp-short-decoder ibuffer)
  ))
)

(defun encode-amqp-method-channel-close (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'reply-code))
      (amqp-shortstr-encoder obuffer (slot-value method 'reply-text))
      (amqp-short-encoder obuffer (slot-value method 'class-id))
      (amqp-short-encoder obuffer (slot-value method 'method-id))
  )
)

(defmethod synchronous-method-p ((method amqp-method-channel-close))
  t)

(defmethod method-has-content-p ((method amqp-method-channel-close))
  nil)

(defmethod method-class-id ((method amqp-method-channel-close))
  20)

(defmethod method-method-id ((method amqp-method-channel-close))
  40)

(defclass amqp-method-channel-close-ok (amqp-method-base)
(
))

(defun decode-amqp-method-channel-close-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-channel-close-ok)
)

(defun encode-amqp-method-channel-close-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-channel-close-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-channel-close-ok))
  nil)

(defmethod method-class-id ((method amqp-method-channel-close-ok))
  20)

(defmethod method-method-id ((method amqp-method-channel-close-ok))
  41)

(defclass amqp-method-access-request (amqp-method-base)
(
  (realm :type amqp-shortstr :initarg :realm :initform "/data")
  (exclusive :type amqp-bit :initarg :exclusive :initform :false)
  (passive :type amqp-bit :initarg :passive :initform t)
  (active :type amqp-bit :initarg :active :initform t)
  (write :type amqp-bit :initarg :write :initform t)
  (read :type amqp-bit :initarg :read :initform t)
))

(defun decode-amqp-method-access-request (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-access-request
      :realm (amqp-shortstr-decoder ibuffer)
      :exclusive (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :passive (not (zerop (ldb (byte 8 1) bit-buffer)))
      :active (not (zerop (ldb (byte 8 2) bit-buffer)))
      :write (not (zerop (ldb (byte 8 3) bit-buffer)))
      :read (not (zerop (ldb (byte 8 4) bit-buffer)))
  ))
)

(defun encode-amqp-method-access-request (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'realm))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'exclusive)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'passive)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (when (eq t (slot-value method 'active)) (setf (ldb (byte 8 2) bit-buffer) 1))
      (when (eq t (slot-value method 'write)) (setf (ldb (byte 8 3) bit-buffer) 1))
      (when (eq t (slot-value method 'read)) (setf (ldb (byte 8 4) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-access-request))
  t)

(defmethod method-has-content-p ((method amqp-method-access-request))
  nil)

(defmethod method-class-id ((method amqp-method-access-request))
  30)

(defmethod method-method-id ((method amqp-method-access-request))
  10)

(defclass amqp-method-access-request-ok (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 1)
))

(defun decode-amqp-method-access-request-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-access-request-ok
      :ticket (amqp-short-decoder ibuffer)
  ))
)

(defun encode-amqp-method-access-request-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
  )
)

(defmethod synchronous-method-p ((method amqp-method-access-request-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-access-request-ok))
  nil)

(defmethod method-class-id ((method amqp-method-access-request-ok))
  30)

(defmethod method-method-id ((method amqp-method-access-request-ok))
  11)

(defclass amqp-method-exchange-declare (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (exchange :type amqp-shortstr :initarg :exchange)
  (type :type amqp-shortstr :initarg :type :initform "direct")
  (passive :type amqp-bit :initarg :passive :initform :false)
  (durable :type amqp-bit :initarg :durable :initform :false)
  (auto-delete :type amqp-bit :initarg :auto-delete :initform :false)
  (internal :type amqp-bit :initarg :internal :initform :false)
  (nowait :type amqp-bit :initarg :nowait :initform :false)
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-exchange-declare (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-exchange-declare
      :ticket (amqp-short-decoder ibuffer)
      :exchange (amqp-shortstr-decoder ibuffer)
      :type (amqp-shortstr-decoder ibuffer)
      :passive (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :durable (not (zerop (ldb (byte 8 1) bit-buffer)))
      :auto-delete (not (zerop (ldb (byte 8 2) bit-buffer)))
      :internal (not (zerop (ldb (byte 8 3) bit-buffer)))
      :nowait (not (zerop (ldb (byte 8 4) bit-buffer)))
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-exchange-declare (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'type))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'passive)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'durable)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (when (eq t (slot-value method 'auto-delete)) (setf (ldb (byte 8 2) bit-buffer) 1))
      (when (eq t (slot-value method 'internal)) (setf (ldb (byte 8 3) bit-buffer) 1))
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 4) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-exchange-declare))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-declare))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-declare))
  40)

(defmethod method-method-id ((method amqp-method-exchange-declare))
  10)

(defclass amqp-method-exchange-declare-ok (amqp-method-base)
(
))

(defun decode-amqp-method-exchange-declare-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-exchange-declare-ok)
)

(defun encode-amqp-method-exchange-declare-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-exchange-declare-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-declare-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-declare-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-declare-ok))
  11)

(defclass amqp-method-exchange-delete (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (exchange :type amqp-shortstr :initarg :exchange)
  (if-unused :type amqp-bit :initarg :if-unused :initform :false)
  (nowait :type amqp-bit :initarg :nowait :initform :false)
))

(defun decode-amqp-method-exchange-delete (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-exchange-delete
      :ticket (amqp-short-decoder ibuffer)
      :exchange (amqp-shortstr-decoder ibuffer)
      :if-unused (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :nowait (not (zerop (ldb (byte 8 1) bit-buffer)))
  ))
)

(defun encode-amqp-method-exchange-delete (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'if-unused)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-exchange-delete))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-delete))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-delete))
  40)

(defmethod method-method-id ((method amqp-method-exchange-delete))
  20)

(defclass amqp-method-exchange-delete-ok (amqp-method-base)
(
))

(defun decode-amqp-method-exchange-delete-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-exchange-delete-ok)
)

(defun encode-amqp-method-exchange-delete-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-exchange-delete-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-delete-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-delete-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-delete-ok))
  21)

(defclass amqp-method-exchange-bind (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (destination :type amqp-shortstr :initarg :destination)
  (source :type amqp-shortstr :initarg :source)
  (routing-key :type amqp-shortstr :initarg :routing-key :initform "")
  (nowait :type amqp-bit :initarg :nowait :initform :false)
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-exchange-bind (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-exchange-bind
      :ticket (amqp-short-decoder ibuffer)
      :destination (amqp-shortstr-decoder ibuffer)
      :source (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
      :nowait (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-exchange-bind (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'destination))
      (amqp-shortstr-encoder obuffer (slot-value method 'source))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-exchange-bind))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-bind))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-bind))
  40)

(defmethod method-method-id ((method amqp-method-exchange-bind))
  30)

(defclass amqp-method-exchange-bind-ok (amqp-method-base)
(
))

(defun decode-amqp-method-exchange-bind-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-exchange-bind-ok)
)

(defun encode-amqp-method-exchange-bind-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-exchange-bind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-bind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-bind-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-bind-ok))
  31)

(defclass amqp-method-exchange-unbind (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (destination :type amqp-shortstr :initarg :destination)
  (source :type amqp-shortstr :initarg :source)
  (routing-key :type amqp-shortstr :initarg :routing-key :initform "")
  (nowait :type amqp-bit :initarg :nowait :initform :false)
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-exchange-unbind (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-exchange-unbind
      :ticket (amqp-short-decoder ibuffer)
      :destination (amqp-shortstr-decoder ibuffer)
      :source (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
      :nowait (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-exchange-unbind (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'destination))
      (amqp-shortstr-encoder obuffer (slot-value method 'source))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-exchange-unbind))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-unbind))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-unbind))
  40)

(defmethod method-method-id ((method amqp-method-exchange-unbind))
  40)

(defclass amqp-method-exchange-unbind-ok (amqp-method-base)
(
))

(defun decode-amqp-method-exchange-unbind-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-exchange-unbind-ok)
)

(defun encode-amqp-method-exchange-unbind-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-exchange-unbind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-unbind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-unbind-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-unbind-ok))
  51)

(defclass amqp-method-queue-declare (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (passive :type amqp-bit :initarg :passive :initform :false)
  (durable :type amqp-bit :initarg :durable :initform :false)
  (exclusive :type amqp-bit :initarg :exclusive :initform :false)
  (auto-delete :type amqp-bit :initarg :auto-delete :initform :false)
  (nowait :type amqp-bit :initarg :nowait :initform :false)
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-queue-declare (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-declare
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :passive (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :durable (not (zerop (ldb (byte 8 1) bit-buffer)))
      :exclusive (not (zerop (ldb (byte 8 2) bit-buffer)))
      :auto-delete (not (zerop (ldb (byte 8 3) bit-buffer)))
      :nowait (not (zerop (ldb (byte 8 4) bit-buffer)))
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-queue-declare (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'passive)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'durable)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (when (eq t (slot-value method 'exclusive)) (setf (ldb (byte 8 2) bit-buffer) 1))
      (when (eq t (slot-value method 'auto-delete)) (setf (ldb (byte 8 3) bit-buffer) 1))
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 4) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-declare))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-declare))
  nil)

(defmethod method-class-id ((method amqp-method-queue-declare))
  50)

(defmethod method-method-id ((method amqp-method-queue-declare))
  10)

(defclass amqp-method-queue-declare-ok (amqp-method-base)
(
  (queue :type amqp-shortstr :initarg :queue)
  (message-count :type amqp-long :initarg :message-count)
  (consumer-count :type amqp-long :initarg :consumer-count)
))

(defun decode-amqp-method-queue-declare-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-declare-ok
      :queue (amqp-shortstr-decoder ibuffer)
      :message-count (amqp-long-decoder ibuffer)
      :consumer-count (amqp-long-decoder ibuffer)
  ))
)

(defun encode-amqp-method-queue-declare-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (amqp-long-encoder obuffer (slot-value method 'message-count))
      (amqp-long-encoder obuffer (slot-value method 'consumer-count))
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-declare-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-declare-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-declare-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-declare-ok))
  11)

(defclass amqp-method-queue-bind (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (exchange :type amqp-shortstr :initarg :exchange)
  (routing-key :type amqp-shortstr :initarg :routing-key :initform "")
  (nowait :type amqp-bit :initarg :nowait :initform :false)
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-queue-bind (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-bind
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :exchange (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
      :nowait (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-queue-bind (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-bind))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-bind))
  nil)

(defmethod method-class-id ((method amqp-method-queue-bind))
  50)

(defmethod method-method-id ((method amqp-method-queue-bind))
  20)

(defclass amqp-method-queue-bind-ok (amqp-method-base)
(
))

(defun decode-amqp-method-queue-bind-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-queue-bind-ok)
)

(defun encode-amqp-method-queue-bind-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-queue-bind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-bind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-bind-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-bind-ok))
  21)

(defclass amqp-method-queue-purge (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (nowait :type amqp-bit :initarg :nowait :initform :false)
))

(defun decode-amqp-method-queue-purge (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-purge
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :nowait (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-queue-purge (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-purge))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-purge))
  nil)

(defmethod method-class-id ((method amqp-method-queue-purge))
  50)

(defmethod method-method-id ((method amqp-method-queue-purge))
  30)

(defclass amqp-method-queue-purge-ok (amqp-method-base)
(
  (message-count :type amqp-long :initarg :message-count)
))

(defun decode-amqp-method-queue-purge-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-purge-ok
      :message-count (amqp-long-decoder ibuffer)
  ))
)

(defun encode-amqp-method-queue-purge-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-long-encoder obuffer (slot-value method 'message-count))
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-purge-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-purge-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-purge-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-purge-ok))
  31)

(defclass amqp-method-queue-delete (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (if-unused :type amqp-bit :initarg :if-unused :initform :false)
  (if-empty :type amqp-bit :initarg :if-empty :initform :false)
  (nowait :type amqp-bit :initarg :nowait :initform :false)
))

(defun decode-amqp-method-queue-delete (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-delete
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :if-unused (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :if-empty (not (zerop (ldb (byte 8 1) bit-buffer)))
      :nowait (not (zerop (ldb (byte 8 2) bit-buffer)))
  ))
)

(defun encode-amqp-method-queue-delete (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'if-unused)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'if-empty)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 2) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-delete))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-delete))
  nil)

(defmethod method-class-id ((method amqp-method-queue-delete))
  50)

(defmethod method-method-id ((method amqp-method-queue-delete))
  40)

(defclass amqp-method-queue-delete-ok (amqp-method-base)
(
  (message-count :type amqp-long :initarg :message-count)
))

(defun decode-amqp-method-queue-delete-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-delete-ok
      :message-count (amqp-long-decoder ibuffer)
  ))
)

(defun encode-amqp-method-queue-delete-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-long-encoder obuffer (slot-value method 'message-count))
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-delete-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-delete-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-delete-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-delete-ok))
  41)

(defclass amqp-method-queue-unbind (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (exchange :type amqp-shortstr :initarg :exchange)
  (routing-key :type amqp-shortstr :initarg :routing-key :initform "")
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-queue-unbind (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-queue-unbind
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :exchange (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-queue-unbind (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-queue-unbind))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-unbind))
  nil)

(defmethod method-class-id ((method amqp-method-queue-unbind))
  50)

(defmethod method-method-id ((method amqp-method-queue-unbind))
  50)

(defclass amqp-method-queue-unbind-ok (amqp-method-base)
(
))

(defun decode-amqp-method-queue-unbind-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-queue-unbind-ok)
)

(defun encode-amqp-method-queue-unbind-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-queue-unbind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-unbind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-unbind-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-unbind-ok))
  51)

(defclass amqp-method-basic-qos (amqp-method-base)
(
  (prefetch-size :type amqp-long :initarg :prefetch-size :initform 0)
  (prefetch-count :type amqp-short :initarg :prefetch-count :initform 0)
  (global :type amqp-bit :initarg :global :initform :false)
))

(defun decode-amqp-method-basic-qos (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-qos
      :prefetch-size (amqp-long-decoder ibuffer)
      :prefetch-count (amqp-short-decoder ibuffer)
      :global (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-qos (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-long-encoder obuffer (slot-value method 'prefetch-size))
      (amqp-short-encoder obuffer (slot-value method 'prefetch-count))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'global)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-qos))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-qos))
  nil)

(defmethod method-class-id ((method amqp-method-basic-qos))
  60)

(defmethod method-method-id ((method amqp-method-basic-qos))
  10)

(defclass amqp-method-basic-qos-ok (amqp-method-base)
(
))

(defun decode-amqp-method-basic-qos-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-basic-qos-ok)
)

(defun encode-amqp-method-basic-qos-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-basic-qos-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-qos-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-qos-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-qos-ok))
  11)

(defclass amqp-method-basic-consume (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (consumer-tag :type amqp-shortstr :initarg :consumer-tag :initform "")
  (no-local :type amqp-bit :initarg :no-local :initform :false)
  (no-ack :type amqp-bit :initarg :no-ack :initform :false)
  (exclusive :type amqp-bit :initarg :exclusive :initform :false)
  (nowait :type amqp-bit :initarg :nowait :initform :false)
  (arguments :type amqp-table :initarg :arguments :initform nil)
))

(defun decode-amqp-method-basic-consume (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-consume
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :consumer-tag (amqp-shortstr-decoder ibuffer)
      :no-local (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :no-ack (not (zerop (ldb (byte 8 1) bit-buffer)))
      :exclusive (not (zerop (ldb (byte 8 2) bit-buffer)))
      :nowait (not (zerop (ldb (byte 8 3) bit-buffer)))
      :arguments (amqp-table-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-consume (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (amqp-shortstr-encoder obuffer (slot-value method 'consumer-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'no-local)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'no-ack)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (when (eq t (slot-value method 'exclusive)) (setf (ldb (byte 8 2) bit-buffer) 1))
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 3) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-table-encoder obuffer (slot-value method 'arguments))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-consume))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-consume))
  nil)

(defmethod method-class-id ((method amqp-method-basic-consume))
  60)

(defmethod method-method-id ((method amqp-method-basic-consume))
  20)

(defclass amqp-method-basic-consume-ok (amqp-method-base)
(
  (consumer-tag :type amqp-shortstr :initarg :consumer-tag)
))

(defun decode-amqp-method-basic-consume-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-consume-ok
      :consumer-tag (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-consume-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'consumer-tag))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-consume-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-consume-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-consume-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-consume-ok))
  21)

(defclass amqp-method-basic-cancel (amqp-method-base)
(
  (consumer-tag :type amqp-shortstr :initarg :consumer-tag)
  (nowait :type amqp-bit :initarg :nowait :initform :false)
))

(defun decode-amqp-method-basic-cancel (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-cancel
      :consumer-tag (amqp-shortstr-decoder ibuffer)
      :nowait (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-cancel (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'consumer-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-cancel))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-cancel))
  nil)

(defmethod method-class-id ((method amqp-method-basic-cancel))
  60)

(defmethod method-method-id ((method amqp-method-basic-cancel))
  30)

(defclass amqp-method-basic-cancel-ok (amqp-method-base)
(
  (consumer-tag :type amqp-shortstr :initarg :consumer-tag)
))

(defun decode-amqp-method-basic-cancel-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-cancel-ok
      :consumer-tag (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-cancel-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'consumer-tag))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-cancel-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-cancel-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-cancel-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-cancel-ok))
  31)

(defclass amqp-method-basic-publish (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (exchange :type amqp-shortstr :initarg :exchange :initform "")
  (routing-key :type amqp-shortstr :initarg :routing-key :initform "")
  (mandatory :type amqp-bit :initarg :mandatory :initform :false)
  (immediate :type amqp-bit :initarg :immediate :initform :false)
))

(defun decode-amqp-method-basic-publish (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-publish
      :ticket (amqp-short-decoder ibuffer)
      :exchange (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
      :mandatory (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :immediate (not (zerop (ldb (byte 8 1) bit-buffer)))
  ))
)

(defun encode-amqp-method-basic-publish (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'mandatory)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'immediate)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-publish))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-publish))
  t)

(defmethod method-class-id ((method amqp-method-basic-publish))
  60)

(defmethod method-method-id ((method amqp-method-basic-publish))
  40)

(defclass amqp-method-basic-return (amqp-method-base)
(
  (reply-code :type amqp-short :initarg :reply-code)
  (reply-text :type amqp-shortstr :initarg :reply-text :initform "")
  (exchange :type amqp-shortstr :initarg :exchange)
  (routing-key :type amqp-shortstr :initarg :routing-key)
))

(defun decode-amqp-method-basic-return (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-return
      :reply-code (amqp-short-decoder ibuffer)
      :reply-text (amqp-shortstr-decoder ibuffer)
      :exchange (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-return (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'reply-code))
      (amqp-shortstr-encoder obuffer (slot-value method 'reply-text))
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-return))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-return))
  t)

(defmethod method-class-id ((method amqp-method-basic-return))
  60)

(defmethod method-method-id ((method amqp-method-basic-return))
  50)

(defclass amqp-method-basic-deliver (amqp-method-base)
(
  (consumer-tag :type amqp-shortstr :initarg :consumer-tag)
  (delivery-tag :type amqp-longlong :initarg :delivery-tag)
  (redelivered :type amqp-bit :initarg :redelivered :initform :false)
  (exchange :type amqp-shortstr :initarg :exchange)
  (routing-key :type amqp-shortstr :initarg :routing-key)
))

(defun decode-amqp-method-basic-deliver (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-deliver
      :consumer-tag (amqp-shortstr-decoder ibuffer)
      :delivery-tag (amqp-longlong-decoder ibuffer)
      :redelivered (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :exchange (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-deliver (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'consumer-tag))
      (amqp-longlong-encoder obuffer (slot-value method 'delivery-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'redelivered)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-deliver))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-deliver))
  t)

(defmethod method-class-id ((method amqp-method-basic-deliver))
  60)

(defmethod method-method-id ((method amqp-method-basic-deliver))
  60)

(defclass amqp-method-basic-get (amqp-method-base)
(
  (ticket :type amqp-short :initarg :ticket :initform 0)
  (queue :type amqp-shortstr :initarg :queue :initform "")
  (no-ack :type amqp-bit :initarg :no-ack :initform :false)
))

(defun decode-amqp-method-basic-get (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-get
      :ticket (amqp-short-decoder ibuffer)
      :queue (amqp-shortstr-decoder ibuffer)
      :no-ack (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-get (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-short-encoder obuffer (slot-value method 'ticket))
      (amqp-shortstr-encoder obuffer (slot-value method 'queue))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'no-ack)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-get))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-get))
  nil)

(defmethod method-class-id ((method amqp-method-basic-get))
  60)

(defmethod method-method-id ((method amqp-method-basic-get))
  70)

(defclass amqp-method-basic-get-ok (amqp-method-base)
(
  (delivery-tag :type amqp-longlong :initarg :delivery-tag)
  (redelivered :type amqp-bit :initarg :redelivered :initform :false)
  (exchange :type amqp-shortstr :initarg :exchange)
  (routing-key :type amqp-shortstr :initarg :routing-key)
  (message-count :type amqp-long :initarg :message-count)
))

(defun decode-amqp-method-basic-get-ok (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-get-ok
      :delivery-tag (amqp-longlong-decoder ibuffer)
      :redelivered (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :exchange (amqp-shortstr-decoder ibuffer)
      :routing-key (amqp-shortstr-decoder ibuffer)
      :message-count (amqp-long-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-get-ok (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longlong-encoder obuffer (slot-value method 'delivery-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'redelivered)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
      (amqp-shortstr-encoder obuffer (slot-value method 'exchange))
      (amqp-shortstr-encoder obuffer (slot-value method 'routing-key))
      (amqp-long-encoder obuffer (slot-value method 'message-count))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-get-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-get-ok))
  t)

(defmethod method-class-id ((method amqp-method-basic-get-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-get-ok))
  71)

(defclass amqp-method-basic-get-empty (amqp-method-base)
(
  (cluster-id :type amqp-shortstr :initarg :cluster-id :initform "")
))

(defun decode-amqp-method-basic-get-empty (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-get-empty
      :cluster-id (amqp-shortstr-decoder ibuffer)
  ))
)

(defun encode-amqp-method-basic-get-empty (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-shortstr-encoder obuffer (slot-value method 'cluster-id))
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-get-empty))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-get-empty))
  nil)

(defmethod method-class-id ((method amqp-method-basic-get-empty))
  60)

(defmethod method-method-id ((method amqp-method-basic-get-empty))
  72)

(defclass amqp-method-basic-ack (amqp-method-base)
(
  (delivery-tag :type amqp-longlong :initarg :delivery-tag :initform 0)
  (multiple :type amqp-bit :initarg :multiple :initform :false)
))

(defun decode-amqp-method-basic-ack (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-ack
      :delivery-tag (amqp-longlong-decoder ibuffer)
      :multiple (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-ack (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longlong-encoder obuffer (slot-value method 'delivery-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'multiple)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-ack))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-ack))
  nil)

(defmethod method-class-id ((method amqp-method-basic-ack))
  60)

(defmethod method-method-id ((method amqp-method-basic-ack))
  80)

(defclass amqp-method-basic-reject (amqp-method-base)
(
  (delivery-tag :type amqp-longlong :initarg :delivery-tag)
  (requeue :type amqp-bit :initarg :requeue :initform t)
))

(defun decode-amqp-method-basic-reject (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-reject
      :delivery-tag (amqp-longlong-decoder ibuffer)
      :requeue (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-reject (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longlong-encoder obuffer (slot-value method 'delivery-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'requeue)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-reject))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-reject))
  nil)

(defmethod method-class-id ((method amqp-method-basic-reject))
  60)

(defmethod method-method-id ((method amqp-method-basic-reject))
  90)

(defclass amqp-method-basic-recover-async (amqp-method-base)
(
  (requeue :type amqp-bit :initarg :requeue :initform :false)
))

(defun decode-amqp-method-basic-recover-async (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-recover-async
      :requeue (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-recover-async (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'requeue)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-recover-async))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-recover-async))
  nil)

(defmethod method-class-id ((method amqp-method-basic-recover-async))
  60)

(defmethod method-method-id ((method amqp-method-basic-recover-async))
  100)

(defclass amqp-method-basic-recover (amqp-method-base)
(
  (requeue :type amqp-bit :initarg :requeue :initform :false)
))

(defun decode-amqp-method-basic-recover (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-recover
      :requeue (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-basic-recover (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'requeue)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-recover))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-recover))
  nil)

(defmethod method-class-id ((method amqp-method-basic-recover))
  60)

(defmethod method-method-id ((method amqp-method-basic-recover))
  110)

(defclass amqp-method-basic-recover-ok (amqp-method-base)
(
))

(defun decode-amqp-method-basic-recover-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-basic-recover-ok)
)

(defun encode-amqp-method-basic-recover-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-basic-recover-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-recover-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-recover-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-recover-ok))
  111)

(defclass amqp-method-basic-nack (amqp-method-base)
(
  (delivery-tag :type amqp-longlong :initarg :delivery-tag :initform 0)
  (multiple :type amqp-bit :initarg :multiple :initform :false)
  (requeue :type amqp-bit :initarg :requeue :initform t)
))

(defun decode-amqp-method-basic-nack (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-basic-nack
      :delivery-tag (amqp-longlong-decoder ibuffer)
      :multiple (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
      :requeue (not (zerop (ldb (byte 8 1) bit-buffer)))
  ))
)

(defun encode-amqp-method-basic-nack (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (amqp-longlong-encoder obuffer (slot-value method 'delivery-tag))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'multiple)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (when (eq t (slot-value method 'requeue)) (setf (ldb (byte 8 1) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-basic-nack))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-nack))
  nil)

(defmethod method-class-id ((method amqp-method-basic-nack))
  60)

(defmethod method-method-id ((method amqp-method-basic-nack))
  120)

(defclass amqp-method-tx-select (amqp-method-base)
(
))

(defun decode-amqp-method-tx-select (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-tx-select)
)

(defun encode-amqp-method-tx-select (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-tx-select))
  t)

(defmethod method-has-content-p ((method amqp-method-tx-select))
  nil)

(defmethod method-class-id ((method amqp-method-tx-select))
  90)

(defmethod method-method-id ((method amqp-method-tx-select))
  10)

(defclass amqp-method-tx-select-ok (amqp-method-base)
(
))

(defun decode-amqp-method-tx-select-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-tx-select-ok)
)

(defun encode-amqp-method-tx-select-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-tx-select-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-tx-select-ok))
  nil)

(defmethod method-class-id ((method amqp-method-tx-select-ok))
  90)

(defmethod method-method-id ((method amqp-method-tx-select-ok))
  11)

(defclass amqp-method-tx-commit (amqp-method-base)
(
))

(defun decode-amqp-method-tx-commit (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-tx-commit)
)

(defun encode-amqp-method-tx-commit (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-tx-commit))
  t)

(defmethod method-has-content-p ((method amqp-method-tx-commit))
  nil)

(defmethod method-class-id ((method amqp-method-tx-commit))
  90)

(defmethod method-method-id ((method amqp-method-tx-commit))
  20)

(defclass amqp-method-tx-commit-ok (amqp-method-base)
(
))

(defun decode-amqp-method-tx-commit-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-tx-commit-ok)
)

(defun encode-amqp-method-tx-commit-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-tx-commit-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-tx-commit-ok))
  nil)

(defmethod method-class-id ((method amqp-method-tx-commit-ok))
  90)

(defmethod method-method-id ((method amqp-method-tx-commit-ok))
  21)

(defclass amqp-method-tx-rollback (amqp-method-base)
(
))

(defun decode-amqp-method-tx-rollback (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-tx-rollback)
)

(defun encode-amqp-method-tx-rollback (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-tx-rollback))
  t)

(defmethod method-has-content-p ((method amqp-method-tx-rollback))
  nil)

(defmethod method-class-id ((method amqp-method-tx-rollback))
  90)

(defmethod method-method-id ((method amqp-method-tx-rollback))
  30)

(defclass amqp-method-tx-rollback-ok (amqp-method-base)
(
))

(defun decode-amqp-method-tx-rollback-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-tx-rollback-ok)
)

(defun encode-amqp-method-tx-rollback-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-tx-rollback-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-tx-rollback-ok))
  nil)

(defmethod method-class-id ((method amqp-method-tx-rollback-ok))
  90)

(defmethod method-method-id ((method amqp-method-tx-rollback-ok))
  31)

(defclass amqp-method-confirm-select (amqp-method-base)
(
  (nowait :type amqp-bit :initarg :nowait :initform :false)
))

(defun decode-amqp-method-confirm-select (ibuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
    (make-instance 'amqp-method-confirm-select
      :nowait (progn
        (setf bit-buffer (ibuffer-decode-ub8 ibuffer))
        (not (zerop (ldb (byte 8 0) bit-buffer))))
  ))
)

(defun encode-amqp-method-confirm-select (method obuffer)
  (let ((bit-buffer 0))
    (declare (type (unsigned-byte 8) bit-buffer)
             (ignorable bit-buffer))
      (setf bit-buffer 0)
      (when (eq t (slot-value method 'nowait)) (setf (ldb (byte 8 0) bit-buffer) 1))
      (amqp-octet-encoder obuffer bit-buffer)
  )
)

(defmethod synchronous-method-p ((method amqp-method-confirm-select))
  t)

(defmethod method-has-content-p ((method amqp-method-confirm-select))
  nil)

(defmethod method-class-id ((method amqp-method-confirm-select))
  85)

(defmethod method-method-id ((method amqp-method-confirm-select))
  10)

(defclass amqp-method-confirm-select-ok (amqp-method-base)
(
))

(defun decode-amqp-method-confirm-select-ok (ibuffer)
  (declare (ignore ibuffer))
  (make-instance 'amqp-method-confirm-select-ok)
)

(defun encode-amqp-method-confirm-select-ok (method obuffer)
  (declare (ignore method obuffer))
)

(defmethod synchronous-method-p ((method amqp-method-confirm-select-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-confirm-select-ok))
  nil)

(defmethod method-class-id ((method amqp-method-confirm-select-ok))
  85)

(defmethod method-method-id ((method amqp-method-confirm-select-ok))
  11)


(defun method-decode (method-class ibuffer)
  (case method-class
    (amqp-method-connection-start (decode-amqp-method-connection-start ibuffer))
    (amqp-method-connection-start-ok (decode-amqp-method-connection-start-ok ibuffer))
    (amqp-method-connection-secure (decode-amqp-method-connection-secure ibuffer))
    (amqp-method-connection-secure-ok (decode-amqp-method-connection-secure-ok ibuffer))
    (amqp-method-connection-tune (decode-amqp-method-connection-tune ibuffer))
    (amqp-method-connection-tune-ok (decode-amqp-method-connection-tune-ok ibuffer))
    (amqp-method-connection-open (decode-amqp-method-connection-open ibuffer))
    (amqp-method-connection-open-ok (decode-amqp-method-connection-open-ok ibuffer))
    (amqp-method-connection-close (decode-amqp-method-connection-close ibuffer))
    (amqp-method-connection-close-ok (decode-amqp-method-connection-close-ok ibuffer))
    (amqp-method-connection-blocked (decode-amqp-method-connection-blocked ibuffer))
    (amqp-method-connection-unblocked (decode-amqp-method-connection-unblocked ibuffer))
    (amqp-method-channel-open (decode-amqp-method-channel-open ibuffer))
    (amqp-method-channel-open-ok (decode-amqp-method-channel-open-ok ibuffer))
    (amqp-method-channel-flow (decode-amqp-method-channel-flow ibuffer))
    (amqp-method-channel-flow-ok (decode-amqp-method-channel-flow-ok ibuffer))
    (amqp-method-channel-close (decode-amqp-method-channel-close ibuffer))
    (amqp-method-channel-close-ok (decode-amqp-method-channel-close-ok ibuffer))
    (amqp-method-access-request (decode-amqp-method-access-request ibuffer))
    (amqp-method-access-request-ok (decode-amqp-method-access-request-ok ibuffer))
    (amqp-method-exchange-declare (decode-amqp-method-exchange-declare ibuffer))
    (amqp-method-exchange-declare-ok (decode-amqp-method-exchange-declare-ok ibuffer))
    (amqp-method-exchange-delete (decode-amqp-method-exchange-delete ibuffer))
    (amqp-method-exchange-delete-ok (decode-amqp-method-exchange-delete-ok ibuffer))
    (amqp-method-exchange-bind (decode-amqp-method-exchange-bind ibuffer))
    (amqp-method-exchange-bind-ok (decode-amqp-method-exchange-bind-ok ibuffer))
    (amqp-method-exchange-unbind (decode-amqp-method-exchange-unbind ibuffer))
    (amqp-method-exchange-unbind-ok (decode-amqp-method-exchange-unbind-ok ibuffer))
    (amqp-method-queue-declare (decode-amqp-method-queue-declare ibuffer))
    (amqp-method-queue-declare-ok (decode-amqp-method-queue-declare-ok ibuffer))
    (amqp-method-queue-bind (decode-amqp-method-queue-bind ibuffer))
    (amqp-method-queue-bind-ok (decode-amqp-method-queue-bind-ok ibuffer))
    (amqp-method-queue-purge (decode-amqp-method-queue-purge ibuffer))
    (amqp-method-queue-purge-ok (decode-amqp-method-queue-purge-ok ibuffer))
    (amqp-method-queue-delete (decode-amqp-method-queue-delete ibuffer))
    (amqp-method-queue-delete-ok (decode-amqp-method-queue-delete-ok ibuffer))
    (amqp-method-queue-unbind (decode-amqp-method-queue-unbind ibuffer))
    (amqp-method-queue-unbind-ok (decode-amqp-method-queue-unbind-ok ibuffer))
    (amqp-method-basic-qos (decode-amqp-method-basic-qos ibuffer))
    (amqp-method-basic-qos-ok (decode-amqp-method-basic-qos-ok ibuffer))
    (amqp-method-basic-consume (decode-amqp-method-basic-consume ibuffer))
    (amqp-method-basic-consume-ok (decode-amqp-method-basic-consume-ok ibuffer))
    (amqp-method-basic-cancel (decode-amqp-method-basic-cancel ibuffer))
    (amqp-method-basic-cancel-ok (decode-amqp-method-basic-cancel-ok ibuffer))
    (amqp-method-basic-publish (decode-amqp-method-basic-publish ibuffer))
    (amqp-method-basic-return (decode-amqp-method-basic-return ibuffer))
    (amqp-method-basic-deliver (decode-amqp-method-basic-deliver ibuffer))
    (amqp-method-basic-get (decode-amqp-method-basic-get ibuffer))
    (amqp-method-basic-get-ok (decode-amqp-method-basic-get-ok ibuffer))
    (amqp-method-basic-get-empty (decode-amqp-method-basic-get-empty ibuffer))
    (amqp-method-basic-ack (decode-amqp-method-basic-ack ibuffer))
    (amqp-method-basic-reject (decode-amqp-method-basic-reject ibuffer))
    (amqp-method-basic-recover-async (decode-amqp-method-basic-recover-async ibuffer))
    (amqp-method-basic-recover (decode-amqp-method-basic-recover ibuffer))
    (amqp-method-basic-recover-ok (decode-amqp-method-basic-recover-ok ibuffer))
    (amqp-method-basic-nack (decode-amqp-method-basic-nack ibuffer))
    (amqp-method-tx-select (decode-amqp-method-tx-select ibuffer))
    (amqp-method-tx-select-ok (decode-amqp-method-tx-select-ok ibuffer))
    (amqp-method-tx-commit (decode-amqp-method-tx-commit ibuffer))
    (amqp-method-tx-commit-ok (decode-amqp-method-tx-commit-ok ibuffer))
    (amqp-method-tx-rollback (decode-amqp-method-tx-rollback ibuffer))
    (amqp-method-tx-rollback-ok (decode-amqp-method-tx-rollback-ok ibuffer))
    (amqp-method-confirm-select (decode-amqp-method-confirm-select ibuffer))
    (amqp-method-confirm-select-ok (decode-amqp-method-confirm-select-ok ibuffer))
    (t (error 'amqp-unknown-method-class-error :method-class method-class))))

(defun method-encode (method obuffer)
  (case (class-name (class-of method))
    (amqp-method-connection-start (encode-amqp-method-connection-start method obuffer))
    (amqp-method-connection-start-ok (encode-amqp-method-connection-start-ok method obuffer))
    (amqp-method-connection-secure (encode-amqp-method-connection-secure method obuffer))
    (amqp-method-connection-secure-ok (encode-amqp-method-connection-secure-ok method obuffer))
    (amqp-method-connection-tune (encode-amqp-method-connection-tune method obuffer))
    (amqp-method-connection-tune-ok (encode-amqp-method-connection-tune-ok method obuffer))
    (amqp-method-connection-open (encode-amqp-method-connection-open method obuffer))
    (amqp-method-connection-open-ok (encode-amqp-method-connection-open-ok method obuffer))
    (amqp-method-connection-close (encode-amqp-method-connection-close method obuffer))
    (amqp-method-connection-close-ok (encode-amqp-method-connection-close-ok method obuffer))
    (amqp-method-connection-blocked (encode-amqp-method-connection-blocked method obuffer))
    (amqp-method-connection-unblocked (encode-amqp-method-connection-unblocked method obuffer))
    (amqp-method-channel-open (encode-amqp-method-channel-open method obuffer))
    (amqp-method-channel-open-ok (encode-amqp-method-channel-open-ok method obuffer))
    (amqp-method-channel-flow (encode-amqp-method-channel-flow method obuffer))
    (amqp-method-channel-flow-ok (encode-amqp-method-channel-flow-ok method obuffer))
    (amqp-method-channel-close (encode-amqp-method-channel-close method obuffer))
    (amqp-method-channel-close-ok (encode-amqp-method-channel-close-ok method obuffer))
    (amqp-method-access-request (encode-amqp-method-access-request method obuffer))
    (amqp-method-access-request-ok (encode-amqp-method-access-request-ok method obuffer))
    (amqp-method-exchange-declare (encode-amqp-method-exchange-declare method obuffer))
    (amqp-method-exchange-declare-ok (encode-amqp-method-exchange-declare-ok method obuffer))
    (amqp-method-exchange-delete (encode-amqp-method-exchange-delete method obuffer))
    (amqp-method-exchange-delete-ok (encode-amqp-method-exchange-delete-ok method obuffer))
    (amqp-method-exchange-bind (encode-amqp-method-exchange-bind method obuffer))
    (amqp-method-exchange-bind-ok (encode-amqp-method-exchange-bind-ok method obuffer))
    (amqp-method-exchange-unbind (encode-amqp-method-exchange-unbind method obuffer))
    (amqp-method-exchange-unbind-ok (encode-amqp-method-exchange-unbind-ok method obuffer))
    (amqp-method-queue-declare (encode-amqp-method-queue-declare method obuffer))
    (amqp-method-queue-declare-ok (encode-amqp-method-queue-declare-ok method obuffer))
    (amqp-method-queue-bind (encode-amqp-method-queue-bind method obuffer))
    (amqp-method-queue-bind-ok (encode-amqp-method-queue-bind-ok method obuffer))
    (amqp-method-queue-purge (encode-amqp-method-queue-purge method obuffer))
    (amqp-method-queue-purge-ok (encode-amqp-method-queue-purge-ok method obuffer))
    (amqp-method-queue-delete (encode-amqp-method-queue-delete method obuffer))
    (amqp-method-queue-delete-ok (encode-amqp-method-queue-delete-ok method obuffer))
    (amqp-method-queue-unbind (encode-amqp-method-queue-unbind method obuffer))
    (amqp-method-queue-unbind-ok (encode-amqp-method-queue-unbind-ok method obuffer))
    (amqp-method-basic-qos (encode-amqp-method-basic-qos method obuffer))
    (amqp-method-basic-qos-ok (encode-amqp-method-basic-qos-ok method obuffer))
    (amqp-method-basic-consume (encode-amqp-method-basic-consume method obuffer))
    (amqp-method-basic-consume-ok (encode-amqp-method-basic-consume-ok method obuffer))
    (amqp-method-basic-cancel (encode-amqp-method-basic-cancel method obuffer))
    (amqp-method-basic-cancel-ok (encode-amqp-method-basic-cancel-ok method obuffer))
    (amqp-method-basic-publish (encode-amqp-method-basic-publish method obuffer))
    (amqp-method-basic-return (encode-amqp-method-basic-return method obuffer))
    (amqp-method-basic-deliver (encode-amqp-method-basic-deliver method obuffer))
    (amqp-method-basic-get (encode-amqp-method-basic-get method obuffer))
    (amqp-method-basic-get-ok (encode-amqp-method-basic-get-ok method obuffer))
    (amqp-method-basic-get-empty (encode-amqp-method-basic-get-empty method obuffer))
    (amqp-method-basic-ack (encode-amqp-method-basic-ack method obuffer))
    (amqp-method-basic-reject (encode-amqp-method-basic-reject method obuffer))
    (amqp-method-basic-recover-async (encode-amqp-method-basic-recover-async method obuffer))
    (amqp-method-basic-recover (encode-amqp-method-basic-recover method obuffer))
    (amqp-method-basic-recover-ok (encode-amqp-method-basic-recover-ok method obuffer))
    (amqp-method-basic-nack (encode-amqp-method-basic-nack method obuffer))
    (amqp-method-tx-select (encode-amqp-method-tx-select method obuffer))
    (amqp-method-tx-select-ok (encode-amqp-method-tx-select-ok method obuffer))
    (amqp-method-tx-commit (encode-amqp-method-tx-commit method obuffer))
    (amqp-method-tx-commit-ok (encode-amqp-method-tx-commit-ok method obuffer))
    (amqp-method-tx-rollback (encode-amqp-method-tx-rollback method obuffer))
    (amqp-method-tx-rollback-ok (encode-amqp-method-tx-rollback-ok method obuffer))
    (amqp-method-confirm-select (encode-amqp-method-confirm-select method obuffer))
    (amqp-method-confirm-select-ok (encode-amqp-method-confirm-select-ok method obuffer))
    (t (error 'amqp-unknown-method-class-error :method-class (class-of method)))))


(defmethod synchronous-method-p ((method-class symbol))
  (case method-class
    (amqp-method-connection-start t)
    (amqp-method-connection-start-ok nil)
    (amqp-method-connection-secure t)
    (amqp-method-connection-secure-ok nil)
    (amqp-method-connection-tune t)
    (amqp-method-connection-tune-ok nil)
    (amqp-method-connection-open t)
    (amqp-method-connection-open-ok nil)
    (amqp-method-connection-close t)
    (amqp-method-connection-close-ok nil)
    (amqp-method-connection-blocked nil)
    (amqp-method-connection-unblocked nil)
    (amqp-method-channel-open t)
    (amqp-method-channel-open-ok nil)
    (amqp-method-channel-flow t)
    (amqp-method-channel-flow-ok nil)
    (amqp-method-channel-close t)
    (amqp-method-channel-close-ok nil)
    (amqp-method-access-request t)
    (amqp-method-access-request-ok nil)
    (amqp-method-exchange-declare t)
    (amqp-method-exchange-declare-ok nil)
    (amqp-method-exchange-delete t)
    (amqp-method-exchange-delete-ok nil)
    (amqp-method-exchange-bind t)
    (amqp-method-exchange-bind-ok nil)
    (amqp-method-exchange-unbind t)
    (amqp-method-exchange-unbind-ok nil)
    (amqp-method-queue-declare t)
    (amqp-method-queue-declare-ok nil)
    (amqp-method-queue-bind t)
    (amqp-method-queue-bind-ok nil)
    (amqp-method-queue-purge t)
    (amqp-method-queue-purge-ok nil)
    (amqp-method-queue-delete t)
    (amqp-method-queue-delete-ok nil)
    (amqp-method-queue-unbind t)
    (amqp-method-queue-unbind-ok nil)
    (amqp-method-basic-qos t)
    (amqp-method-basic-qos-ok nil)
    (amqp-method-basic-consume t)
    (amqp-method-basic-consume-ok nil)
    (amqp-method-basic-cancel t)
    (amqp-method-basic-cancel-ok nil)
    (amqp-method-basic-publish nil)
    (amqp-method-basic-return nil)
    (amqp-method-basic-deliver nil)
    (amqp-method-basic-get t)
    (amqp-method-basic-get-ok nil)
    (amqp-method-basic-get-empty nil)
    (amqp-method-basic-ack nil)
    (amqp-method-basic-reject nil)
    (amqp-method-basic-recover-async nil)
    (amqp-method-basic-recover t)
    (amqp-method-basic-recover-ok nil)
    (amqp-method-basic-nack nil)
    (amqp-method-tx-select t)
    (amqp-method-tx-select-ok nil)
    (amqp-method-tx-commit t)
    (amqp-method-tx-commit-ok nil)
    (amqp-method-tx-rollback t)
    (amqp-method-tx-rollback-ok nil)
    (amqp-method-confirm-select t)
    (amqp-method-confirm-select-ok nil)
    (t (error 'amqp-unknown-method-class-error :method-class method-class))))

(defmethod method-has-content-p ((method-class symbol))
  (case method-class
    (amqp-method-connection-start nil)
    (amqp-method-connection-start-ok nil)
    (amqp-method-connection-secure nil)
    (amqp-method-connection-secure-ok nil)
    (amqp-method-connection-tune nil)
    (amqp-method-connection-tune-ok nil)
    (amqp-method-connection-open nil)
    (amqp-method-connection-open-ok nil)
    (amqp-method-connection-close nil)
    (amqp-method-connection-close-ok nil)
    (amqp-method-connection-blocked nil)
    (amqp-method-connection-unblocked nil)
    (amqp-method-channel-open nil)
    (amqp-method-channel-open-ok nil)
    (amqp-method-channel-flow nil)
    (amqp-method-channel-flow-ok nil)
    (amqp-method-channel-close nil)
    (amqp-method-channel-close-ok nil)
    (amqp-method-access-request nil)
    (amqp-method-access-request-ok nil)
    (amqp-method-exchange-declare nil)
    (amqp-method-exchange-declare-ok nil)
    (amqp-method-exchange-delete nil)
    (amqp-method-exchange-delete-ok nil)
    (amqp-method-exchange-bind nil)
    (amqp-method-exchange-bind-ok nil)
    (amqp-method-exchange-unbind nil)
    (amqp-method-exchange-unbind-ok nil)
    (amqp-method-queue-declare nil)
    (amqp-method-queue-declare-ok nil)
    (amqp-method-queue-bind nil)
    (amqp-method-queue-bind-ok nil)
    (amqp-method-queue-purge nil)
    (amqp-method-queue-purge-ok nil)
    (amqp-method-queue-delete nil)
    (amqp-method-queue-delete-ok nil)
    (amqp-method-queue-unbind nil)
    (amqp-method-queue-unbind-ok nil)
    (amqp-method-basic-qos nil)
    (amqp-method-basic-qos-ok nil)
    (amqp-method-basic-consume nil)
    (amqp-method-basic-consume-ok nil)
    (amqp-method-basic-cancel nil)
    (amqp-method-basic-cancel-ok nil)
    (amqp-method-basic-publish t)
    (amqp-method-basic-return t)
    (amqp-method-basic-deliver t)
    (amqp-method-basic-get nil)
    (amqp-method-basic-get-ok t)
    (amqp-method-basic-get-empty nil)
    (amqp-method-basic-ack nil)
    (amqp-method-basic-reject nil)
    (amqp-method-basic-recover-async nil)
    (amqp-method-basic-recover nil)
    (amqp-method-basic-recover-ok nil)
    (amqp-method-basic-nack nil)
    (amqp-method-tx-select nil)
    (amqp-method-tx-select-ok nil)
    (amqp-method-tx-commit nil)
    (amqp-method-tx-commit-ok nil)
    (amqp-method-tx-rollback nil)
    (amqp-method-tx-rollback-ok nil)
    (amqp-method-confirm-select nil)
    (amqp-method-confirm-select-ok nil)
    (t (error 'amqp-unknown-method-class-error :method-class method-class))))

(defun method-class-from-signature(signature)
  (case signature
    (#x000a000a 'amqp-method-connection-start)
    (#x000a000b 'amqp-method-connection-start-ok)
    (#x000a0014 'amqp-method-connection-secure)
    (#x000a0015 'amqp-method-connection-secure-ok)
    (#x000a001e 'amqp-method-connection-tune)
    (#x000a001f 'amqp-method-connection-tune-ok)
    (#x000a0028 'amqp-method-connection-open)
    (#x000a0029 'amqp-method-connection-open-ok)
    (#x000a0032 'amqp-method-connection-close)
    (#x000a0033 'amqp-method-connection-close-ok)
    (#x000a003c 'amqp-method-connection-blocked)
    (#x000a003d 'amqp-method-connection-unblocked)
    (#x0014000a 'amqp-method-channel-open)
    (#x0014000b 'amqp-method-channel-open-ok)
    (#x00140014 'amqp-method-channel-flow)
    (#x00140015 'amqp-method-channel-flow-ok)
    (#x00140028 'amqp-method-channel-close)
    (#x00140029 'amqp-method-channel-close-ok)
    (#x001e000a 'amqp-method-access-request)
    (#x001e000b 'amqp-method-access-request-ok)
    (#x0028000a 'amqp-method-exchange-declare)
    (#x0028000b 'amqp-method-exchange-declare-ok)
    (#x00280014 'amqp-method-exchange-delete)
    (#x00280015 'amqp-method-exchange-delete-ok)
    (#x0028001e 'amqp-method-exchange-bind)
    (#x0028001f 'amqp-method-exchange-bind-ok)
    (#x00280028 'amqp-method-exchange-unbind)
    (#x00280033 'amqp-method-exchange-unbind-ok)
    (#x0032000a 'amqp-method-queue-declare)
    (#x0032000b 'amqp-method-queue-declare-ok)
    (#x00320014 'amqp-method-queue-bind)
    (#x00320015 'amqp-method-queue-bind-ok)
    (#x0032001e 'amqp-method-queue-purge)
    (#x0032001f 'amqp-method-queue-purge-ok)
    (#x00320028 'amqp-method-queue-delete)
    (#x00320029 'amqp-method-queue-delete-ok)
    (#x00320032 'amqp-method-queue-unbind)
    (#x00320033 'amqp-method-queue-unbind-ok)
    (#x003c000a 'amqp-method-basic-qos)
    (#x003c000b 'amqp-method-basic-qos-ok)
    (#x003c0014 'amqp-method-basic-consume)
    (#x003c0015 'amqp-method-basic-consume-ok)
    (#x003c001e 'amqp-method-basic-cancel)
    (#x003c001f 'amqp-method-basic-cancel-ok)
    (#x003c0028 'amqp-method-basic-publish)
    (#x003c0032 'amqp-method-basic-return)
    (#x003c003c 'amqp-method-basic-deliver)
    (#x003c0046 'amqp-method-basic-get)
    (#x003c0047 'amqp-method-basic-get-ok)
    (#x003c0048 'amqp-method-basic-get-empty)
    (#x003c0050 'amqp-method-basic-ack)
    (#x003c005a 'amqp-method-basic-reject)
    (#x003c0064 'amqp-method-basic-recover-async)
    (#x003c006e 'amqp-method-basic-recover)
    (#x003c006f 'amqp-method-basic-recover-ok)
    (#x003c0078 'amqp-method-basic-nack)
    (#x005a000a 'amqp-method-tx-select)
    (#x005a000b 'amqp-method-tx-select-ok)
    (#x005a0014 'amqp-method-tx-commit)
    (#x005a0015 'amqp-method-tx-commit-ok)
    (#x005a001e 'amqp-method-tx-rollback)
    (#x005a001f 'amqp-method-tx-rollback-ok)
    (#x0055000a 'amqp-method-confirm-select)
    (#x0055000b 'amqp-method-confirm-select-ok)
    (t (error 'amqp-unknown-method-error :method-signature signature))))

(defun method-signature(method)
  (case (class-name (class-of method))
    (amqp-method-connection-start #x000a000a)
    (amqp-method-connection-start-ok #x000a000b)
    (amqp-method-connection-secure #x000a0014)
    (amqp-method-connection-secure-ok #x000a0015)
    (amqp-method-connection-tune #x000a001e)
    (amqp-method-connection-tune-ok #x000a001f)
    (amqp-method-connection-open #x000a0028)
    (amqp-method-connection-open-ok #x000a0029)
    (amqp-method-connection-close #x000a0032)
    (amqp-method-connection-close-ok #x000a0033)
    (amqp-method-connection-blocked #x000a003c)
    (amqp-method-connection-unblocked #x000a003d)
    (amqp-method-channel-open #x0014000a)
    (amqp-method-channel-open-ok #x0014000b)
    (amqp-method-channel-flow #x00140014)
    (amqp-method-channel-flow-ok #x00140015)
    (amqp-method-channel-close #x00140028)
    (amqp-method-channel-close-ok #x00140029)
    (amqp-method-access-request #x001e000a)
    (amqp-method-access-request-ok #x001e000b)
    (amqp-method-exchange-declare #x0028000a)
    (amqp-method-exchange-declare-ok #x0028000b)
    (amqp-method-exchange-delete #x00280014)
    (amqp-method-exchange-delete-ok #x00280015)
    (amqp-method-exchange-bind #x0028001e)
    (amqp-method-exchange-bind-ok #x0028001f)
    (amqp-method-exchange-unbind #x00280028)
    (amqp-method-exchange-unbind-ok #x00280033)
    (amqp-method-queue-declare #x0032000a)
    (amqp-method-queue-declare-ok #x0032000b)
    (amqp-method-queue-bind #x00320014)
    (amqp-method-queue-bind-ok #x00320015)
    (amqp-method-queue-purge #x0032001e)
    (amqp-method-queue-purge-ok #x0032001f)
    (amqp-method-queue-delete #x00320028)
    (amqp-method-queue-delete-ok #x00320029)
    (amqp-method-queue-unbind #x00320032)
    (amqp-method-queue-unbind-ok #x00320033)
    (amqp-method-basic-qos #x003c000a)
    (amqp-method-basic-qos-ok #x003c000b)
    (amqp-method-basic-consume #x003c0014)
    (amqp-method-basic-consume-ok #x003c0015)
    (amqp-method-basic-cancel #x003c001e)
    (amqp-method-basic-cancel-ok #x003c001f)
    (amqp-method-basic-publish #x003c0028)
    (amqp-method-basic-return #x003c0032)
    (amqp-method-basic-deliver #x003c003c)
    (amqp-method-basic-get #x003c0046)
    (amqp-method-basic-get-ok #x003c0047)
    (amqp-method-basic-get-empty #x003c0048)
    (amqp-method-basic-ack #x003c0050)
    (amqp-method-basic-reject #x003c005a)
    (amqp-method-basic-recover-async #x003c0064)
    (amqp-method-basic-recover #x003c006e)
    (amqp-method-basic-recover-ok #x003c006f)
    (amqp-method-basic-nack #x003c0078)
    (amqp-method-tx-select #x005a000a)
    (amqp-method-tx-select-ok #x005a000b)
    (amqp-method-tx-commit #x005a0014)
    (amqp-method-tx-commit-ok #x005a0015)
    (amqp-method-tx-rollback #x005a001e)
    (amqp-method-tx-rollback-ok #x005a001f)
    (amqp-method-confirm-select #x0055000a)
    (amqp-method-confirm-select-ok #x0055000b)
    (t (error 'amqp-unknown-method-class-error :method-class (class-of method)))))

;; basic class properties flags
(defconstant +flag-content-type+ (ash 1 15))
(defconstant +flag-content-encoding+ (ash 1 14))
(defconstant +flag-headers+ (ash 1 13))
(defconstant +flag-delivery-mode+ (ash 1 12))
(defconstant +flag-priority+ (ash 1 11))
(defconstant +flag-correlation-id+ (ash 1 10))
(defconstant +flag-reply-to+ (ash 1 9))
(defconstant +flag-expiration+ (ash 1 8))
(defconstant +flag-message-id+ (ash 1 7))
(defconstant +flag-timestamp+ (ash 1 6))
(defconstant +flag-type+ (ash 1 5))
(defconstant +flag-user-id+ (ash 1 4))
(defconstant +flag-app-id+ (ash 1 3))
(defconstant +flag-cluster-id+ (ash 1 2))

;; basic class properties
(defclass amqp-basic-class-properties ()
 (
 (content-type :type amqp-shortstr :initarg :content-type)
 (content-encoding :type amqp-shortstr :initarg :content-encoding)
 (headers :type amqp-table :initarg :headers)
 (delivery-mode :type amqp-octet :initarg :delivery-mode)
 (priority :type amqp-octet :initarg :priority)
 (correlation-id :type amqp-shortstr :initarg :correlation-id)
 (reply-to :type amqp-shortstr :initarg :reply-to)
 (expiration :type amqp-shortstr :initarg :expiration)
 (message-id :type amqp-shortstr :initarg :message-id)
 (timestamp :type amqp-timestamp :initarg :timestamp)
 (type :type amqp-shortstr :initarg :type)
 (user-id :type amqp-shortstr :initarg :user-id)
 (app-id :type amqp-shortstr :initarg :app-id)
 (cluster-id :type amqp-shortstr :initarg :cluster-id)
))

;; basic class properties encoder/decoder
(defmethod amqp-class-properties-encoder ((props amqp-basic-class-properties) obuffer)
  (let ((flags 0)
        (props-buffer (new-obuffer)))
  ;; TODO: add flags length declaration here
  ;; TODO: also calculate how may bytes needed for flags encoding
  ;; use this with refactored obuffer
    (when (slot-boundp props 'content-type)
      (setf flags (logior flags +flag-content-type+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'content-type)))
    (when (slot-boundp props 'content-encoding)
      (setf flags (logior flags +flag-content-encoding+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'content-encoding)))
    (when (slot-boundp props 'headers)
      (setf flags (logior flags +flag-headers+))
      (amqp-table-encoder props-buffer (slot-value props 'headers)))
    (when (slot-boundp props 'delivery-mode)
      (setf flags (logior flags +flag-delivery-mode+))
      (amqp-octet-encoder props-buffer (slot-value props 'delivery-mode)))
    (when (slot-boundp props 'priority)
      (setf flags (logior flags +flag-priority+))
      (amqp-octet-encoder props-buffer (slot-value props 'priority)))
    (when (slot-boundp props 'correlation-id)
      (setf flags (logior flags +flag-correlation-id+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'correlation-id)))
    (when (slot-boundp props 'reply-to)
      (setf flags (logior flags +flag-reply-to+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'reply-to)))
    (when (slot-boundp props 'expiration)
      (setf flags (logior flags +flag-expiration+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'expiration)))
    (when (slot-boundp props 'message-id)
      (setf flags (logior flags +flag-message-id+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'message-id)))
    (when (slot-boundp props 'timestamp)
      (setf flags (logior flags +flag-timestamp+))
      (amqp-timestamp-encoder props-buffer (slot-value props 'timestamp)))
    (when (slot-boundp props 'type)
      (setf flags (logior flags +flag-type+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'type)))
    (when (slot-boundp props 'user-id)
      (setf flags (logior flags +flag-user-id+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'user-id)))
    (when (slot-boundp props 'app-id)
      (setf flags (logior flags +flag-app-id+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'app-id)))
    (when (slot-boundp props 'cluster-id)
      (setf flags (logior flags +flag-cluster-id+))
      (amqp-shortstr-encoder props-buffer (slot-value props 'cluster-id)))
    (loop
      as reminder = (ash flags -16)
      as partial-flags = (logand flags #xfffe)
      do
         (when (not (= reminder 0))
           (setf partial-flags (logior partial-flags 1)))

         (obuffer-encode-ub16 obuffer partial-flags)
         (setf flags reminder)
         (if (zerop flags)
             (return)))
     (obuffer-add-bytes obuffer (obuffer-get-bytes props-buffer))))

(defun amqp-class-properties-class (class-id)
  (case class-id
    (#x003C amqp-basic-class-properties)
    (t (error "AMQP Class ~a has no properties" class-id)))) ;; TODO: specialize error

(defun amqp-class-properties-class-id (class-properties)
  (case (class-name (class-of class-properties))
    (amqp-basic-class-properties #x003C)
    (t (error "Unknown properties class ~a" (class-name (class-of class-properties)))))) ;; TODO: specialize error
