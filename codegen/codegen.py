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
