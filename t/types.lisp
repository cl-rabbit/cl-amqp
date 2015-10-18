(in-package :cl-amqp.test)

(enable-binary-string-syntax)
(wu-decimal:enable-reader-macro)
(local-time:enable-read-macros)

(defmethod mw-equiv:object-constituents ((type (eql 'local-time:timestamp)))
  (list #'local-time:to-rfc1123-timestring))

(plan 1)

(subtest "AMQP Table encode/decode test"
  (let ((amqp-table-bytes (concatenate '(simple-array  (unsigned-byte 8) 1)
                                       #b"\x00\x00\x00\xcb"
                                       #b"\x05arrayA\x00\x00\x00\x0fI\x00\x00\x00\x01I\x00\x00\x00\x02I\x00\x00\x00\x03"
                                       #b"\x07boolvalt\x01"
                                       #b"\x0dboolval_falset\x00"
                                       #b"\x07decimalD\x02\x00\x00\x01:"
                                       #b"\x0bdecimal_tooD\x00\x00\x00\x00d"
                                       #b"\x07dictvalF\x00\x00\x00\x0c\x03fooS\x00\x00\x00\x03bar"
                                       #b"\x06intvalI\x00\x00\x00\x01"
                                       #b"\x07longvall\x00\x00\x00\x006e&U"
                                       #b"\x04nullV"
                                       #b"\x06strvalS\x00\x00\x00\x04Test"
                                       #b"\x0ctimestampvalT\x00\x00\x00\x00Ec)\x92"
                                       #b"\x07unicodeS\x00\x00\x00\x08utf8=\xe2\x9c\x93"))
        (table '(("array" . #(1 2 3))
                 ("boolval" . t)
                 ("boolval_false". :false)
                 ("decimal" . #$3.14)
                 ("decimal_too" . #$100)
                 ("dictval" . (("foo" . "bar")))
                 ("intval" . 1)
                 ("longval" . 912598613)
                 ("null" . :void)
                 ("strval" . "Test")
                 ("timestampval" . @2006-11-21T16:30:10)
                 ("unicode" . "utf8=✓"))))

    ;; (is amqp-table-bytes (with-output-to-buffer (buffer)
    ;;                        (amqp-encode-table table buffer)))
    
    (let ((amqp::*amqp-boolean-false* :false)
          (amqp::*amqp-void* :void))
      (is table (amqp::amqp-table-decoder (amqp::new-ibuffer amqp-table-bytes)) :test (lambda (x y)
                                                                                        (mw-equiv:object= x y t))))))

(finalize)
