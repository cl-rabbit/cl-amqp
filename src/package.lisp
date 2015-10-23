(in-package :cl-user)

(defpackage :cl-amqp
  (:use :cl :alexandria :collectors)
  (:nicknames :amqp)
  (:export #:error-type-from-reply-code
           #:amqp-unknown-reply-code-error

           #:make-frame-parser ;; frames stuff
           #:make-frame-payload-parser
           #:frame-payload-parser-consume
           #:frame-payload-parser-finish
           #:+amqp-frame-method+
           #:method-frame
           #:frame-channel
           #:frame-size
           #:frame-payload
           #:frame-encode
           #:frame-parser-consume
           #:malformed-frame-error
           #:invalid-frame-parser-state-error
           #:frame-class-from-frame-type
           #:amqp-unknown-frame-type-error

           #:enable-binary-string-syntax
           #:disable-binary-string-syntax
           #:enable-binary-string-printing
           #:disable-binary-string-printing

           #:new-obuffer
           #:obuffer-get-bytes

           #:amqp-method-basic-ack ;; TODO: generate for this and other methods
           #:method-decode
           #:method-class-from-signature
   ))
