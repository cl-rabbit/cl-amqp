;; DO NOT EDIT. RUN GENERATE TO REGENERATE

(in-package :cl-amqp)

(define-condition amqp-base-error (error)
  ())

(define-condition amqp-protocol-error (amqp-base-error)
  ((reply-code :reader amqp-error-reply-code) ;auto-generated
   (reply-text :initarg :reply-text
               :reader amqp-error-reply-text)
   (connection :initarg :connection
               :reader amqp-error-connection)
   (channel :initarg :channel
            :reader amqp-error-channel)
   (class :initarg :class
          :reader amqp-error-class)
   (method :initarg :method
           :reader amqp-error-method)))

(define-condition amqp-channel-error (amqp-protocol-error)
  ((channel :initarg :channel
            :reader amqp-error-channel)))

(define-condition amqp-connection-error (amqp-protocol-error)
  ())

(define-condition amqp-error-content-too-large (amqp-channel-error)
  ((reply-code :initform 311)))

(define-condition amqp-error-no-route (amqp-channel-error)
  ((reply-code :initform 312)))

(define-condition amqp-error-no-consumers (amqp-channel-error)
  ((reply-code :initform 313)))

(define-condition amqp-error-access-refused (amqp-channel-error)
  ((reply-code :initform 403)))

(define-condition amqp-error-not-found (amqp-channel-error)
  ((reply-code :initform 404)))

(define-condition amqp-error-resource-locked (amqp-channel-error)
  ((reply-code :initform 405)))

(define-condition amqp-error-precondition-failed (amqp-channel-error)
  ((reply-code :initform 406)))

(define-condition amqp-error-connection-forced (amqp-connection-error)
  ((reply-code :initform 320)))

(define-condition amqp-error-invalid-path (amqp-connection-error)
  ((reply-code :initform 402)))

(define-condition amqp-error-frame-error (amqp-connection-error)
  ((reply-code :initform 501)))

(define-condition amqp-error-syntax-error (amqp-connection-error)
  ((reply-code :initform 502)))

(define-condition amqp-error-command-invalid (amqp-connection-error)
  ((reply-code :initform 503)))

(define-condition amqp-error-channel-error (amqp-connection-error)
  ((reply-code :initform 504)))

(define-condition amqp-error-unexpected-frame (amqp-connection-error)
  ((reply-code :initform 505)))

(define-condition amqp-error-resource-error (amqp-connection-error)
  ((reply-code :initform 506)))

(define-condition amqp-error-not-allowed (amqp-connection-error)
  ((reply-code :initform 530)))

(define-condition amqp-error-not-implemented (amqp-connection-error)
  ((reply-code :initform 540)))

(define-condition amqp-error-internal-error (amqp-connection-error)
  ((reply-code :initform 541)))

(define-condition amqp-unknown-reply-code-error (amqp-base-error)
  ((reply-code :initarg :reply-code
               :reader amqp-error-reply-code)))

(defun error-type-from-reply-code (reply-code)
  (case reply-code
    (311 'amqp-error-content-too-large)
    (312 'amqp-error-no-route)
    (313 'amqp-error-no-consumers)
    (403 'amqp-error-access-refused)
    (404 'amqp-error-not-found)
    (405 'amqp-error-resource-locked)
    (406 'amqp-error-precondition-failed)
    (320 'amqp-error-connection-forced)
    (402 'amqp-error-invalid-path)
    (501 'amqp-error-frame-error)
    (502 'amqp-error-syntax-error)
    (503 'amqp-error-command-invalid)
    (504 'amqp-error-channel-error)
    (505 'amqp-error-unexpected-frame)
    (506 'amqp-error-resource-error)
    (530 'amqp-error-not-allowed)
    (540 'amqp-error-not-implemented)
    (541 'amqp-error-internal-error)
    (t (error 'amqp-unknown-reply-code-error :reply-code reply-code))))
