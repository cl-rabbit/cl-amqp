(in-package :cl-amqp)

;; cool story -> https://www.rabbitmq.com/amqp-0-9-1-errata.html#section_3

;;   0-9   0-9-1   Qpid/Rabbit  Type               Remarks
;; ---------------------------------------------------------------------------
;;         t       t            Boolean
;;         b       b            Signed 8-bit
;;         B                    Unsigned 8-bit
;;         U       s            Signed 16-bit      (A1)
;;         u                    Unsigned 16-bit
;;   I     I       I            Signed 32-bit
;;         i                    Unsigned 32-bit
;;         L       l            Signed 64-bit      (B)
;;         l                    Unsigned 64-bit
;;         f       f            32-bit float
;;         d       d            64-bit float
;;   D     D       D            Decimal            [this one is signed too]
;;         s                    Short string       (A2)
;;   S     S       S            Long string
;;         A       A            Array              (C)
;;   T     T       T            Timestamp (u64)
;;   F     F       F            Nested Table
;;   V     V       V            Void
;;                 x            Byte array         (D)

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
         (defun amqp-decode-table-field-value (buffer)
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

(defun amqp-octet-decoder (buffer)
  (ibuffer-decode-sb8 buffer))

(defun amqp-short-decoder (buffer)
  (ibuffer-decode-sb16 buffer))

(defun amqp-long-decoder (buffer)
  (ibuffer-decode-sb32 buffer))

(defun amqp-longlong-decoder (buffer)
  (ibuffer-decode-sb64 buffer))

(defun amqp-single-decoder (buffer)
  (ibuffer-decode-float buffer))

(defun amqp-double-decoder (buffer)
  (ibuffer-decode-double buffer))

(defun amqp-decimal-decoder (buffer) ;; we decode decimal as ratio see more here: https://wukix.com/lisp-decimals
  (let ((scale (ibuffer-decode-ub8 buffer))
        (value (ibuffer-decode-sb32 buffer)))
    (/ value (expt 10 scale))))

(defun amqp-longstr-decoder (buffer)
  ;; long strings are just (simple-array (unsinged-byte 8) 1)
  ;; but rabbitmq also has 'x' - pure byte array fields.
  ;; and pika fpr example converts lstring to utf8 string
  ;; I'm lost here
  ;; (octets-to-string #b"he\x1llo") -> "hello"
  (let* ((string-length (ibuffer-decode-ub32 buffer)))
    (ibuffer-decode-utf8 buffer string-length)))

(defun amqp-array-decoder (buffer)
  (let* ((array-body-length (ibuffer-decode-ub32 buffer))
         (array-body-buffer (new-ibuffer buffer array-body-length)))
    (apply #'vector
           (loop
             until (ibuffer-consumed-p array-body-buffer)
             collect (amqp-decode-table-field-value array-body-buffer)))))

(defun amqp-timestamp-decoder (buffer)

  (let ((time_t (ibuffer-decode-sb64 buffer))) ;; or ub64??
    (local-time:unix-to-timestamp time_t)))

(defun amqp-shortstr-decoder (buffer)
  (let* ((string-length (ibuffer-decode-ub8 buffer)))
    ;; TODO: check string-length actually fits ub8
    (ibuffer-decode-utf8 buffer string-length)))

(defun amqp-field-name-decoder (buffer)
  (amqp-shortstr-decoder buffer))

(defun amqp-table-decoder (buffer)
  (let* ((table-body-length (ibuffer-decode-ub32 buffer))
         (table-body-buffer (new-ibuffer buffer table-body-length)))
    (with-alist-output (add-field)
      (loop
        until (ibuffer-consumed-p table-body-buffer)
        do
           (add-field (amqp-field-name-decoder table-body-buffer)
                      (amqp-decode-table-field-value table-body-buffer))))))

(defun amqp-void-decoder (buffer)
  (declare (ignore buffer))
  *amqp-void*)

(defun amqp-barray-decoder (buffer)
  (let* ((string-length (ibuffer-decode-ub32 buffer)))
    (ibuffer-get-bytes buffer string-length)))

(define-amqp-types
    (#\t "boolean")
    (#\b "octet")
  (#\s "short")
  (#\I "long")
  (#\l "longlong")
  (#\f "single")
  (#\d "double")
  (#\D "decimal")
  (#\S "longstr")
  (#\A "array")
  (#\T "timestamp")
  (#\F "table")
  (#\V "void")
  (#\x "barray"))

(defun amqp-encode-field-value-type (buffer type)
  (obuffer-encode-ub8 buffer type))

(defun amqp-boolean-encoder (buffer value)
  (obuffer-encode-ub8 buffer (if value 1 0)))

(defun amqp-boolean-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-boolean+)
  (amqp-boolean-encoder buffer value))

(defun amqp-octet-encoder (buffer value)
  (obuffer-encode-sb8 buffer value))

(defun amqp-octet-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-octet+)
  (amqp-octet-encoder buffer value))

(defun amqp-short-encoder (buffer value)
  (obuffer-encode-sb16 buffer value))

(defun amqp-short-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-short+)
  (amqp-short-encoder buffer value))

(defun amqp-long-encoder (buffer value)
  (obuffer-encode-sb32 buffer value))

(defun amqp-long-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-long+)
  (amqp-long-encoder buffer value))

(defun amqp-longlong-encoder (buffer value)
  (obuffer-encode-sb64 buffer value))

(defun amqp-longlong-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-longlong+)
  (amqp-longlong-encoder buffer value))

(defun amqp-single-encoder (buffer value)
  (obuffer-encode-single buffer value))

(defun amqp-single-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-single+)
  (amqp-single-encoder buffer value))

(defun amqp-double-encoder (buffer value)
  (obuffer-encode-double buffer value))

(defun amqp-double-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-double+)
  (amqp-double-encoder buffer value))

(defun amqp-decimal-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-decimal+)
  (multiple-value-bind (c pow)
      (wu-decimal::find-multiplier (denominator value))
    (obuffer-encode-ub8 buffer pow)
    (obuffer-encode-sb32 buffer (* (numerator value) c))))

(defun amqp-longstr-encoder (buffer value)
  (let ((utf-8-bytes (trivial-utf-8:string-to-utf-8-bytes value)))
    (obuffer-encode-ub32 buffer (length utf-8-bytes))
    (obuffer-add-bytes buffer utf-8-bytes)))

(defun amqp-longstr-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-lstring+)
  (amqp-longstr-encoder buffer value))

(defun amqp-array-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-array+)
  (let* ((array-buffer (new-obuffer))
         (array-bytes (loop for item across value
                            do
                               (amqp-encode-field-value array-buffer item)
                            finally
                               (return (obuffer-get-bytes array-buffer)))))
    ;; TODO: check (length array-bytes) actually fits ub32
    (obuffer-encode-ub32 buffer (length array-bytes))
    (obuffer-add-bytes buffer array-bytes)))

(defun amqp-timestamp-encoder (buffer value)
  (obuffer-encode-sb64 buffer value))

(defun amqp-timestamp-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-timestamp+)
  (amqp-timestamp-encoder buffer value))

(defun amqp-field-name-encoder (buffer value)
  (amqp-shortstr-encoder buffer value))

(defun amqp-table-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-table+)
  (amqp-table-encoder buffer value))

(defun amqp-void-table-field-encoder (buffer value)
  (declare (ignore value))
  (amqp-encode-field-value-type buffer +amqp-type-void+))

(defun amqp-barray-table-field-encoder (buffer value)
  (amqp-encode-field-value-type buffer +amqp-type-barray+)
  ;; TODO: check (length bytes) actually fits ub32
  (obuffer-encode-ub32 buffer (length value))
  (obuffer-add-bytes buffer value))

(defun amqp-shortstr-encoder (buffer value)
  (let ((utf-8-bytes (trivial-utf-8:string-to-utf-8-bytes value)))
    ;; TODO: check (length utf-8-byte) actually fits ub8
    (obuffer-encode-ub8 buffer (length utf-8-bytes))
    (obuffer-add-bytes buffer utf-8-bytes)))

(defun amqp-table-encoder (buffer value)
  (let* ((table-buffer (new-obuffer))
         (table-bytes (loop for (field-name . field-value) in value
                            do
                               (amqp-field-name-encoder table-buffer field-name)
                               (amqp-encode-field-value table-buffer field-value)
                            finally
                               (return (obuffer-get-bytes table-buffer)))))
    ;; TODO: check (length table-bytes) actually fits ub32
    (obuffer-encode-ub32 buffer (length table-bytes))
    (obuffer-add-bytes buffer table-bytes)))

(deftype alist ()
  `(and list (satisfies list-is-alist)))

(defun list-is-alist (list)
  (when (typep list 'list)
    (every #'consp list)))

(deftype void ()
  `(and symbol (satisfies symbol-is-void)))

(defun symbol-is-void (symbol)
  (eq :void symbol))

(deftype amqp-boolean ()
  `(and symbol (satisfies symbol-is-amqp-boolean)))

(defun symbol-is-amqp-boolean (symbol)
  (or (eq t symbol)
      (eq :false symbol)))

(defun amqp-encode-field-value (buffer value)
  (typecase value
    ((signed-byte 8) (amqp-octet-table-field-encoder buffer value))
    ((signed-byte 16) (amqp-short-table-field-encoder buffer value))
    ((signed-byte 32) (amqp-long-table-field-encoder buffer value))
    ((signed-byte 64) (amqp-longlong-table-field-encoder buffer value))
    (double-float (amqp-double-table-field-encoder buffer value))
    (float (amqp-single-table-field-encoder buffer value))
    (wu-decimal:decimal (amqp-decimal-table-field-encoder buffer value))
    (string (amqp-longstr-table-field-encoder buffer value))
    (nibbles:simple-octet-vector (amqp-barray-table-field-encoder buffer value))
    (vector (amqp-array-table-field-encoder buffer value))
    (local-time:timestamp (amqp-timestamp-table-field-encoder buffer (local-time:timestamp-to-unix value)))
    (alist (amqp-table-table-field-encoder buffer value))
    (hash-table (amqp-table-table-field-encoder buffer (hash-table-alist value)))
    (void (amqp-void-table-field-encoder buffer value))
    (amqp-boolean (amqp-boolean-table-field-encoder buffer (eq t value)))
    (t (error "Don't know how to encode ~a" value)))) ;; TODO: specialize error
