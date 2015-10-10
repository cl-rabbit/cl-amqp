(in-package :cl-amqp.test)

(plan 1)

(subtest "Conditions, basic auto-generation tests"
  (is amqp::+amqp-no-consumers+ 313
      "+AMQP-NO-CONSUMERS+ is actually 313")
  (is (amqp:error-type-from-reply-code amqp::+amqp-no-consumers+) 'amqp::amqp-error-no-consumers
      "ERROR-TYPE-FROM-REPLY-CODE should return AMQP-ERROR-NO-CONSUMERS for +AMQP-NO-CONSUMERS+")
  (is-error (error-type-from-reply-code 0) 'amqp:amqp-unknown-reply-code-error
            "ERROR-TYPE-FROM-REPLY-CODE should throw AMQP-UNKNOWN-REPLY-CODE-ERROR for invalid REPLY-CODE"))

(finalize)
