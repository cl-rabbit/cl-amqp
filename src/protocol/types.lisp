(in-package :cl-amqp)

;; cool story -> https://www.rabbitmq.com/amqp-0-9-1-errata.html#section_3
#|
  0-9   0-9-1   Qpid/Rabbit  Type               Remarks
---------------------------------------------------------------------------
        t       t            Boolean
        b       b            Signed 8-bit
        B                    Unsigned 8-bit
        U       s            Signed 16-bit      (A1)
        u                    Unsigned 16-bit
  I     I       I            Signed 32-bit
        i                    Unsigned 32-bit
        L       l            Signed 64-bit      (B)
        l                    Unsigned 64-bit
        f       f            32-bit float
        d       d            64-bit float
  D     D       D            Decimal            [this one is signed too]
        s                    Short string       (A2)
  S     S       S            Long string
        A       A            Array              (C)
  T     T       T            Timestamp (u64)
  F     F       F            Nested Table
  V     V       V            Void
                x            Byte array         (D)
|#


;;; table fields

(defmacro define-amqp-types (&rest types-and-decoders)
  (with-gensyms (type)
    (labels ((amqp-type-constant-name (type-name)
               (intern (string-upcase ;; TODO: really? what about read-table case?
                        (concatenate 'string "+amqp-type-"
                                     type-name
                                     "+"))
                       (find-package :cl-amqp)))
             
             (amqp-type-decoder-name (type-name)
               (intern (string-upcase ;; TODO: really? what about read-table case?
                        (concatenate 'string "amqp-"
                                     type-name
                                     "-decoder"))
                       (find-package :cl-amqp))))
      `(progn
         ,@(loop for (value name) in types-and-decoders
                 collect `(defconstant ,(amqp-type-constant-name name) ,(char-code value)))
         (defun amqp-decode-field-value (buffer)
           (let ((,type (amqp-decode-field-value-type buffer)))
             (case ,type
               ,@(loop for (value name) in types-and-decoders
                       collect `(,(char-code value) (,(amqp-type-decoder-name name) buffer)))
               (t (error "Unknown field type ~a" ,type))))))))) ;;TODO: specialize error

(defvar *amqp-boolean-false* nil)
(defvar *amqp-void* nil)

(defun amqp-decode-field-value-type (buffer)
  (ibuffer-decode-ub8 buffer))

(defun amqp-boolean-decoder (buffer)
  (let ((value (ibuffer-decode-ub8 buffer)))
    (case value
      (1 t)
      (0 *amqp-boolean-false*)
      (t (error "Invalid amqp boolean value ~a" value))))) ;;TODO: specialize error

(defun amqp-sb8-decoder (buffer)
  (ibuffer-decode-sb8 buffer))

(defun amqp-sb16-decoder (buffer)
  (ibuffer-decode-sb16 buffer))

(defun amqp-sb32-decoder (buffer)
  (ibuffer-decode-sb32 buffer))

(defun amqp-sb64-decoder (buffer)
  (ibuffer-decode-sb64 buffer))

(defun amqp-float-decoder (buffer)
  (ibuffer-decode-float buffer))

(defun amqp-double-decoder (buffer)
  (ibuffer-decode-double buffer))

(defun amqp-decimal-decoder (buffer) ;; we decode decimal as ratio see more here: https://wukix.com/lisp-decimals
  (let ((scale (ibuffer-decode-ub8 buffer))
        (value (ibuffer-decode-sb32 buffer)))
    (/ value (expt 10 scale))))

(defun amqp-lstring-decoder (buffer)
  ;; long strings are just (simple-array (unsinged-byte 8) 1)
  ;; but rabbitmq also has 'x' - pure byte array fields.
  ;; and pika fpr example converts lstring to utf8 string
  ;; I'm lost here
  ;; (octets-to-string #b"he\x1llo") -> "hello"
  (let* ((string-length (ibuffer-decode-ub32 buffer))
         (string-buffer (new-ibuffer buffer string-length)))
    (babel:octets-to-string (ibuffer-get-bytes string-buffer) :encoding :utf-8)))

(defun amqp-array-decoder (buffer)
  (let* ((array-body-length (ibuffer-decode-ub32 buffer))
         (array-body-buffer (new-ibuffer buffer array-body-length)))
    (apply #'vector
           (loop
             until (ibuffer-consumed-p array-body-buffer)
             collect (amqp-decode-field-value array-body-buffer)))))

(defun amqp-timestamp-decoder (buffer)
  (let ((time_t (ibuffer-decode-sb64 buffer))) ;; or ub64??
    (local-time:unix-to-timestamp time_t)))

(defun amqp-decode-short-string (buffer)
  (let* ((string-length (ibuffer-decode-ub8 buffer))
         (string-buffer (new-ibuffer buffer string-length)))
    (babel:octets-to-string (ibuffer-get-bytes string-buffer) :encoding :utf-8)))

(defun amqp-decode-field-name (buffer)
  (amqp-decode-short-string buffer))

(defun amqp-table-decoder (buffer)
  (let* ((table-body-length (ibuffer-decode-ub32 buffer))
         (table-body-buffer (new-ibuffer buffer table-body-length)))
    (with-alist-output (add-field)
      (loop
        until (ibuffer-consumed-p table-body-buffer)
        do
           (add-field (amqp-decode-field-name table-body-buffer)
                      (amqp-decode-field-value table-body-buffer))))))

(defun amqp-void-decoder (buffer)
  (declare (ignore buffer))
  *amqp-void*)

(defun amqp-barray-decoder (buffer)  
  (let* ((string-length (ibuffer-decode-ub32 buffer))
         (string-buffer (new-ibuffer buffer string-length)))
    (ibuffer-get-bytes string-buffer)))

(define-amqp-types
  (#\t "boolean")
  (#\b "sb8")
  (#\s "sb16")
  (#\I "sb32")
  (#\l "sb64")
  (#\f "float")
  (#\d "double")
  (#\D "decimal")
  (#\S "lstring")
  (#\A "array")
  (#\T "timestamp")
  (#\F "table")
  (#\V "void")
  (#\x "barray"))

