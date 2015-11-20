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

    IGNORED_CLASSES = ["access"]
    IGNORED_FIELDS = {
        'ticket': 0,
        'capabilities': '',
        'insist' : 0,
        'out-of-band': '',
        'known-hosts': '',
    }

    def __init__(self, path):
        AmqpSpec.__init__(self, path)
        def extend_field(field):
            field.ruby_name = re.sub("[- ]", "_", field.name)
            field.type = self.resolveDomain(field.domain)
            field.ignored = bool(field.name in self.__class__.IGNORED_FIELDS) # I. e. deprecated

        for klass in self.classes:
            klass.ignored = bool(klass.name in self.__class__.IGNORED_CLASSES)

            for field in klass.fields:
                extend_field(field)

            for method in klass.methods:
                for field in method.arguments:
                    extend_field(field)

        # self.classes = filter(lambda klass: not klass.ignored, self.classes)

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

    def generate_package_file(self):
        self.render_template_to_file("codegen/templates/package.lisp.pytemplate", "src/package.lisp")

def findMethodByName(self, name):
    for method in self.methods:
        if method.name == name:
            return method

AmqpClass.findMethodByName = findMethodByName

def method_signature(self):
    return '#x{0:0>8x}'.format(self.klass.index << 16 | self.index)

AmqpMethod.method_signature = method_signature

def method_lisp_class_name(self):
    return 'amqp-method-{0}-{1}'.format(self.klass.name, self.name)

AmqpMethod.method_lisp_class_name = method_lisp_class_name

def method_interface_fun_name(self):
    if self.klass.name == 'basic':
        return self.name
    else:
        return '%s.%s' % (self.klass.name, self.name)

AmqpMethod.method_interface_fun_name = method_interface_fun_name

SYNC_REQ_RESP = {
    "connection.start": "start-ok",
    "connection.secure": "secure-ok",
    "connection.tune": "tune-ok",
    "connection.open": "open-ok",
    "connection.close": "close-ok",

    "channel.open": "open-ok",
    "channel.flow": "flow-ok",
    "channel.close": "close-ok",

    "access.request": "request-ok",

    "exchange.declare": "declare-ok",
    "exchange.delete": "delete-ok",
    "exchange.bind": "bind-ok",
    "exchange.unbind": "unbind-ok",

    "queue.declare": "declare-ok",
    "queue.purge": "purge-ok",
    "queue.delete": "delete-ok",
    "queue.bind": "bind-ok",
    "queue.unbind": "unbind-ok",

    "basic.qos": "qos-ok",
    "basic.consume": "consume-ok",
    "basic.cancel": "cancel-ok",
    "basic.get": ["get-empty", "get-ok"],
    "basic.recover": "recover-ok",

    "tx.select": "select-ok",
    "tx.commit": "commit-ok",
    "tx.rollback": "rollback-ok",

    "confirm.select": "select-ok"
}

def method_synchronous_reply_method(self):
    klass = self.klass
    return klass.findMethodByName(SYNC_REQ_RESP['{0}.{1}'.format(self.klass.name, self.name)])

AmqpMethod.method_synchronous_reply_method = method_synchronous_reply_method

def method_synchronous_reply_method_lisp_name(self):
    reply = SYNC_REQ_RESP['{0}.{1}'.format(self.klass.name, self.name)]
    if isinstance(reply, list):
        format_str = "("+' '.join(["amqp-method-"+ self.klass.name +"-%s"]*len(reply))+")"
        return format_str % tuple(reply)
    else:
        return 'amqp-method-%s-%s' % (self.klass.name, reply)

AmqpMethod.method_synchronous_reply_method_lisp_name = method_synchronous_reply_method_lisp_name

accepted_by_update = json.loads(file("codegen/amqp_0.9.1_changes.json").read())

def accepted_by(self, *receivers):
    def get_accepted_by(self):
        try:
            return accepted_by_update[self.klass.name][self.name]
        except KeyError:
            return ["server", "client"]

    actual_receivers = get_accepted_by(self)
    return all(map(lambda receiver: receiver in actual_receivers, receivers))

AmqpMethod.accepted_by = accepted_by

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
    spec.generate_package_file()
