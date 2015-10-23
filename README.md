# CL-AMQP [![Build Status](https://travis-ci.org/cl-rabbit/cl-amqp.svg)](https://travis-ci.org/cl-rabbit/cl-amqp) [![Coverage Status](https://coveralls.io/repos/cl-rabbit/cl-amqp/badge.svg?branch=master&service=github)](https://coveralls.io/github/cl-rabbit/cl-amqp?branch=master)
AMQP 0.9.1 with RabbitMQ extensions in Common Lisp

## Example

### Encoding
``` lisp

(let* ((method (make-instance 'amqp:amqp-method-basic-ack :delivery-tag 100))
       (frame (make-instance 'amqp:method-frame :channel 1
                                                :payload method))
       (obuffer (amqp:new-obuffer)))
  (amqp:obuffer-get-bytes
    (amqp:frame-encode frame obuffer)))

=>
#b"\x01\x00\x01\x00\x00\x00\x0d\x00<\x00P\x00\x00\x00\x00\x00\x00\x00d\x00\xce"

```

### Decoding
``` lisp
(let* ((bytes #b"\x01\x00\x01\x00\x00\x00\x0d\x00<\x00P\x00\x00\x00\x00\x00\x00\x00d\x00\xce")
       (payload-parser)
       (frame)
       (parser (amqp:make-frame-parser
                :on-frame-type (lambda (parser frame-type)
                                 (declare (ignore parser))
                                 (setf frame (make-instance 
                                               (amqp:frame-class-from-frame-type frame-type))))
                :on-frame-channel (lambda (parser frame-channel)
                                    (declare (ignore parser))
                                    (setf (amqp:frame-channel frame) frame-channel))
                :on-frame-payload-size (lambda (parser payload-size)
                                         (declare (ignore parser))
                                         (setf (amqp:frame-size frame) payload-size)
                                         (setf payload-parser
                                               (amqp:make-frame-payload-parser frame)))
                :on-frame-payload (lambda (parser data start end)
                                    (declare (ignore parser))
                                    (amqp:frame-payload-parser-consume payload-parser 
                                                                       data :start start :end end))
                :on-frame-end (lambda (parser)
                                (declare (ignore parser))
                                (amqp:frame-payload-parser-finish payload-parser)))))

  (amqp:frame-parser-consume parser bytes)
  (amqp:frame-payload frame))
  
=>
#<CL-AMQP:AMQP-METHOD-BASIC-ACK {1009C6B703}>
```

## License

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

By contributing to the project, you agree to the license and copyright terms therein and release your contribution under these terms.

## Copyright

Copyright (c) 2015 Ilya Khaprov <ilya.khaprov@publitechs.com> and [CONTRIBUTORS](CONTRIBUTORS.md)

CL-AMQP uses a shared copyright model: each contributor holds copyright over their contributions to CL-AMQP. The project versioning records all such contribution and copyright details.

If a contributor wants to further mark their specific copyright on a particular contribution, they should indicate their copyright solely in the commit message of the change when it is committed. Do not include copyright notices in files for this purpose.
