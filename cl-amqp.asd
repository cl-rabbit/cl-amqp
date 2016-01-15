(in-package :cl-user)

(defpackage :cl-amqp.system
  (:use :cl :asdf))

(in-package :cl-amqp.system)

(defsystem :cl-amqp
  :version "0.2"
  :description "AMQP 0.9.1 with RabbitMQ extensions in Common Lisp"  
  :maintainer "Ilya Khaprov <ilya.khaprov@publitechs.com>"
  :author "Ilya Khaprov <ilya.khaprov@publitechs.com> and CONTRIBUTORS"
  :homepage "https://github.com/cl-rabbit/cl-amqp"
  :licence "MIT"
  :depends-on ("alexandria"
               "nibbles"
               "cl-interpol"
               "wu-decimal"
               "local-time"
               "collectors"
               "trivial-utf-8"
               "fast-io"
               "log4cl")
  :serial t
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "util/binary-string")
                 (:file "util/ibuffer")
                 (:file "util/obuffer")
                 (:module "protocol"
                  :serial t
                  :components
                  ((:file "constants")
                   (:file "conditions")
                   (:file "classes")
                   (:file "types")
                   (:file "frame")))
                 (:file "method"))))
  :in-order-to ((test-op (test-op cl-amqp.test))))
