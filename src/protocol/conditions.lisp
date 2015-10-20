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
  ((reply-code :initform +amqp-content-too-large+)))

(define-condition amqp-error-no-route (amqp-channel-error)
  ((reply-code :initform +amqp-no-route+)))

(define-condition amqp-error-no-consumers (amqp-channel-error)
  ((reply-code :initform +amqp-no-consumers+)))

(define-condition amqp-error-access-refused (amqp-channel-error)
  ((reply-code :initform +amqp-access-refused+)))

(define-condition amqp-error-not-found (amqp-channel-error)
  ((reply-code :initform +amqp-not-found+)))

(define-condition amqp-error-resource-locked (amqp-channel-error)
  ((reply-code :initform +amqp-resource-locked+)))

(define-condition amqp-error-precondition-failed (amqp-channel-error)
  ((reply-code :initform +amqp-precondition-failed+)))

(define-condition amqp-error-connection-forced (amqp-connection-error)
  ((reply-code :initform +amqp-connection-forced+)))

(define-condition amqp-error-invalid-path (amqp-connection-error)
  ((reply-code :initform +amqp-invalid-path+)))

(define-condition amqp-error-frame-error (amqp-connection-error)
  ((reply-code :initform +amqp-frame-error+)))

(define-condition amqp-error-syntax-error (amqp-connection-error)
  ((reply-code :initform +amqp-syntax-error+)))

(define-condition amqp-error-command-invalid (amqp-connection-error)
  ((reply-code :initform +amqp-command-invalid+)))

(define-condition amqp-error-channel-error (amqp-connection-error)
  ((reply-code :initform +amqp-channel-error+)))

(define-condition amqp-error-unexpected-frame (amqp-connection-error)
  ((reply-code :initform +amqp-unexpected-frame+)))

(define-condition amqp-error-resource-error (amqp-connection-error)
  ((reply-code :initform +amqp-resource-error+)))

(define-condition amqp-error-not-allowed (amqp-connection-error)
  ((reply-code :initform +amqp-not-allowed+)))

(define-condition amqp-error-not-implemented (amqp-connection-error)
  ((reply-code :initform +amqp-not-implemented+)))

(define-condition amqp-error-internal-error (amqp-connection-error)
  ((reply-code :initform +amqp-internal-error+)))

(define-condition amqp-unknown-reply-code-error (amqp-base-error)  ;; TODO: can it be connection or channel error?
  ((reply-code :initarg :reply-code
               :reader amqp-error-reply-code)))

(defun error-type-from-reply-code (reply-code)
  (case reply-code
    (311 #|+amqp-content-too-large+|# 'amqp-error-content-too-large)
    (312 #|+amqp-no-route+|# 'amqp-error-no-route)
    (313 #|+amqp-no-consumers+|# 'amqp-error-no-consumers)
    (403 #|+amqp-access-refused+|# 'amqp-error-access-refused)
    (404 #|+amqp-not-found+|# 'amqp-error-not-found)
    (405 #|+amqp-resource-locked+|# 'amqp-error-resource-locked)
    (406 #|+amqp-precondition-failed+|# 'amqp-error-precondition-failed)
    (320 #|+amqp-connection-forced+|# 'amqp-error-connection-forced)
    (402 #|+amqp-invalid-path+|# 'amqp-error-invalid-path)
    (501 #|+amqp-frame-error+|# 'amqp-error-frame-error)
    (502 #|+amqp-syntax-error+|# 'amqp-error-syntax-error)
    (503 #|+amqp-command-invalid+|# 'amqp-error-command-invalid)
    (504 #|+amqp-channel-error+|# 'amqp-error-channel-error)
    (505 #|+amqp-unexpected-frame+|# 'amqp-error-unexpected-frame)
    (506 #|+amqp-resource-error+|# 'amqp-error-resource-error)
    (530 #|+amqp-not-allowed+|# 'amqp-error-not-allowed)
    (540 #|+amqp-not-implemented+|# 'amqp-error-not-implemented)
    (541 #|+amqp-internal-error+|# 'amqp-error-internal-error)
    (t (error 'amqp-unknown-reply-code-error :reply-code reply-code))))
