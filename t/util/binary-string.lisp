(in-package :cl-amqp.test)


(plan 1)

(amqp:enable-binary-string-syntax)
(subtest "Testing binary string reader"
  (is #b"\x3\x0\x3\x0\x0\x0\001a\xce" #(3 0 3 0 0 0 1 97 206)
      "#b\"\\x3\\x0\\x3\\x0\\x0\\x0\\001a\\xce\" expected to produce #(3 0 3 0 0 0 1 97 206)"
      :test #'equalp)
  (is-type #b"\x3\x0\x3\x0\x0\x0\001a\xce" '(simple-array (unsigned-byte 8))
           "#b\"\\x3\\x0\\x3\\x0\\x0\\x0\\001a\\xce\" expected to produce (simple-array (unsigned-byte 8)")

  (is (princ-to-string #b"\x06barrayx\x00\x00\x00\x08utf8=\xe2\x9c\x93")
      "\\x06barrayx\\x00\\x00\\x00\\x08utf8=\\xe2\\x9c\\x93")
  (is (prin1-to-string #b"\x06barrayx\x00\x00\x00\x08utf8=\xe2\x9c\x93")
      "#b\"\\x06barrayx\\x00\\x00\\x00\\x08utf8=\\xe2\\x9c\\x93\""))

(finalize)
