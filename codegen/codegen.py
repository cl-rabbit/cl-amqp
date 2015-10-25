#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Documentation for Mako templates:
# http://www.makotemplates.org/docs/syntax.html

import os, sys, re

sys.path.append(os.path.join("codegen", "rabbitmq-codegen"))

from amqp_codegen import *
try:
    from mako.template import Template
except ImportError:
    print "Mako isn't installed. Please install mako via pip or similar."
    sys.exit(1)

class AmqpSpecObject(AmqpSpec):
    def __init__(self, path):
        AmqpSpec.__init__(self, path)

    def render_template(self, path):
        file = open(path)
        template = Template(file.read())
        return template.render(spec=self)

    def render_template_to_file(self, template, dest):
        rendered = self.render_template(template)
        f = open(dest, 'w')
        f.write(rendered)

    def generate_constants_file(self):
        self.render_template_to_file("codegen/templates/constants.lisp.pytemplate", "src/protocol/constants.lisp")

    def generate_conditions_file(self):
        self.render_template_to_file("codegen/templates/conditions.lisp.pytemplate", "src/protocol/conditions.lisp")

    def generate_classes_file(self):
        self.render_template_to_file("codegen/templates/classes.lisp.pytemplate", "src/protocol/classes.lisp")

def method_signature(self):
    return '#x{0:0>8x}'.format(self.klass.index << 16 | self.index)

AmqpMethod.method_signature = method_signature

def method_lisp_class_name(self):
    return 'amqp-method-{0}-{1}'.format(self.klass.name, self.name)

AmqpMethod.method_lisp_class_name = method_lisp_class_name

SYNC_REQ_RESP = {
    "connection.start": "amqp-method-connection-start-ok",
    "connection.secure": "amqp-method-connection-secure-ok",
    "connection.tune": "amqp-method-connection-tune-ok",
    "connection.open": "amqp-method-connection-open-ok",
    "connection.close": "amqp-method-connection-close-ok",

    "channel.open": "amqp-method-channel-open-ok",
    "channel.flow": "amqp-method-channel-flow-ok",
    "channel.close": "amqp-method-channel-close-ok",

    "access.request": "amqp-method-access-request-ok",

    "exchange.declare": "amqp-method-exchange-declare-ok",
    "exchange.delete": "amqp-method-exchange-delete-ok",
    "exchange.bind": "amqp-method-exchange-bind-ok",
    "exchange.unbind": "amqp-method-exchange-unbind-ok",

    "queue.declare": "amqp-method-queue-declare-ok",
    "queue.purge": "amqp-method-queue-purge-ok",
    "queue.delete": "amqp-method-queue-delete-ok",
    "queue.bind": "amqp-method-queue-bind-ok",
    "queue.unbind": "amqp-method-queue-unbind-ok",

    "basic.qos": "amqp-method-basic-qos-ok",
    "basic.consume": "amqp-method-basic-consume-ok",
    "basic.cancel": "amqp-method-basic-cancel-ok",
    "basic.get": "amqp-method-basic-get-ok",
    "basic.recover": "amqp-method-basic-recover-ok",

    "tx.select": "amqp-method-tx-select-ok",
    "tx.commit": "amqp-method-tx-commit-ok",
    "tx.rollback": "amqp-method-tx-rollback-ok",

    "confirm.select": "amqp-method-confirm-select-ok"
}

def method_synchronous_reply_method(self):
    return SYNC_REQ_RESP['{0}.{1}'.format(self.klass.name, self.name)]

AmqpMethod.method_synchronous_reply_method = method_synchronous_reply_method

# helpers
def to_cl_condition_class(klass):
    if klass=='soft-error':
        return 'amqp-channel-error'
    else:
        return 'amqp-connection-error'


if __name__ == "__main__":
    parser = OptionParser()
    (options, args) = parser.parse_args()
    sources = args
    AmqpSpec.ignore_conflicts = True
    spec = AmqpSpecObject(sources)
    spec.type = 'client'
    spec.generate_constants_file()
    spec.generate_conditions_file()
    spec.generate_classes_file()
