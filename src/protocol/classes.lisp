;; DO NOT EDIT. RUN GENERATE TO REGENERATE

(in-package :cl-amqp)

(defclass amqp-class-base ()
  ())

(defclass amqp-method-base ()
  ())


(defclass amqp-method-connection-start (amqp-method-base)
((version-major :initarg :version-major)
(version-minor :initarg :version-minor)
(server-properties :initarg :server-properties)
(mechanisms :initarg :mechanisms)
(locales :initarg :locales)
))

(defun decode-amqp-method-connection-start (ibuffer)
  (error "decode-amqp-method-connection-start not implemented"))

(defun encode-amqp-method-connection-start (method obuffer)
  (error "encode-amqp-method-connection-start not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-start))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-start))
  nil)

(defmethod method-class-id ((method amqp-method-connection-start))
  10)

(defmethod method-method-id ((method amqp-method-connection-start))
  10)

(defclass amqp-method-connection-start-ok (amqp-method-base)
((client-properties :initarg :client-properties)
(mechanism :initarg :mechanism)
(response :initarg :response)
(locale :initarg :locale)
))

(defun decode-amqp-method-connection-start-ok (ibuffer)
  (error "decode-amqp-method-connection-start-ok not implemented"))

(defun encode-amqp-method-connection-start-ok (method obuffer)
  (error "encode-amqp-method-connection-start-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-start-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-start-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-start-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-start-ok))
  11)

(defclass amqp-method-connection-secure (amqp-method-base)
((challenge :initarg :challenge)
))

(defun decode-amqp-method-connection-secure (ibuffer)
  (error "decode-amqp-method-connection-secure not implemented"))

(defun encode-amqp-method-connection-secure (method obuffer)
  (error "encode-amqp-method-connection-secure not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-secure))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-secure))
  nil)

(defmethod method-class-id ((method amqp-method-connection-secure))
  10)

(defmethod method-method-id ((method amqp-method-connection-secure))
  20)

(defclass amqp-method-connection-secure-ok (amqp-method-base)
((response :initarg :response)
))

(defun decode-amqp-method-connection-secure-ok (ibuffer)
  (error "decode-amqp-method-connection-secure-ok not implemented"))

(defun encode-amqp-method-connection-secure-ok (method obuffer)
  (error "encode-amqp-method-connection-secure-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-secure-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-secure-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-secure-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-secure-ok))
  21)

(defclass amqp-method-connection-tune (amqp-method-base)
((channel-max :initarg :channel-max)
(frame-max :initarg :frame-max)
(heartbeat :initarg :heartbeat)
))

(defun decode-amqp-method-connection-tune (ibuffer)
  (error "decode-amqp-method-connection-tune not implemented"))

(defun encode-amqp-method-connection-tune (method obuffer)
  (error "encode-amqp-method-connection-tune not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-tune))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-tune))
  nil)

(defmethod method-class-id ((method amqp-method-connection-tune))
  10)

(defmethod method-method-id ((method amqp-method-connection-tune))
  30)

(defclass amqp-method-connection-tune-ok (amqp-method-base)
((channel-max :initarg :channel-max)
(frame-max :initarg :frame-max)
(heartbeat :initarg :heartbeat)
))

(defun decode-amqp-method-connection-tune-ok (ibuffer)
  (error "decode-amqp-method-connection-tune-ok not implemented"))

(defun encode-amqp-method-connection-tune-ok (method obuffer)
  (error "encode-amqp-method-connection-tune-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-tune-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-tune-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-tune-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-tune-ok))
  31)

(defclass amqp-method-connection-open (amqp-method-base)
((virtual-host :initarg :virtual-host)
(capabilities :initarg :capabilities)
(insist :initarg :insist)
))

(defun decode-amqp-method-connection-open (ibuffer)
  (error "decode-amqp-method-connection-open not implemented"))

(defun encode-amqp-method-connection-open (method obuffer)
  (error "encode-amqp-method-connection-open not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-open))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-open))
  nil)

(defmethod method-class-id ((method amqp-method-connection-open))
  10)

(defmethod method-method-id ((method amqp-method-connection-open))
  40)

(defclass amqp-method-connection-open-ok (amqp-method-base)
((known-hosts :initarg :known-hosts)
))

(defun decode-amqp-method-connection-open-ok (ibuffer)
  (error "decode-amqp-method-connection-open-ok not implemented"))

(defun encode-amqp-method-connection-open-ok (method obuffer)
  (error "encode-amqp-method-connection-open-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-open-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-open-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-open-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-open-ok))
  41)

(defclass amqp-method-connection-close (amqp-method-base)
((reply-code :initarg :reply-code)
(reply-text :initarg :reply-text)
(class-id :initarg :class-id)
(method-id :initarg :method-id)
))

(defun decode-amqp-method-connection-close (ibuffer)
  (error "decode-amqp-method-connection-close not implemented"))

(defun encode-amqp-method-connection-close (method obuffer)
  (error "encode-amqp-method-connection-close not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-close))
  t)

(defmethod method-has-content-p ((method amqp-method-connection-close))
  nil)

(defmethod method-class-id ((method amqp-method-connection-close))
  10)

(defmethod method-method-id ((method amqp-method-connection-close))
  50)

(defclass amqp-method-connection-close-ok (amqp-method-base)
())

(defun decode-amqp-method-connection-close-ok (ibuffer)
  (error "decode-amqp-method-connection-close-ok not implemented"))

(defun encode-amqp-method-connection-close-ok (method obuffer)
  (error "encode-amqp-method-connection-close-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-close-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-close-ok))
  nil)

(defmethod method-class-id ((method amqp-method-connection-close-ok))
  10)

(defmethod method-method-id ((method amqp-method-connection-close-ok))
  51)

(defclass amqp-method-connection-blocked (amqp-method-base)
((reason :initarg :reason)
))

(defun decode-amqp-method-connection-blocked (ibuffer)
  (error "decode-amqp-method-connection-blocked not implemented"))

(defun encode-amqp-method-connection-blocked (method obuffer)
  (error "encode-amqp-method-connection-blocked not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-blocked))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-blocked))
  nil)

(defmethod method-class-id ((method amqp-method-connection-blocked))
  10)

(defmethod method-method-id ((method amqp-method-connection-blocked))
  60)

(defclass amqp-method-connection-unblocked (amqp-method-base)
())

(defun decode-amqp-method-connection-unblocked (ibuffer)
  (error "decode-amqp-method-connection-unblocked not implemented"))

(defun encode-amqp-method-connection-unblocked (method obuffer)
  (error "encode-amqp-method-connection-unblocked not implemented"))

(defmethod synchronous-method-p ((method amqp-method-connection-unblocked))
  nil)

(defmethod method-has-content-p ((method amqp-method-connection-unblocked))
  nil)

(defmethod method-class-id ((method amqp-method-connection-unblocked))
  10)

(defmethod method-method-id ((method amqp-method-connection-unblocked))
  61)

(defclass amqp-method-channel-open (amqp-method-base)
((out-of-band :initarg :out-of-band)
))

(defun decode-amqp-method-channel-open (ibuffer)
  (error "decode-amqp-method-channel-open not implemented"))

(defun encode-amqp-method-channel-open (method obuffer)
  (error "encode-amqp-method-channel-open not implemented"))

(defmethod synchronous-method-p ((method amqp-method-channel-open))
  t)

(defmethod method-has-content-p ((method amqp-method-channel-open))
  nil)

(defmethod method-class-id ((method amqp-method-channel-open))
  20)

(defmethod method-method-id ((method amqp-method-channel-open))
  10)

(defclass amqp-method-channel-open-ok (amqp-method-base)
((channel-id :initarg :channel-id)
))

(defun decode-amqp-method-channel-open-ok (ibuffer)
  (error "decode-amqp-method-channel-open-ok not implemented"))

(defun encode-amqp-method-channel-open-ok (method obuffer)
  (error "encode-amqp-method-channel-open-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-channel-open-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-channel-open-ok))
  nil)

(defmethod method-class-id ((method amqp-method-channel-open-ok))
  20)

(defmethod method-method-id ((method amqp-method-channel-open-ok))
  11)

(defclass amqp-method-channel-flow (amqp-method-base)
((active :initarg :active)
))

(defun decode-amqp-method-channel-flow (ibuffer)
  (error "decode-amqp-method-channel-flow not implemented"))

(defun encode-amqp-method-channel-flow (method obuffer)
  (error "encode-amqp-method-channel-flow not implemented"))

(defmethod synchronous-method-p ((method amqp-method-channel-flow))
  t)

(defmethod method-has-content-p ((method amqp-method-channel-flow))
  nil)

(defmethod method-class-id ((method amqp-method-channel-flow))
  20)

(defmethod method-method-id ((method amqp-method-channel-flow))
  20)

(defclass amqp-method-channel-flow-ok (amqp-method-base)
((active :initarg :active)
))

(defun decode-amqp-method-channel-flow-ok (ibuffer)
  (error "decode-amqp-method-channel-flow-ok not implemented"))

(defun encode-amqp-method-channel-flow-ok (method obuffer)
  (error "encode-amqp-method-channel-flow-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-channel-flow-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-channel-flow-ok))
  nil)

(defmethod method-class-id ((method amqp-method-channel-flow-ok))
  20)

(defmethod method-method-id ((method amqp-method-channel-flow-ok))
  21)

(defclass amqp-method-channel-close (amqp-method-base)
((reply-code :initarg :reply-code)
(reply-text :initarg :reply-text)
(class-id :initarg :class-id)
(method-id :initarg :method-id)
))

(defun decode-amqp-method-channel-close (ibuffer)
  (error "decode-amqp-method-channel-close not implemented"))

(defun encode-amqp-method-channel-close (method obuffer)
  (error "encode-amqp-method-channel-close not implemented"))

(defmethod synchronous-method-p ((method amqp-method-channel-close))
  t)

(defmethod method-has-content-p ((method amqp-method-channel-close))
  nil)

(defmethod method-class-id ((method amqp-method-channel-close))
  20)

(defmethod method-method-id ((method amqp-method-channel-close))
  40)

(defclass amqp-method-channel-close-ok (amqp-method-base)
())

(defun decode-amqp-method-channel-close-ok (ibuffer)
  (error "decode-amqp-method-channel-close-ok not implemented"))

(defun encode-amqp-method-channel-close-ok (method obuffer)
  (error "encode-amqp-method-channel-close-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-channel-close-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-channel-close-ok))
  nil)

(defmethod method-class-id ((method amqp-method-channel-close-ok))
  20)

(defmethod method-method-id ((method amqp-method-channel-close-ok))
  41)

(defclass amqp-method-access-request (amqp-method-base)
((realm :initarg :realm)
(exclusive :initarg :exclusive)
(passive :initarg :passive)
(active :initarg :active)
(write :initarg :write)
(read :initarg :read)
))

(defun decode-amqp-method-access-request (ibuffer)
  (error "decode-amqp-method-access-request not implemented"))

(defun encode-amqp-method-access-request (method obuffer)
  (error "encode-amqp-method-access-request not implemented"))

(defmethod synchronous-method-p ((method amqp-method-access-request))
  t)

(defmethod method-has-content-p ((method amqp-method-access-request))
  nil)

(defmethod method-class-id ((method amqp-method-access-request))
  30)

(defmethod method-method-id ((method amqp-method-access-request))
  10)

(defclass amqp-method-access-request-ok (amqp-method-base)
((ticket :initarg :ticket)
))

(defun decode-amqp-method-access-request-ok (ibuffer)
  (error "decode-amqp-method-access-request-ok not implemented"))

(defun encode-amqp-method-access-request-ok (method obuffer)
  (error "encode-amqp-method-access-request-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-access-request-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-access-request-ok))
  nil)

(defmethod method-class-id ((method amqp-method-access-request-ok))
  30)

(defmethod method-method-id ((method amqp-method-access-request-ok))
  11)

(defclass amqp-method-exchange-declare (amqp-method-base)
((ticket :initarg :ticket)
(exchange :initarg :exchange)
(type :initarg :type)
(passive :initarg :passive)
(durable :initarg :durable)
(auto-delete :initarg :auto-delete)
(internal :initarg :internal)
(nowait :initarg :nowait)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-exchange-declare (ibuffer)
  (error "decode-amqp-method-exchange-declare not implemented"))

(defun encode-amqp-method-exchange-declare (method obuffer)
  (error "encode-amqp-method-exchange-declare not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-declare))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-declare))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-declare))
  40)

(defmethod method-method-id ((method amqp-method-exchange-declare))
  10)

(defclass amqp-method-exchange-declare-ok (amqp-method-base)
())

(defun decode-amqp-method-exchange-declare-ok (ibuffer)
  (error "decode-amqp-method-exchange-declare-ok not implemented"))

(defun encode-amqp-method-exchange-declare-ok (method obuffer)
  (error "encode-amqp-method-exchange-declare-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-declare-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-declare-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-declare-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-declare-ok))
  11)

(defclass amqp-method-exchange-delete (amqp-method-base)
((ticket :initarg :ticket)
(exchange :initarg :exchange)
(if-unused :initarg :if-unused)
(nowait :initarg :nowait)
))

(defun decode-amqp-method-exchange-delete (ibuffer)
  (error "decode-amqp-method-exchange-delete not implemented"))

(defun encode-amqp-method-exchange-delete (method obuffer)
  (error "encode-amqp-method-exchange-delete not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-delete))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-delete))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-delete))
  40)

(defmethod method-method-id ((method amqp-method-exchange-delete))
  20)

(defclass amqp-method-exchange-delete-ok (amqp-method-base)
())

(defun decode-amqp-method-exchange-delete-ok (ibuffer)
  (error "decode-amqp-method-exchange-delete-ok not implemented"))

(defun encode-amqp-method-exchange-delete-ok (method obuffer)
  (error "encode-amqp-method-exchange-delete-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-delete-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-delete-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-delete-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-delete-ok))
  21)

(defclass amqp-method-exchange-bind (amqp-method-base)
((ticket :initarg :ticket)
(destination :initarg :destination)
(source :initarg :source)
(routing-key :initarg :routing-key)
(nowait :initarg :nowait)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-exchange-bind (ibuffer)
  (error "decode-amqp-method-exchange-bind not implemented"))

(defun encode-amqp-method-exchange-bind (method obuffer)
  (error "encode-amqp-method-exchange-bind not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-bind))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-bind))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-bind))
  40)

(defmethod method-method-id ((method amqp-method-exchange-bind))
  30)

(defclass amqp-method-exchange-bind-ok (amqp-method-base)
())

(defun decode-amqp-method-exchange-bind-ok (ibuffer)
  (error "decode-amqp-method-exchange-bind-ok not implemented"))

(defun encode-amqp-method-exchange-bind-ok (method obuffer)
  (error "encode-amqp-method-exchange-bind-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-bind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-bind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-bind-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-bind-ok))
  31)

(defclass amqp-method-exchange-unbind (amqp-method-base)
((ticket :initarg :ticket)
(destination :initarg :destination)
(source :initarg :source)
(routing-key :initarg :routing-key)
(nowait :initarg :nowait)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-exchange-unbind (ibuffer)
  (error "decode-amqp-method-exchange-unbind not implemented"))

(defun encode-amqp-method-exchange-unbind (method obuffer)
  (error "encode-amqp-method-exchange-unbind not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-unbind))
  t)

(defmethod method-has-content-p ((method amqp-method-exchange-unbind))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-unbind))
  40)

(defmethod method-method-id ((method amqp-method-exchange-unbind))
  40)

(defclass amqp-method-exchange-unbind-ok (amqp-method-base)
())

(defun decode-amqp-method-exchange-unbind-ok (ibuffer)
  (error "decode-amqp-method-exchange-unbind-ok not implemented"))

(defun encode-amqp-method-exchange-unbind-ok (method obuffer)
  (error "encode-amqp-method-exchange-unbind-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-exchange-unbind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-exchange-unbind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-exchange-unbind-ok))
  40)

(defmethod method-method-id ((method amqp-method-exchange-unbind-ok))
  51)

(defclass amqp-method-queue-declare (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(passive :initarg :passive)
(durable :initarg :durable)
(exclusive :initarg :exclusive)
(auto-delete :initarg :auto-delete)
(nowait :initarg :nowait)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-queue-declare (ibuffer)
  (error "decode-amqp-method-queue-declare not implemented"))

(defun encode-amqp-method-queue-declare (method obuffer)
  (error "encode-amqp-method-queue-declare not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-declare))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-declare))
  nil)

(defmethod method-class-id ((method amqp-method-queue-declare))
  50)

(defmethod method-method-id ((method amqp-method-queue-declare))
  10)

(defclass amqp-method-queue-declare-ok (amqp-method-base)
((queue :initarg :queue)
(message-count :initarg :message-count)
(consumer-count :initarg :consumer-count)
))

(defun decode-amqp-method-queue-declare-ok (ibuffer)
  (error "decode-amqp-method-queue-declare-ok not implemented"))

(defun encode-amqp-method-queue-declare-ok (method obuffer)
  (error "encode-amqp-method-queue-declare-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-declare-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-declare-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-declare-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-declare-ok))
  11)

(defclass amqp-method-queue-bind (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(exchange :initarg :exchange)
(routing-key :initarg :routing-key)
(nowait :initarg :nowait)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-queue-bind (ibuffer)
  (error "decode-amqp-method-queue-bind not implemented"))

(defun encode-amqp-method-queue-bind (method obuffer)
  (error "encode-amqp-method-queue-bind not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-bind))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-bind))
  nil)

(defmethod method-class-id ((method amqp-method-queue-bind))
  50)

(defmethod method-method-id ((method amqp-method-queue-bind))
  20)

(defclass amqp-method-queue-bind-ok (amqp-method-base)
())

(defun decode-amqp-method-queue-bind-ok (ibuffer)
  (error "decode-amqp-method-queue-bind-ok not implemented"))

(defun encode-amqp-method-queue-bind-ok (method obuffer)
  (error "encode-amqp-method-queue-bind-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-bind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-bind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-bind-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-bind-ok))
  21)

(defclass amqp-method-queue-purge (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(nowait :initarg :nowait)
))

(defun decode-amqp-method-queue-purge (ibuffer)
  (error "decode-amqp-method-queue-purge not implemented"))

(defun encode-amqp-method-queue-purge (method obuffer)
  (error "encode-amqp-method-queue-purge not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-purge))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-purge))
  nil)

(defmethod method-class-id ((method amqp-method-queue-purge))
  50)

(defmethod method-method-id ((method amqp-method-queue-purge))
  30)

(defclass amqp-method-queue-purge-ok (amqp-method-base)
((message-count :initarg :message-count)
))

(defun decode-amqp-method-queue-purge-ok (ibuffer)
  (error "decode-amqp-method-queue-purge-ok not implemented"))

(defun encode-amqp-method-queue-purge-ok (method obuffer)
  (error "encode-amqp-method-queue-purge-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-purge-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-purge-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-purge-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-purge-ok))
  31)

(defclass amqp-method-queue-delete (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(if-unused :initarg :if-unused)
(if-empty :initarg :if-empty)
(nowait :initarg :nowait)
))

(defun decode-amqp-method-queue-delete (ibuffer)
  (error "decode-amqp-method-queue-delete not implemented"))

(defun encode-amqp-method-queue-delete (method obuffer)
  (error "encode-amqp-method-queue-delete not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-delete))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-delete))
  nil)

(defmethod method-class-id ((method amqp-method-queue-delete))
  50)

(defmethod method-method-id ((method amqp-method-queue-delete))
  40)

(defclass amqp-method-queue-delete-ok (amqp-method-base)
((message-count :initarg :message-count)
))

(defun decode-amqp-method-queue-delete-ok (ibuffer)
  (error "decode-amqp-method-queue-delete-ok not implemented"))

(defun encode-amqp-method-queue-delete-ok (method obuffer)
  (error "encode-amqp-method-queue-delete-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-delete-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-delete-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-delete-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-delete-ok))
  41)

(defclass amqp-method-queue-unbind (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(exchange :initarg :exchange)
(routing-key :initarg :routing-key)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-queue-unbind (ibuffer)
  (error "decode-amqp-method-queue-unbind not implemented"))

(defun encode-amqp-method-queue-unbind (method obuffer)
  (error "encode-amqp-method-queue-unbind not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-unbind))
  t)

(defmethod method-has-content-p ((method amqp-method-queue-unbind))
  nil)

(defmethod method-class-id ((method amqp-method-queue-unbind))
  50)

(defmethod method-method-id ((method amqp-method-queue-unbind))
  50)

(defclass amqp-method-queue-unbind-ok (amqp-method-base)
())

(defun decode-amqp-method-queue-unbind-ok (ibuffer)
  (error "decode-amqp-method-queue-unbind-ok not implemented"))

(defun encode-amqp-method-queue-unbind-ok (method obuffer)
  (error "encode-amqp-method-queue-unbind-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-queue-unbind-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-queue-unbind-ok))
  nil)

(defmethod method-class-id ((method amqp-method-queue-unbind-ok))
  50)

(defmethod method-method-id ((method amqp-method-queue-unbind-ok))
  51)

(defclass amqp-method-basic-qos (amqp-method-base)
((prefetch-size :initarg :prefetch-size)
(prefetch-count :initarg :prefetch-count)
(global :initarg :global)
))

(defun decode-amqp-method-basic-qos (ibuffer)
  (error "decode-amqp-method-basic-qos not implemented"))

(defun encode-amqp-method-basic-qos (method obuffer)
  (error "encode-amqp-method-basic-qos not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-qos))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-qos))
  nil)

(defmethod method-class-id ((method amqp-method-basic-qos))
  60)

(defmethod method-method-id ((method amqp-method-basic-qos))
  10)

(defclass amqp-method-basic-qos-ok (amqp-method-base)
())

(defun decode-amqp-method-basic-qos-ok (ibuffer)
  (error "decode-amqp-method-basic-qos-ok not implemented"))

(defun encode-amqp-method-basic-qos-ok (method obuffer)
  (error "encode-amqp-method-basic-qos-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-qos-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-qos-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-qos-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-qos-ok))
  11)

(defclass amqp-method-basic-consume (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(consumer-tag :initarg :consumer-tag)
(no-local :initarg :no-local)
(no-ack :initarg :no-ack)
(exclusive :initarg :exclusive)
(nowait :initarg :nowait)
(arguments :initarg :arguments)
))

(defun decode-amqp-method-basic-consume (ibuffer)
  (error "decode-amqp-method-basic-consume not implemented"))

(defun encode-amqp-method-basic-consume (method obuffer)
  (error "encode-amqp-method-basic-consume not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-consume))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-consume))
  nil)

(defmethod method-class-id ((method amqp-method-basic-consume))
  60)

(defmethod method-method-id ((method amqp-method-basic-consume))
  20)

(defclass amqp-method-basic-consume-ok (amqp-method-base)
((consumer-tag :initarg :consumer-tag)
))

(defun decode-amqp-method-basic-consume-ok (ibuffer)
  (error "decode-amqp-method-basic-consume-ok not implemented"))

(defun encode-amqp-method-basic-consume-ok (method obuffer)
  (error "encode-amqp-method-basic-consume-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-consume-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-consume-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-consume-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-consume-ok))
  21)

(defclass amqp-method-basic-cancel (amqp-method-base)
((consumer-tag :initarg :consumer-tag)
(nowait :initarg :nowait)
))

(defun decode-amqp-method-basic-cancel (ibuffer)
  (error "decode-amqp-method-basic-cancel not implemented"))

(defun encode-amqp-method-basic-cancel (method obuffer)
  (error "encode-amqp-method-basic-cancel not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-cancel))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-cancel))
  nil)

(defmethod method-class-id ((method amqp-method-basic-cancel))
  60)

(defmethod method-method-id ((method amqp-method-basic-cancel))
  30)

(defclass amqp-method-basic-cancel-ok (amqp-method-base)
((consumer-tag :initarg :consumer-tag)
))

(defun decode-amqp-method-basic-cancel-ok (ibuffer)
  (error "decode-amqp-method-basic-cancel-ok not implemented"))

(defun encode-amqp-method-basic-cancel-ok (method obuffer)
  (error "encode-amqp-method-basic-cancel-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-cancel-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-cancel-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-cancel-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-cancel-ok))
  31)

(defclass amqp-method-basic-publish (amqp-method-base)
((ticket :initarg :ticket)
(exchange :initarg :exchange)
(routing-key :initarg :routing-key)
(mandatory :initarg :mandatory)
(immediate :initarg :immediate)
))

(defun decode-amqp-method-basic-publish (ibuffer)
  (error "decode-amqp-method-basic-publish not implemented"))

(defun encode-amqp-method-basic-publish (method obuffer)
  (error "encode-amqp-method-basic-publish not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-publish))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-publish))
  t)

(defmethod method-class-id ((method amqp-method-basic-publish))
  60)

(defmethod method-method-id ((method amqp-method-basic-publish))
  40)

(defclass amqp-method-basic-return (amqp-method-base)
((reply-code :initarg :reply-code)
(reply-text :initarg :reply-text)
(exchange :initarg :exchange)
(routing-key :initarg :routing-key)
))

(defun decode-amqp-method-basic-return (ibuffer)
  (error "decode-amqp-method-basic-return not implemented"))

(defun encode-amqp-method-basic-return (method obuffer)
  (error "encode-amqp-method-basic-return not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-return))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-return))
  t)

(defmethod method-class-id ((method amqp-method-basic-return))
  60)

(defmethod method-method-id ((method amqp-method-basic-return))
  50)

(defclass amqp-method-basic-deliver (amqp-method-base)
((consumer-tag :initarg :consumer-tag)
(delivery-tag :initarg :delivery-tag)
(redelivered :initarg :redelivered)
(exchange :initarg :exchange)
(routing-key :initarg :routing-key)
))

(defun decode-amqp-method-basic-deliver (ibuffer)
  (error "decode-amqp-method-basic-deliver not implemented"))

(defun encode-amqp-method-basic-deliver (method obuffer)
  (error "encode-amqp-method-basic-deliver not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-deliver))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-deliver))
  t)

(defmethod method-class-id ((method amqp-method-basic-deliver))
  60)

(defmethod method-method-id ((method amqp-method-basic-deliver))
  60)

(defclass amqp-method-basic-get (amqp-method-base)
((ticket :initarg :ticket)
(queue :initarg :queue)
(no-ack :initarg :no-ack)
))

(defun decode-amqp-method-basic-get (ibuffer)
  (error "decode-amqp-method-basic-get not implemented"))

(defun encode-amqp-method-basic-get (method obuffer)
  (error "encode-amqp-method-basic-get not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-get))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-get))
  nil)

(defmethod method-class-id ((method amqp-method-basic-get))
  60)

(defmethod method-method-id ((method amqp-method-basic-get))
  70)

(defclass amqp-method-basic-get-ok (amqp-method-base)
((delivery-tag :initarg :delivery-tag)
(redelivered :initarg :redelivered)
(exchange :initarg :exchange)
(routing-key :initarg :routing-key)
(message-count :initarg :message-count)
))

(defun decode-amqp-method-basic-get-ok (ibuffer)
  (error "decode-amqp-method-basic-get-ok not implemented"))

(defun encode-amqp-method-basic-get-ok (method obuffer)
  (error "encode-amqp-method-basic-get-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-get-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-get-ok))
  t)

(defmethod method-class-id ((method amqp-method-basic-get-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-get-ok))
  71)

(defclass amqp-method-basic-get-empty (amqp-method-base)
((cluster-id :initarg :cluster-id)
))

(defun decode-amqp-method-basic-get-empty (ibuffer)
  (error "decode-amqp-method-basic-get-empty not implemented"))

(defun encode-amqp-method-basic-get-empty (method obuffer)
  (error "encode-amqp-method-basic-get-empty not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-get-empty))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-get-empty))
  nil)

(defmethod method-class-id ((method amqp-method-basic-get-empty))
  60)

(defmethod method-method-id ((method amqp-method-basic-get-empty))
  72)

(defclass amqp-method-basic-ack (amqp-method-base)
((delivery-tag :initarg :delivery-tag)
(multiple :initarg :multiple)
))

(defun decode-amqp-method-basic-ack (ibuffer)
  (error "decode-amqp-method-basic-ack not implemented"))

(defun encode-amqp-method-basic-ack (method obuffer)
  (error "encode-amqp-method-basic-ack not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-ack))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-ack))
  nil)

(defmethod method-class-id ((method amqp-method-basic-ack))
  60)

(defmethod method-method-id ((method amqp-method-basic-ack))
  80)

(defclass amqp-method-basic-reject (amqp-method-base)
((delivery-tag :initarg :delivery-tag)
(requeue :initarg :requeue)
))

(defun decode-amqp-method-basic-reject (ibuffer)
  (error "decode-amqp-method-basic-reject not implemented"))

(defun encode-amqp-method-basic-reject (method obuffer)
  (error "encode-amqp-method-basic-reject not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-reject))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-reject))
  nil)

(defmethod method-class-id ((method amqp-method-basic-reject))
  60)

(defmethod method-method-id ((method amqp-method-basic-reject))
  90)

(defclass amqp-method-basic-recover-async (amqp-method-base)
((requeue :initarg :requeue)
))

(defun decode-amqp-method-basic-recover-async (ibuffer)
  (error "decode-amqp-method-basic-recover-async not implemented"))

(defun encode-amqp-method-basic-recover-async (method obuffer)
  (error "encode-amqp-method-basic-recover-async not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-recover-async))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-recover-async))
  nil)

(defmethod method-class-id ((method amqp-method-basic-recover-async))
  60)

(defmethod method-method-id ((method amqp-method-basic-recover-async))
  100)

(defclass amqp-method-basic-recover (amqp-method-base)
((requeue :initarg :requeue)
))

(defun decode-amqp-method-basic-recover (ibuffer)
  (error "decode-amqp-method-basic-recover not implemented"))

(defun encode-amqp-method-basic-recover (method obuffer)
  (error "encode-amqp-method-basic-recover not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-recover))
  t)

(defmethod method-has-content-p ((method amqp-method-basic-recover))
  nil)

(defmethod method-class-id ((method amqp-method-basic-recover))
  60)

(defmethod method-method-id ((method amqp-method-basic-recover))
  110)

(defclass amqp-method-basic-recover-ok (amqp-method-base)
())

(defun decode-amqp-method-basic-recover-ok (ibuffer)
  (error "decode-amqp-method-basic-recover-ok not implemented"))

(defun encode-amqp-method-basic-recover-ok (method obuffer)
  (error "encode-amqp-method-basic-recover-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-recover-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-recover-ok))
  nil)

(defmethod method-class-id ((method amqp-method-basic-recover-ok))
  60)

(defmethod method-method-id ((method amqp-method-basic-recover-ok))
  111)

(defclass amqp-method-basic-nack (amqp-method-base)
((delivery-tag :initarg :delivery-tag)
(multiple :initarg :multiple)
(requeue :initarg :requeue)
))

(defun decode-amqp-method-basic-nack (ibuffer)
  (error "decode-amqp-method-basic-nack not implemented"))

(defun encode-amqp-method-basic-nack (method obuffer)
  (error "encode-amqp-method-basic-nack not implemented"))

(defmethod synchronous-method-p ((method amqp-method-basic-nack))
  nil)

(defmethod method-has-content-p ((method amqp-method-basic-nack))
  nil)

(defmethod method-class-id ((method amqp-method-basic-nack))
  60)

(defmethod method-method-id ((method amqp-method-basic-nack))
  120)

(defclass amqp-method-tx-select (amqp-method-base)
())

(defun decode-amqp-method-tx-select (ibuffer)
  (error "decode-amqp-method-tx-select not implemented"))

(defun encode-amqp-method-tx-select (method obuffer)
  (error "encode-amqp-method-tx-select not implemented"))

(defmethod synchronous-method-p ((method amqp-method-tx-select))
  t)

(defmethod method-has-content-p ((method amqp-method-tx-select))
  nil)

(defmethod method-class-id ((method amqp-method-tx-select))
  90)

(defmethod method-method-id ((method amqp-method-tx-select))
  10)

(defclass amqp-method-tx-select-ok (amqp-method-base)
())

(defun decode-amqp-method-tx-select-ok (ibuffer)
  (error "decode-amqp-method-tx-select-ok not implemented"))

(defun encode-amqp-method-tx-select-ok (method obuffer)
  (error "encode-amqp-method-tx-select-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-tx-select-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-tx-select-ok))
  nil)

(defmethod method-class-id ((method amqp-method-tx-select-ok))
  90)

(defmethod method-method-id ((method amqp-method-tx-select-ok))
  11)

(defclass amqp-method-tx-commit (amqp-method-base)
())

(defun decode-amqp-method-tx-commit (ibuffer)
  (error "decode-amqp-method-tx-commit not implemented"))

(defun encode-amqp-method-tx-commit (method obuffer)
  (error "encode-amqp-method-tx-commit not implemented"))

(defmethod synchronous-method-p ((method amqp-method-tx-commit))
  t)

(defmethod method-has-content-p ((method amqp-method-tx-commit))
  nil)

(defmethod method-class-id ((method amqp-method-tx-commit))
  90)

(defmethod method-method-id ((method amqp-method-tx-commit))
  20)

(defclass amqp-method-tx-commit-ok (amqp-method-base)
())

(defun decode-amqp-method-tx-commit-ok (ibuffer)
  (error "decode-amqp-method-tx-commit-ok not implemented"))

(defun encode-amqp-method-tx-commit-ok (method obuffer)
  (error "encode-amqp-method-tx-commit-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-tx-commit-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-tx-commit-ok))
  nil)

(defmethod method-class-id ((method amqp-method-tx-commit-ok))
  90)

(defmethod method-method-id ((method amqp-method-tx-commit-ok))
  21)

(defclass amqp-method-tx-rollback (amqp-method-base)
())

(defun decode-amqp-method-tx-rollback (ibuffer)
  (error "decode-amqp-method-tx-rollback not implemented"))

(defun encode-amqp-method-tx-rollback (method obuffer)
  (error "encode-amqp-method-tx-rollback not implemented"))

(defmethod synchronous-method-p ((method amqp-method-tx-rollback))
  t)

(defmethod method-has-content-p ((method amqp-method-tx-rollback))
  nil)

(defmethod method-class-id ((method amqp-method-tx-rollback))
  90)

(defmethod method-method-id ((method amqp-method-tx-rollback))
  30)

(defclass amqp-method-tx-rollback-ok (amqp-method-base)
())

(defun decode-amqp-method-tx-rollback-ok (ibuffer)
  (error "decode-amqp-method-tx-rollback-ok not implemented"))

(defun encode-amqp-method-tx-rollback-ok (method obuffer)
  (error "encode-amqp-method-tx-rollback-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-tx-rollback-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-tx-rollback-ok))
  nil)

(defmethod method-class-id ((method amqp-method-tx-rollback-ok))
  90)

(defmethod method-method-id ((method amqp-method-tx-rollback-ok))
  31)

(defclass amqp-method-confirm-select (amqp-method-base)
((nowait :initarg :nowait)
))

(defun decode-amqp-method-confirm-select (ibuffer)
  (error "decode-amqp-method-confirm-select not implemented"))

(defun encode-amqp-method-confirm-select (method obuffer)
  (error "encode-amqp-method-confirm-select not implemented"))

(defmethod synchronous-method-p ((method amqp-method-confirm-select))
  t)

(defmethod method-has-content-p ((method amqp-method-confirm-select))
  nil)

(defmethod method-class-id ((method amqp-method-confirm-select))
  85)

(defmethod method-method-id ((method amqp-method-confirm-select))
  10)

(defclass amqp-method-confirm-select-ok (amqp-method-base)
())

(defun decode-amqp-method-confirm-select-ok (ibuffer)
  (error "decode-amqp-method-confirm-select-ok not implemented"))

(defun encode-amqp-method-confirm-select-ok (method obuffer)
  (error "encode-amqp-method-confirm-select-ok not implemented"))

(defmethod synchronous-method-p ((method amqp-method-confirm-select-ok))
  nil)

(defmethod method-has-content-p ((method amqp-method-confirm-select-ok))
  nil)

(defmethod method-class-id ((method amqp-method-confirm-select-ok))
  85)

(defmethod method-method-id ((method amqp-method-confirm-select-ok))
  11)


(defun decode-method (method-class ibuffer)
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

(defun encode-method (method obuffer)
  (case (class-of method-class)
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
    (t (error 'amqp-unknown-method-class-error :method-class (class-of method-class)))))


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
    (#xa000a000 'amqp-method-connection-start)
    (#xa000b000 'amqp-method-connection-start-ok)
    (#xa0014000 'amqp-method-connection-secure)
    (#xa0015000 'amqp-method-connection-secure-ok)
    (#xa001e000 'amqp-method-connection-tune)
    (#xa001f000 'amqp-method-connection-tune-ok)
    (#xa0028000 'amqp-method-connection-open)
    (#xa0029000 'amqp-method-connection-open-ok)
    (#xa0032000 'amqp-method-connection-close)
    (#xa0033000 'amqp-method-connection-close-ok)
    (#xa003c000 'amqp-method-connection-blocked)
    (#xa003d000 'amqp-method-connection-unblocked)
    (#x14000a00 'amqp-method-channel-open)
    (#x14000b00 'amqp-method-channel-open-ok)
    (#x14001400 'amqp-method-channel-flow)
    (#x14001500 'amqp-method-channel-flow-ok)
    (#x14002800 'amqp-method-channel-close)
    (#x14002900 'amqp-method-channel-close-ok)
    (#x1e000a00 'amqp-method-access-request)
    (#x1e000b00 'amqp-method-access-request-ok)
    (#x28000a00 'amqp-method-exchange-declare)
    (#x28000b00 'amqp-method-exchange-declare-ok)
    (#x28001400 'amqp-method-exchange-delete)
    (#x28001500 'amqp-method-exchange-delete-ok)
    (#x28001e00 'amqp-method-exchange-bind)
    (#x28001f00 'amqp-method-exchange-bind-ok)
    (#x28002800 'amqp-method-exchange-unbind)
    (#x28003300 'amqp-method-exchange-unbind-ok)
    (#x32000a00 'amqp-method-queue-declare)
    (#x32000b00 'amqp-method-queue-declare-ok)
    (#x32001400 'amqp-method-queue-bind)
    (#x32001500 'amqp-method-queue-bind-ok)
    (#x32001e00 'amqp-method-queue-purge)
    (#x32001f00 'amqp-method-queue-purge-ok)
    (#x32002800 'amqp-method-queue-delete)
    (#x32002900 'amqp-method-queue-delete-ok)
    (#x32003200 'amqp-method-queue-unbind)
    (#x32003300 'amqp-method-queue-unbind-ok)
    (#x3c000a00 'amqp-method-basic-qos)
    (#x3c000b00 'amqp-method-basic-qos-ok)
    (#x3c001400 'amqp-method-basic-consume)
    (#x3c001500 'amqp-method-basic-consume-ok)
    (#x3c001e00 'amqp-method-basic-cancel)
    (#x3c001f00 'amqp-method-basic-cancel-ok)
    (#x3c002800 'amqp-method-basic-publish)
    (#x3c003200 'amqp-method-basic-return)
    (#x3c003c00 'amqp-method-basic-deliver)
    (#x3c004600 'amqp-method-basic-get)
    (#x3c004700 'amqp-method-basic-get-ok)
    (#x3c004800 'amqp-method-basic-get-empty)
    (#x3c005000 'amqp-method-basic-ack)
    (#x3c005a00 'amqp-method-basic-reject)
    (#x3c006400 'amqp-method-basic-recover-async)
    (#x3c006e00 'amqp-method-basic-recover)
    (#x3c006f00 'amqp-method-basic-recover-ok)
    (#x3c007800 'amqp-method-basic-nack)
    (#x5a000a00 'amqp-method-tx-select)
    (#x5a000b00 'amqp-method-tx-select-ok)
    (#x5a001400 'amqp-method-tx-commit)
    (#x5a001500 'amqp-method-tx-commit-ok)
    (#x5a001e00 'amqp-method-tx-rollback)
    (#x5a001f00 'amqp-method-tx-rollback-ok)
    (#x55000a00 'amqp-method-confirm-select)
    (#x55000b00 'amqp-method-confirm-select-ok)
    (t (error 'amqp-unknown-method-error :method-signature signature))))
