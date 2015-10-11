(in-package :cl-user)

(defpackage :cl-amqp
  (:use :cl :alexandria)
  (:nicknames :amqp)
  (:export :error-type-from-reply-code ;; conditions, maybe auto-generate?
           :amqp-unknown-reply-code-error

           :make-frame-parser ;; frames stuff
           :frame-parser-consume
           :malformed-frame-error
           :invalid-frame-parser-state-error

           :enable-binary-string-syntax))
