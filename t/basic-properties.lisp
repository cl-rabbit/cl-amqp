(in-package :cl-amqp.test)

(enable-binary-string-syntax)
(local-time:enable-read-macros)
(wu-decimal:enable-reader-macro)

(defmethod mw-equiv:object-constituents ((type (eql 'local-time:timestamp)))
  (list (lambda (timestamp)
          (with-output-to-string (stream)
            (local-time:format-rfc1123-timestring stream timestamp)))))

(plan 1)

(subtest "Basic class Properties encoding / decoding"
  (let* ((bytes #b"\xff\xfc\x0atext/plain\x05utf-8\x00\x00\x00\xac\x0bcoordinatesF\x00\x00\x00\x16\x03latfBmff\x03lngd@2\x11\x11\x16\xa8\xb8\xf1\x04timeT\x00\x00\x00\x00V\xb3_\x87\x0cparticipantsb\x0b\x09i64_fieldl\x00\x00\x00\x17Hv\xe7\xff\x0atrue_fieldt\x01\x0bfalse_fieldF\x00\x00\x00\x00\x0avoid_fieldV\x0barray_fieldA\x00\x00\x00\x06b\x01b\x02b\x03\x0ddecimal_fieldD\x01\x00\x00\x00\x0c\x02\x08\x03r-1\x08a.sender\x042000\x03m-1\x00\x00\x00\x00V\xb3_\x87\x0bdog-or-cat?\x05guest\x0ecl-bunny.tests\x03qwe")        
         (now @2016-02-04T17:26:15.339563+03:00)
         (properties (make-instance 'amqp::amqp-basic-class-properties :content-type "text/plain"
                                                                       :content-encoding "utf-8"
                                                                       :headers `(("coordinates" . (("lat" . 59.35)
                                                                                                   ("lng" . 18.066667d0)))
                                                                                  ("time" . ,now)
                                                                                  ("participants" . 11)
                                                                                  ("i64_field" . 99999999999)
                                                                                  ("true_field" . t)
                                                                                  ("false_field" . nil)
                                                                                  ("void_field" . :void)
                                                                                  ("array_field" . #(1 2 3))
                                                                                  ("decimal_field" . #$1.2))
                                                                       :delivery-mode 2
                                                                       :priority 8
                                                                       :correlation-id "r-1"
                                                                       :reply-to "a.sender"
                                                                       :expiration "2000"
                                                                       :message-id "m-1"
                                                                       :timestamp now
                                                                       :type "dog-or-cat?"
                                                                       :user-id "guest"
                                                                       :app-id "cl-bunny.tests"
                                                                       :cluster-id "qwe"))
         (obuffer (amqp:new-obuffer))
         (ibuffer (amqp::new-ibuffer bytes)))
    
    (amqp::amqp-class-properties-encoder properties obuffer)
    (is (amqp:obuffer-get-bytes obuffer) bytes "Successfully encoded" :test #'equalp)
    (let ((decoded-properties (amqp::amqp-class-properties-decoder 'amqp::amqp-basic-class-properties ibuffer))
          (slots (closer-mop:class-slots (find-class 'amqp::amqp-basic-class-properties)))
          (slots-matched t))
      (dolist (slot slots)
        (let ((slot-name (closer-mop:slot-definition-name slot)))
          (setf slots-matched (and slots-matched
                                   (mw-equiv:object=
                                    (slot-value decoded-properties slot-name)
                                    (slot-value properties slot-name) t)))))
      (is slots-matched t "Successfully decoded"))))


(finalize)
