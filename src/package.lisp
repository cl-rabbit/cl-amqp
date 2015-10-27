;; DO NOT EDIT. RUN GENERATE TO REGENERATE

(in-package :cl-user)

(defpackage :cl-amqp
  (:use :cl :alexandria :collectors)
  (:nicknames :amqp)
  (:export ;; constants
           #:+amqp-port+
           #:+amqp-frame-method+
           #:+amqp-frame-header+
           #:+amqp-frame-body+
           #:+amqp-frame-heartbeat+
           #:+amqp-frame-min-size+
           #:+amqp-frame-end+
           #:+amqp-reply-success+
           #:+amqp-content-too-large+
           #:+amqp-no-route+
           #:+amqp-no-consumers+
           #:+amqp-access-refused+
           #:+amqp-not-found+
           #:+amqp-resource-locked+
           #:+amqp-precondition-failed+
           #:+amqp-connection-forced+
           #:+amqp-invalid-path+
           #:+amqp-frame-error+
           #:+amqp-syntax-error+
           #:+amqp-command-invalid+
           #:+amqp-channel-error+
           #:+amqp-unexpected-frame+
           #:+amqp-resource-error+
           #:+amqp-not-allowed+
           #:+amqp-not-implemented+
           #:+amqp-internal-error+

           ;; conditions
           #:error-type-from-reply-code
           #:amqp-unknown-reply-code-error
           #:amqp-protocol-error
           #:amqp-channel-error
           #:amqp-connection-error
           #:amqp-error-internal-error
           #:malformed-frame-error
           #:invalid-frame-parser-state-error
           #:frame-class-from-frame-type
           #:amqp-unknown-frame-type-error
           #:amqp-error-content-too-large
           #:amqp-error-no-route
           #:amqp-error-no-consumers
           #:amqp-error-access-refused
           #:amqp-error-not-found
           #:amqp-error-resource-locked
           #:amqp-error-precondition-failed
           #:amqp-error-connection-forced
           #:amqp-error-invalid-path
           #:amqp-error-frame-error
           #:amqp-error-syntax-error
           #:amqp-error-command-invalid
           #:amqp-error-channel-error
           #:amqp-error-unexpected-frame
           #:amqp-error-resource-error
           #:amqp-error-not-allowed
           #:amqp-error-not-implemented
           #:amqp-error-internal-error


           ;; frames
           #:make-frame-parser
           #:make-frame-payload-parser
           #:frame-payload-parser-consume
           #:frame-payload-parser-finish
           #:method-frame
           #:header-frame
           #:heartbeat-frame
           #:frame-channel
           #:frame-payload-size
           #:frame-payload
           #:frame-encoder
           #:frame-parser-consume

           ;; binary strings
           #:enable-binary-string-syntax
           #:disable-binary-string-syntax
           #:enable-binary-string-printing
           #:disable-binary-string-printing

           ;; i/o buffers
           #:new-obuffer
           #:obuffer-get-bytes

           ;; methods
           #:amqp-method-connection-start
           #:amqp-method-connection-start-ok
           #:amqp-method-connection-secure
           #:amqp-method-connection-secure-ok
           #:amqp-method-connection-tune
           #:amqp-method-connection-tune-ok
           #:amqp-method-connection-open
           #:amqp-method-connection-open-ok
           #:amqp-method-connection-close
           #:amqp-method-connection-close-ok
           #:amqp-method-connection-blocked
           #:amqp-method-connection-unblocked
           #:amqp-method-channel-open
           #:amqp-method-channel-open-ok
           #:amqp-method-channel-flow
           #:amqp-method-channel-flow-ok
           #:amqp-method-channel-close
           #:amqp-method-channel-close-ok
           #:amqp-method-access-request
           #:amqp-method-access-request-ok
           #:amqp-method-exchange-declare
           #:amqp-method-exchange-declare-ok
           #:amqp-method-exchange-delete
           #:amqp-method-exchange-delete-ok
           #:amqp-method-exchange-bind
           #:amqp-method-exchange-bind-ok
           #:amqp-method-exchange-unbind
           #:amqp-method-exchange-unbind-ok
           #:amqp-method-queue-declare
           #:amqp-method-queue-declare-ok
           #:amqp-method-queue-bind
           #:amqp-method-queue-bind-ok
           #:amqp-method-queue-purge
           #:amqp-method-queue-purge-ok
           #:amqp-method-queue-delete
           #:amqp-method-queue-delete-ok
           #:amqp-method-queue-unbind
           #:amqp-method-queue-unbind-ok
           #:amqp-method-basic-qos
           #:amqp-method-basic-qos-ok
           #:amqp-method-basic-consume
           #:amqp-method-basic-consume-ok
           #:amqp-method-basic-cancel
           #:amqp-method-basic-cancel-ok
           #:amqp-method-basic-publish
           #:amqp-method-basic-return
           #:amqp-method-basic-deliver
           #:amqp-method-basic-get
           #:amqp-method-basic-get-ok
           #:amqp-method-basic-get-empty
           #:amqp-method-basic-ack
           #:amqp-method-basic-reject
           #:amqp-method-basic-recover-async
           #:amqp-method-basic-recover
           #:amqp-method-basic-recover-ok
           #:amqp-method-basic-nack
           #:amqp-method-tx-select
           #:amqp-method-tx-select-ok
           #:amqp-method-tx-commit
           #:amqp-method-tx-commit-ok
           #:amqp-method-tx-rollback
           #:amqp-method-tx-rollback-ok
           #:amqp-method-confirm-select
           #:amqp-method-confirm-select-ok
           #:amqp-basic-class-properties ;; TODO: are you sure about amqp- prefix?
                                         ;; it prefixed with package name already
           #:method-decode
           #:method-class-from-signature
   ))
