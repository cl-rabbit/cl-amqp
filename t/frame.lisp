(in-package :cl-amqp.test)

(enable-binary-string-syntax)
(plan 3)

(subtest "Frames Parsing"

  (subtest "Single-byte payload"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-start)
           (payload-end)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-start start
                                              payload-end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x3\x0\x3\x0\x0\x0\x01a\xCE")
      (is frame-type 3 "FRAME-TYPE should be 3")
      (is channel-number 3 "CHANNEL-NUMBER should be 3")
      (is payload-size 1 "PAYLOAD-SIZE should be 1")
      (is payload-start 7 "PAYLOAD always starts at 7")
      (is payload-end 8 "PAYLOAD ends at 8")
      (is frame-ended t "FRAME ended with 0xCE")))

  (subtest "No payload"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-start)
           (payload-end)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-start start
                                              payload-end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x3\x0\x3\x0\x0\x0\x0\xCE")
      (is frame-type 3 "FRAME-TYPE should be 3")
      (is channel-number 3 "CHANNEL-NUMBER should be 3")
      (is payload-size 0 "PAYLOAD-SIZE should be 0")
      (is payload-start nil "PAYLOAD-START should be NIL")
      (is payload-end nil "PAYLOAD-END should be NIL")
      (is frame-ended t "FRAME ended with 0xCE")))

  (subtest "Single-buffer read"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-start)
           (payload-end)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-start start
                                              payload-end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x16\x0\x3\x0\x0\x0\xcHello World!\xce")
      (is frame-type 22 "FRAME-TYPE should be 22")
      (is channel-number 3 "CHANNEL-NUMBER should be 3")
      (is payload-size 12 "PAYLOAD-SIZE should be 12")
      (is payload-start 7 "PAYLOAD always starts at 7")
      (is payload-end 19 "PAYLOAD ends at 19")
      (is frame-ended t "FRAME ended with 0xCE")))

  (subtest "Incomplete input"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-start)
           (payload-end)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-start start
                                              payload-end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (multiple-value-bind (index parsed)
          (amqp:frame-parser-consume parser #b"\x01\x00\x01\x00\x00\x00M\x00<\x00<amq.ctag-emiEYEYmJ4I)")
        (is parsed nil "Frame not fully parsed")
        (is index 33 "Data ended at index 33")
        (is frame-type 1 "FRAME-TYPE should be 1")
        (is channel-number 1 "CHANNEL-NUMBER should be 1")
        (is payload-size 77 "PAYLOAD-SIZE should be 77")
        (is payload-start 7 "PAYLOAD always starts at 7")
        (is payload-end 33 "PAYLOAD ends at 33")
        (is frame-ended nil "FRAME not ended"))))

  (subtest "Shifted Single-buffer read"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-start)
           (payload-end)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-start start
                                              payload-end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x0\x0\x0\x16\x0\x3\x0\x0\x0\xcHello World!\xce\x0\x0\x0" :start 3 :end 23)
      (is frame-type 22 "FRAME-TYPE should be 22")
      (is channel-number 3 "CHANNEL-NUMBER should be 3")
      (is payload-size 12 "PAYLOAD-SIZE should be 12")
      (is payload-start 10 "PAYLOAD always starts at 10")
      (is payload-end 22 "PAYLOAD ends at 22")
      (is frame-ended t "FRAME ended with 0xCE")))

  (subtest "Splitted-buffer read"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-bounds)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-bounds (append payload-bounds (list (cons start end)))))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x16\x0\x3\x0\x0\x0\xcHell")
      (amqp:frame-parser-consume parser #b"o World!\xce")
      (is frame-type 22 "FRAME-TYPE should be 22")
      (is channel-number 3 "CHANNEL-NUMBER should be 3")
      (is payload-size 12 "PAYLOAD-SIZE should be 12")
      (is payload-bounds '((7 . 11) (0 . 8)) "Frame parsed from two reads with payload bounds ((7 . 11) (0 . 8))")
      (is frame-ended t "FRAME ended with 0xCE")))

  (subtest "Shifted Splitted-buffer read"
    (let* ((frame-type)
           (channel-number)
           (payload-size)
           (payload-bounds)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type%)
                                     (declare (ignore parser))
                                     (setf frame-type frame-type%))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-number frame-channel))
                    :on-frame-payload-size (lambda (parser frame-payload-size%)
                                             (declare (ignore parser))
                                             (setf payload-size frame-payload-size%))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-bounds (append payload-bounds (list (cons start end)))))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x0\x0\x0\x16\x0\x3\x0\x0\x0\xcHell\x0\x0\x0\x0" :start 3 :end 14)
      (amqp:frame-parser-consume parser #b"\x0\x0o World!\xce\x0" :start 2 :end 11)
      (is frame-type 22 "FRAME-TYPE should be 22")
      (is channel-number 3 "CHANNEL-NUMBER should be 3")
      (is payload-size 12 "PAYLOAD-SIZE should be 12")
      (is payload-bounds '((10 . 14) (2 . 10)) "Frame parsed from two reads with payload bounds ((10 . 14) (2 . 10))")
      (is frame-ended t "FRAME ended with 0xCE")))

  (subtest "Frames Sequence"
    (let* ((frames-count 0)
           (frame-types)
           (channel-numbers)
           (payload-sizes)
           (payload-bounds)
           (frame-ended)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (setf frame-types (append frame-types (list frame-type))))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf channel-numbers (append channel-numbers (list frame-channel))))
                    :on-frame-payload-size (lambda (parser frame-payload-size)
                                             (declare (ignore parser))
                                             (setf payload-sizes (append payload-sizes (list frame-payload-size))))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (setf payload-bounds (append payload-bounds (list (cons start end)))))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (incf frames-count)
                                    (setf frame-ended t)))))
      (amqp:frame-parser-consume parser #b"\x0\x0\x0\x16\x0\x3\x0\x0\x0\xcHell\x0\x0\x0\x0" :start 3 :end 14)
      (amqp:frame-parser-consume parser #b"o World!\xCE\x3\x0\x2\x0\x0\x0\x0" :start 0 :end 14)
      (amqp:frame-parser-consume parser #b"o World!\xCE\x3\x0\x2\x0\x0\x0\x0" :start 9 :end 14)
      (amqp:frame-parser-consume parser #b"\x0\x01a\xCE\x0\x0\x0" :start 0 :end 4)
      (is frames-count 2 "FRAME-COUNT should be 2")
      (is frame-types '(22 3) "FRAME-TYPES should be 22 and 3")
      (is channel-numbers '(3 2) "CHANNEL-NUMBERS should be 3 and 2")
      (is payload-sizes '(12 1) "PAYLOAD-SIZES should be 12 and 1")
      (is payload-bounds '((10 . 14) (0 . 8) (2 . 3)) "Frames parsed from 3 reads with payload bounds ((10 . 14) (0 . 8) (2 . 3))")
      t))

  (subtest "No 0xCE at the end"
    (let ((parser (amqp:make-frame-parser)))
      (is-error (amqp:frame-parser-consume parser #b"\x3\x0\x3\x0\x0\x0\x01a\x12\x1")
                'amqp:malformed-frame-error
                "PARSER should throw MALFORMED-FRAME-ERROR if frame end is not 0xCE")))

  (subtest "Invalid parser state"
    (let ((parser (amqp:make-frame-parser)))
      (is-error (progn
                  (amqp:frame-parser-consume parser #b"\x3\x0\x3\x0\x0")
                  (setf (slot-value parser 'amqp::state) -1)
                  (amqp:frame-parser-consume parser #b"\x0\x01a\xCE"))
                'amqp:invalid-frame-parser-state-error
                "PARSER should throw INALID-FRAME-PARSER-STATE-ERROR if frame parser state is invalid/unknown"))))

(subtest "Frame types"
  (subtest "Frame class from frame type" ;; TODO: sometime later this will be redundant
    (is 'amqp::method-frame (amqp:frame-class-from-frame-type amqp:+amqp-frame-method+) "Method Frame type: Method")
    (is 'amqp::header-frame (amqp:frame-class-from-frame-type amqp:+amqp-frame-header+) "Header Frame type: Content Header")
    (is 'amqp::body-frame (amqp:frame-class-from-frame-type amqp:+amqp-frame-body+) "Body Frame type: Body")
    (is 'amqp::heartbeat-frame (amqp:frame-class-from-frame-type amqp:+amqp-frame-heartbeat+) "Heartbeat Frame type: Heartbeat")
    (is-error (amqp:frame-class-from-frame-type 11) 'amqp:amqp-unknown-frame-type-error
              "Frame type 11 generates amqp-unknown-frame-type-error")))

(subtest "Frame encoding/decoding"

  (subtest "Method frame encoding/decoding"
    (let* ((frame-bytes (concatenate '(simple-array  (unsigned-byte 8) 1)
                                     #b"\x01\x00\x01\x00\x00\x00\r\x00<\x00P\x00\x00\x00\x00\x00\x00"
                                     #b"\x00d\x00\xce"))
           (method (make-instance 'amqp:amqp-method-basic-ack :delivery-tag 100))
           (frame (make-instance 'amqp:method-frame :channel 1 :payload method))
           (payload-parser)
           (dframe)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (is frame-type amqp:+amqp-frame-method+ "Frame type is expected to be Method Frame")
                                     (setf dframe (make-instance (amqp:frame-class-from-frame-type frame-type))))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf (amqp:frame-channel dframe) frame-channel))
                    :on-frame-payload-size (lambda (parser payload-size)
                                             (declare (ignore parser))
                                             ;; validate frame size
                                             (setf (amqp:frame-payload-size dframe) payload-size)
                                             (setf payload-parser
                                                   (amqp:make-frame-payload-parser dframe
                                                                                   :on-method-signature (lambda (signature)
                                                                                                          (is signature #x003c0050))
                                                                                   :on-method-arguments-buffer (lambda (buffer)
                                                                                                                 (is buffer #b"\x00<\x00P\x00\x00\x00\x00\x00\x00\x00d\x00"
                                                                                                                     :test (lambda (x y)
                                                                                                                             (mw-equiv:object= x y t)))))))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser))
                                        (amqp:frame-payload-parser-consume payload-parser data  :start start :end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (amqp:frame-payload-parser-finish payload-parser)))))


      ;; encoding test
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder frame obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            frame-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))

      ;; decoding test
      (amqp:frame-parser-consume parser frame-bytes)
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder dframe obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            frame-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))))



  (subtest "Method without arguments"
    (let* ((method (make-instance 'amqp-method-connection-close-ok))
           (frame (make-instance 'method-frame :channel 0 :payload method))
           (frame-bytes #b"\x01\x00\x00\x00\x00\x00\x04\x00\x0a\x003\xce")
           (payload-parser)
           (dframe)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (setf dframe (make-instance (amqp:frame-class-from-frame-type frame-type))))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf (amqp:frame-channel dframe) frame-channel))
                    :on-frame-payload-size (lambda (parser payload-size)
                                             (declare (ignore parser))
                                             ;; validate frame size
                                             (setf (amqp:frame-payload-size dframe) payload-size)
                                             (setf payload-parser
                                                   (amqp:make-frame-payload-parser dframe)))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser))
                                        (amqp:frame-payload-parser-consume payload-parser data  :start start :end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (amqp:frame-payload-parser-finish payload-parser)))))

      ;; encoding test
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder frame obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            frame-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))

      ;; decoding test
      (amqp:frame-parser-consume parser frame-bytes)
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder dframe obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            frame-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))))

  (subtest "Splitted-buffer method parser"
    (let* ((payload-parser)
           (dframe)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (setf dframe (make-instance (amqp:frame-class-from-frame-type frame-type))))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf (amqp:frame-channel dframe) frame-channel))
                    :on-frame-payload-size (lambda (parser payload-size)
                                             (declare (ignore parser))
                                             ;; validate frame size
                                             (setf (amqp:frame-payload-size dframe) payload-size)
                                             (setf payload-parser
                                                   (amqp:make-frame-payload-parser dframe)))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser))
                                        (amqp:frame-payload-parser-consume payload-parser data :start start :end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (amqp:frame-payload-parser-finish payload-parser)))))
      (amqp:frame-parser-consume parser #b"\x01\x00\x01\x00\x00\x00M\x00<\x00<amq.ctag-3sYl7RDWSX4hz8")
      (amqp:frame-parser-consume parser #b"qRlVR33w\x00\x00\x00\x00\x00\x00\x01\xa4\x00\x00\x1eamq.gen-QYpXeQ3bCQ73-oebNs5_Yg\xce")

      (is-type (frame-payload dframe) 'amqp-method-basic-deliver)))

  (subtest "Content header frame encoding/decoding"
    (let* ((frame-bytes (concatenate '(simple-array  (unsigned-byte 8) 1)
                                     #b"\x02\x00\x01\x00\x00\x00\x0f\x00<\x00\x00\x00"
                                     #b"\x00\x00\x00\x00\x00\x00d\x10\x00\x02\xce"))
           (basic-properties (make-instance 'amqp:amqp-basic-class-properties :delivery-mode 2))
           (frame (make-instance 'amqp:header-frame :channel 1 :body-size 100 :payload basic-properties))
           (payload-parser)
           (dframe)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (is frame-type amqp:+amqp-frame-header+ "Frame type is expected to be Header Frame")
                                     (setf dframe (make-instance (amqp:frame-class-from-frame-type frame-type))))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf (amqp:frame-channel dframe) frame-channel))
                    :on-frame-payload-size (lambda (parser payload-size)
                                             (declare (ignore parser))
                                             ;; validate frame size
                                             (setf (amqp:frame-payload-size dframe) payload-size)
                                             (setf payload-parser
                                                   (amqp:make-frame-payload-parser dframe
                                                                                   :on-class-id (lambda (class-id)
                                                                                                  (is class-id 60 "Class is Basic Class"))
                                                                                   :on-content-body-size (lambda (body-size)
                                                                                                           (is body-size 100 "Body size is 100")))))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser))
                                        (amqp:frame-payload-parser-consume payload-parser data :start start :end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (amqp:frame-payload-parser-finish payload-parser)))))


      ;; encoding test
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder frame obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            frame-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))

      ;; decoding test
      (amqp:frame-parser-consume parser frame-bytes)
      (is (slot-value (frame-payload dframe) 'amqp::delivery-mode) 2 "Delivery mode is persistent")
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder dframe obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            frame-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))))

  (subtest "Splitted Header frame test"
    (let* ((frame-bytes (list
                         #b"\x02\x00\x01\x00\x00\x00\x0e\x00<\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00"
                         #b"\x00\xce"))
           (cframe-bytes (concatenate '(simple-array  (unsigned-byte 8) 1)
                                      #b"\x02\x00\x01\x00\x00\x00\x0e\x00<\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00"
                                      #b"\x00\xce"))
           (basic-properties (make-instance 'amqp:amqp-basic-class-properties))
           (frame (make-instance 'amqp:header-frame :channel 1 :body-size 12 :payload basic-properties))
           (payload-parser)
           (dframe)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (is frame-type amqp:+amqp-frame-header+ "Frame type is expected to be Header Frame")
                                     (setf dframe (make-instance (amqp:frame-class-from-frame-type frame-type))))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (setf (amqp:frame-channel dframe) frame-channel))
                    :on-frame-payload-size (lambda (parser payload-size)
                                             (declare (ignore parser))
                                             ;; validate frame size
                                             (setf (amqp:frame-payload-size dframe) payload-size)
                                             (setf payload-parser
                                                   (amqp:make-frame-payload-parser dframe
                                                                                   :on-class-id (lambda (class-id)
                                                                                                  (is class-id 60 "Class is Basic Class"))
                                                                                   :on-content-body-size (lambda (body-size)
                                                                                                           (is body-size 12 "Body size is 100")))))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser))
                                        (amqp:frame-payload-parser-consume payload-parser data :start start :end end))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (amqp:frame-payload-parser-finish payload-parser)))))


      ;; encoding test
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder frame obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            cframe-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))

      ;; decoding test
      (amqp:frame-parser-consume parser (first frame-bytes))
      (amqp:frame-parser-consume parser (second frame-bytes))
      (let ((obuffer (amqp:new-obuffer)))
        (amqp:frame-encoder dframe obuffer)
        (is (amqp:obuffer-get-bytes obuffer)
            cframe-bytes
            :test (lambda (x y)
                    (mw-equiv:object= x y t))))))

  (subtest "Heartbeat frame encoding/decoding"
    (let* ((heartbeat-frame (make-instance 'amqp:heartbeat-frame))
           (frame-bytes #b"\x08\x00\x00\x00\x00\x00\x00\xce")
           (obuffer (amqp:new-obuffer))
           (frame-parsed)
           (parser (amqp:make-frame-parser
                    :on-frame-type (lambda (parser frame-type)
                                     (declare (ignore parser))
                                     (is frame-type amqp:+amqp-frame-heartbeat+ "Frame is expected to be Heartbeat Frame")
                                     (is (amqp:frame-class-from-frame-type frame-type) 'amqp:heartbeat-frame))
                    :on-frame-channel (lambda (parser frame-channel)
                                        (declare (ignore parser))
                                        (is frame-channel 0 "Frame channel is expected to be 0"))
                    :on-frame-payload-size (lambda (parser payload-size)
                                             (declare (ignore parser))
                                             (is payload-size 0 "Frame payload-size is expected to be 0"))
                    :on-frame-payload (lambda (parser data start end)
                                        (declare (ignore parser data))
                                        (is start end "No payload"))
                    :on-frame-end (lambda (parser)
                                    (declare (ignore parser))
                                    (setf frame-parsed t)))))

      (amqp:frame-parser-consume parser frame-bytes)
      (is frame-parsed t "Heartbeat frame successfully parsed")

      (amqp:frame-encoder heartbeat-frame obuffer)
      (is (amqp:obuffer-get-bytes obuffer)
          #b"\x08\x00\x00\x00\x00\x00\x00\xce"
          :test (lambda (x y)
                  (mw-equiv:object= x y t))))))

(finalize)
