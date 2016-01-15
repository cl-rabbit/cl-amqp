(in-package :cl-user)

(defpackage :cl-amqp.test.system
  (:use :cl :asdf))

(in-package :cl-amqp.test.system)

(defsystem :cl-amqp.test
  :version "0.1"
  :description "Tests for cl-amqp"
  :maintainer "Ilya Khaprov <ilya.khaprov@publitechs.com>"
  :author "Ilya Khaprov <ilya.khaprov@publitechs.com> and CONTRIBUTORS"
  :licence "MIT"
  :depends-on ("cl-amqp"
               "prove"
               "log4cl"
               "mw-equiv"
               "cl-interpol")
  :serial t
  :components ((:module "t"
                :serial t
                :components
                ((:file "package")
                 (:test-file "dummy")
                 (:test-file "util/binary-string")
                 (:test-file "conditions")
                 (:test-file "frame")
                 (:test-file "method")
                 (:test-file "types"))))
  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
