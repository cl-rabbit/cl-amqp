(in-package :cl-amqp)

(defclass frame ()
  ((type :reader frame-type)
   (channel :initarg :channel
            :accessor frame-channel)
   (size :initarg :size
         :accessor frame-size)
   (payload :initarg :payload
            :accessor frame-payload)))

(defclass method-frame (frame)
  ((type :initform +amqp-frame-method+)))

(defclass header-frame (frame)
  ((type :initform +amqp-frame-header+)))

(defclass body-frame (frame)
  ((type :initform +amqp-frame-body+)))

(defclass heartbeat-frame (frame)
  ((type :initform +amqp-frame-heartbeat+)))

(defun frame-class-from-frame-type (frame-type)
  (case frame-type
    (1 #|+amqp-frame-method+|# 'method-frame)
    (2 #|+amqp-frame-header+|# 'header-frame)
    (3 #|+amqp-frame-body+|# 'body-frame)
    (4 #|+amqp-frame-heartbeat+|# 'heartbeat-frame)
    (t (error 'amqp-unknown-frame-type-error :frame-type frame-type))))

(defgeneric frame-encode (frame obuffer))

(defmethod frame-encode ((frame method-frame) obuffer)
  (obuffer-encode-ub8 obuffer (frame-type frame))
  (obuffer-encode-ub16 obuffer (frame-channel frame))
  (let* ((payload-buffer (new-obuffer))
         (payload-bytes (progn
                          (obuffer-encode-ub32 payload-buffer (method-signature (frame-payload frame)))
                          (method-encode (frame-payload frame) payload-buffer)
                          (obuffer-get-bytes payload-buffer))))
    (obuffer-encode-ub32 obuffer (length payload-bytes))
    (obuffer-add-bytes obuffer payload-bytes)
    (obuffer-encode-ub8 obuffer +amqp-frame-end+))
  obuffer)

(define-condition malformed-frame-error (amqp-base-error)
  ())

(define-condition invalid-frame-parser-state-error (amqp-base-error)
  ())

(defconstant +parsing-start+ 0)
(defconstant +parsing-type-octet+ 1)
(defconstant +parsing-channel-first-octet+ 2)
(defconstant +parsing-channel-second-octet+ 3)
(defconstant +parsing-payload-size-first-octet+ 4)
(defconstant +parsing-payload-size-second-octet+ 5)
(defconstant +parsing-payload-size-third-octet+ 6)
(defconstant +parsing-payload-size-forth-octet+ 7)
(defconstant +parsing-payload+ 8)
(defconstant +parsing-frame-end-octet+ 9)

(defclass frame-parser ()
  ((on-frame-type :initarg :on-frame-type
                  :initform nil)
   (on-frame-channel :initarg :on-frame-channel
                     :initform nil)
   (on-frame-payload-size :initarg :on-frame-payload-size
                          :initform nil)
   (on-frame-payload :initarg :on-frame-payload
                     :initform nil)
   (on-frame-end :initarg :on-frame-end
                 :initform nil)
   ;; private parts
   (state :initform +parsing-type-octet+
          :accessor frame-parser-state)
   (payload-size :initform 0)
   (payload-bytes-readed :initform 0)
   (channel-number-buffer :type (simple-array (unsigned-byte 8))
                          :initform (make-array 2 :element-type '(unsigned-byte 8))
                          :reader frame-parser-channel-number-buffer)
   (payload-size-buffer :type (simple-array (unsigned-byte 8))
                        :initform (make-array 4 :element-type '(unsigned-byte 8))
                        :reader frame-parser-payload-size-buffer)))

(defun make-frame-parser (&key on-frame-type on-frame-channel on-frame-payload-size on-frame-payload on-frame-end)
  (make-instance 'frame-parser :on-frame-type on-frame-type
                               :on-frame-channel on-frame-channel
                               :on-frame-payload-size on-frame-payload-size
                               :on-frame-payload on-frame-payload
                               :on-frame-end on-frame-end))

;; payload callback called with start and end compatible with subseq
;; i.e. including start but excluding end
(defun frame-parser-consume (parser data &key (start 0) (end (length data)))
  (declare (type (simple-array (unsigned-byte 8)) data)
           (type fixnum start end)
           (type frame-parser parser))
  (assert (>= (length data) end))
  ;; our state-machine
  (labels ((reset-state ()
             (setf (slot-value parser 'payload-size) 0
                   (slot-value parser 'payload-bytes-readed) 0))
           (consume (bytes index)
             (declare (type (simple-array (unsigned-byte 8)) bytes))
             (let ((byte (aref bytes index)))
               (declare (type (unsigned-byte 8) byte))
               (tagbody
                  (case (frame-parser-state parser)
                    (0 #|+parsing-start+|# (go :start))
                    (1 #|+parsing-type-octet+|# (go :parsing-type-octet))
                    (2 #|+parsing-channel-first-octet+|# (go :parsing-channel-first-octet))
                    (3 #|+parsing-channel-second-octet+|# (go :parsing-channel-second-octet))
                    (4 #|+parsing-payload-size-first-octet+|# (go :parsing-payload-size-first-octet))
                    (5 #|+parsing-payload-size-second-octet+|# (go :parsing-payload-size-second-octet))
                    (6 #|+parsing-payload-size-third-octet+|# (go :parsing-payload-size-third-octet))
                    (7 #|+parsing-payload-size-forth-octet+|# (go :parsing-payload-size-forth-octet))
                    (8 #|+parsing-payload+|# (go :parsing-payload))
                    (9 #|+parsing-frame-end-octet+|# (go :parsing-frame-end-octet))
                    (t (error 'invalid-frame-parser-state-error)))
                :start
                  (reset-state)
                  (go :parsing-type-octet)
                :parsing-type-octet
                  (if-let ((on-frame-type (slot-value parser 'on-frame-type)))
                    (funcall on-frame-type parser byte))
                  (setf (frame-parser-state parser) +parsing-channel-first-octet+)
                  (go :end)
                :parsing-channel-first-octet
                  (setf (aref (frame-parser-channel-number-buffer parser) 0) byte)
                  (setf (frame-parser-state parser) +parsing-channel-second-octet+)
                  (go :end)
                :parsing-channel-second-octet
                  (setf (aref (frame-parser-channel-number-buffer parser) 1) byte)
                  (if-let ((on-frame-channel (slot-value parser 'on-frame-channel)))
                    (let ((channel-number (nibbles:ub16ref/be (frame-parser-channel-number-buffer parser) 0)))
                      (funcall on-frame-channel parser channel-number)))
                  (setf (frame-parser-state parser) +parsing-payload-size-first-octet+)
                  (go :end)
                :parsing-payload-size-first-octet
                  (setf (aref (frame-parser-payload-size-buffer parser) 0) byte)
                  (setf (frame-parser-state parser) +parsing-payload-size-second-octet+)
                  (go :end)
                :parsing-payload-size-second-octet
                  (setf (aref (frame-parser-payload-size-buffer parser) 1) byte)
                  (setf (frame-parser-state parser) +parsing-payload-size-third-octet+)
                  (go :end)
                :parsing-payload-size-third-octet
                  (setf (aref (frame-parser-payload-size-buffer parser) 2) byte)
                  (setf (frame-parser-state parser) +parsing-payload-size-forth-octet+)
                  (go :end)
                :parsing-payload-size-forth-octet
                  (setf (aref (frame-parser-payload-size-buffer parser) 3) byte)
                  (let ((payload-size (nibbles:ub32ref/be (frame-parser-payload-size-buffer parser) 0)))
                    (setf (slot-value parser 'payload-size) payload-size)
                    (if-let ((on-frame-payload-size (slot-value parser 'on-frame-payload-size)))
                      (funcall on-frame-payload-size parser payload-size))
                    (if (> payload-size 0)
                        (setf (frame-parser-state parser) +parsing-payload+)
                        (setf (frame-parser-state parser) +parsing-frame-end-octet+)))
                  (go :end)
                :parsing-payload
                  (with-slots (payload-size payload-bytes-readed on-frame-payload) parser
                    (let ((index-start index))
                      (loop
                        (if (and (> payload-size payload-bytes-readed)
                                 (< index end))
                            (progn
                              (incf index)
                              (incf payload-bytes-readed))
                            (progn
                              (if on-frame-payload
                                  (funcall on-frame-payload parser bytes index-start index))
                              (when (= payload-size payload-bytes-readed)
                                (setf (frame-parser-state parser) +parsing-frame-end-octet+)
                                (decf index))
                              (return))))))
                  (go :end)
                :parsing-frame-end-octet
                  (if (= byte +amqp-frame-end+)
                      (progn
                        (if-let ((on-frame-end (slot-value parser 'on-frame-end)))
                          (funcall on-frame-end parser))
                        (setf (frame-parser-state parser) +parsing-start+)
                        (go :end))
                      (error 'malformed-frame-error))
                :end)
               index)))
    (loop for i from start to (1- end) do
             (setf i (the fixnum (consume data i))))))

(defclass method-frame-payload-parser ()
  (;; parser state
   (state :initform :start)
   (consumed :initform 0)
   (buffer :initarg :buffer)
   (frame :initarg :frame)
   (size :initarg :size)
   ;; method frame payload
   (class-id)
   (method-id)
   (method-signature)
   (method-class)
   ;; callbacks
   (on-class-id :initarg :on-class-id)
   (on-method-id :initarg :on-method-id)
   (on-method-signature :initarg :on-method-signature)
   (on-method-arguments-buffer :initarg :on-method-arguments-buffer)))

(defun method-frame-payload-parser (frame &key on-class-id on-method-id on-method-signature on-method-arguments-buffer &aux (size (frame-size frame)))
  (make-instance 'method-frame-payload-parser :frame frame
                                              :size size
                                              :buffer (nibbles:make-octet-vector size)
                                              :on-class-id on-class-id
                                              :on-method-id on-method-id
                                              :on-method-signature on-method-signature
                                              :on-method-arguments-buffer on-method-arguments-buffer))


(defmethod frame-payload-parser-consume ((payload-parser method-frame-payload-parser) octets &key (start 0) (end (length octets)))
  (with-slots (state
               buffer
               size
               consumed
               frame
               class-id
               method-id
               method-signature
               method-class
               on-class-id
               on-method-id
               on-method-signature
               on-method-arguments-buffer) payload-parser
    (labels ((consume (bytes index)
               (declare (type (simple-array (unsigned-byte 8)) bytes))
               (let ((byte (aref bytes index)))
                 (declare (type (unsigned-byte 8) byte))
                 (tagbody
                    (case state
                      (:state (go :parsing-method-signature-first-octet))
                      (:parsing-method-signature-second-octet (go :parsing-method-signature-second-octet))
                      (:parsing-method-signature-third-octet (go :parsing-method-signature-third-octet))
                      (:parsing-method-signature-forth-octet (go :parsing-method-signature-forth-octet))
                      (:consuming-method-arguments-start (go :consuming-method-arguments-start))
                      (:consuming-method-arguments (go :consuming-method-arguments))
                      (:method-frame-payload-parsed (error "Payload parser finished"))) ;; TODO: specialize error
                  :parsing-method-signature-first-octet
                    (setf (aref buffer 0) byte)
                    (setf state :parsing-method-signature-second-octet)
                    (go :end)
                  :parsing-method-signature-second-octet
                    (setf (aref buffer 1) byte)
                    (setf class-id (nibbles:ub16ref/be buffer 0))
                    (if on-class-id
                        (funcall on-class-id class-id))
                    (setf state :parsing-method-signature-third-octet)
                    (go :end)
                  :parsing-method-signature-third-octet
                    (setf (aref buffer 2) byte)
                    (setf state :parsing-method-signature-forth-octet)
                    (go :end)
                  :parsing-method-signature-forth-octet
                    (setf (aref buffer 3) byte)
                    (setf method-id (nibbles:ub16ref/be buffer 2))
                    (if on-method-id
                        (funcall on-method-id method-id))
                    (setf method-signature (nibbles:ub32ref/be buffer 0))
                    (if on-method-signature
                        (funcall on-method-signature method-signature))
                    (setf method-class (method-class-from-signature method-signature))
                    (setf state :consuming-method-arguments)
                    (setf consumed 4)
                    (go :consuming-method-arguments-start)
                  :consuming-method-arguments-start
                    (if (= size consumed)
                        (go :method-frame-payload-parsed)
                        (go :end))
                  :consuming-method-arguments
                    (let ((to-copy (if (< (- end start) (- size consumed))
                                       (- end start)
                                       (- size consumed))))
                      (replace buffer octets :start1 consumed :start2 index)
                      (incf consumed to-copy)
                      (incf index to-copy)
                      (when (= consumed size)
                        (setf state :method-frame-payload-parsed)
                        (go :method-frame-payload-parsed)))
                  :method-frame-payload-parsed
                    (if on-method-arguments-buffer
                        (funcall on-method-arguments-buffer buffer))
                    (return-from frame-payload-parser-consume)
                  :end)
                 index)))
      (loop for i from start to (1- end) do
               (setf i (the fixnum (consume octets i)))))))

(defmethod frame-payload-parser-finish ((payload-parser method-frame-payload-parser))
  (with-slots (state
               buffer
               frame
               method-class) payload-parser
    (unless (eq state :method-frame-payload-parsed)
      (error "Invalid method-frame-payload-parser state: payload not parsed")) ;; TODO: specialize error

    (setf (frame-payload frame) (method-decode method-class (new-ibuffer buffer :start 4)))))

(defun make-frame-payload-parser (frame &rest args &key &allow-other-keys)
  (let ((parser-ctor
          (case (frame-type frame)
            (1 #|+amqp-frame-method+|# 'method-frame-payload-parser)
            (2 #|+amqp-frame-header+|# 'header-frame-payload-parser)
            (3 #|+amqp-frame-body+|# 'body-frame-payload-parser)
            (4 #|+amqp-frame-heartbeat+|# 'heartbeat-frame-payload-parser)
            (t (error 'amqp-unknown-frame-type-error :frame-type (frame-type frame))))))
    (apply parser-ctor frame args)))
