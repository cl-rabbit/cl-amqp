# -*- coding: utf-8 -*-

def genSingleEncode(spec, cValue, unresolved_domain):
    buffer = []
    type = spec.resolveDomain(unresolved_domain)
    if type == 'shortstr':
        buffer.append("(amqp-shortstr-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'longstr':
        buffer.append("(amqp-longstr-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'octet':
        buffer.append("(amqp-octet-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'short':
        buffer.append("(amqp-short-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'long':
        buffer.append("(amqp-long-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'longlong':
        buffer.append("(amqp-longlong-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'timestamp':
        buffer.append("(amqp-timestamp-encoder obuffer (slot-value method '%s))" % (cValue,))
    elif type == 'bit':
        raise "Can't encode bit in genSingleEncode"
    elif type == 'table':
        buffer.append("(amqp-table-encoder obuffer (slot-value method '%s))" % (cValue,))
    else:
        raise "Illegal domain in genSingleEncode", type

    return buffer

def genSingleDecode(spec, field):
    cLvalue = field.name
    unresolved_domain = field.domain

    if cLvalue == "known_hosts":
        import sys
        print >> sys.stderr, field, field.ignored

    type = spec.resolveDomain(unresolved_domain)
    buffer = []
    if type == 'shortstr':
        buffer.append(":%s (amqp-shortstr-decoder ibuffer)" % (cLvalue,))
    elif type == 'longstr':
        buffer.append(":%s (amqp-longstr-decoder ibuffer)" % (cLvalue,))
    elif type == 'octet':
        buffer.append(":%s (amqp-octet-decoder ibuffer)" % (cLvalue,))
    elif type == 'short':
        buffer.append(":%s (amqp-short-decoder ibuffer)" % (cLvalue,))
    elif type == 'long':
        buffer.append(":%s (amqp-long-decoder ibuffer)" % (cLvalue,))
    elif type == 'longlong':
        buffer.append(":%s (amqp-longlong-decoder ibuffer)" % (cLvalue,))
    elif type == 'timestamp':
        buffer.append(":%s (amqp-timestamp-decoder ibuffer)" % (cLvalue,))
    elif type == 'bit':
        raise "Can't decode bit in genSingleDecode"
    elif type == 'table':
        buffer.append(":%s (amqp-table-decoder ibuffer)" % (cLvalue,))
    else:
        raise StandardError("Illegal domain '" + type + "' in genSingleDecode")

    return buffer


def genEncodeMethodDefinition(spec, m):
    def finishBits():
        if bit_index is not None:
            buffer.append("(amqp-octet-encoder obuffer bit-buffer)")

    bit_index = None
    buffer = []

    for f in m.arguments:
        if spec.resolveDomain(f.domain) == 'bit':
            if bit_index is None:
                bit_index = 0
                buffer.append("(setf bit-buffer 0)")
            if bit_index >= 8:
                finishBits()
                buffer.append("(setf bit-buffer 0)")
                bit_index = 0
            buffer.append("(when (slot-value method '%s) (setf (ldb (byte 8 %d) bit-buffer) 1))" % (f.name, bit_index))
            bit_index = bit_index + 1
        else:
            finishBits()
            bit_index = None
            buffer += genSingleEncode(spec, f.name, f.domain)

    finishBits()
    return buffer

def genDecodeMethodDefinition(spec, m):
    buffer = []
    bitindex = None
    for f in m.arguments:
        if spec.resolveDomain(f.domain) == 'bit':
            if bitindex is None:
                bitindex = 0
            if bitindex >= 8:
                bitindex = 0
            if bitindex == 0:
                buffer.append(":%s (progn" % (f.name))
                buffer.append("  (setf bit-buffer (ibuffer-decode-ub8 ibuffer))")
                buffer.append("  (not (zerop (ldb (byte 8 %d) bit-buffer))))" % (bitindex))
                #### TODO: ADD bitindex TO THE buffer
            else:
                buffer.append(":%s (not (zerop (ldb (byte 8 %d) bit-buffer)))" % (f.name, bitindex))
            bitindex = bitindex + 1
        else:
            bitindex = None
            buffer += genSingleDecode(spec, f)
    return buffer

def convert_value_to_cl(value):
    if isinstance(value, unicode):
        return '"%s"' % (value.encode('ascii'))
    if isinstance(value, bool):
        return "t" if value else ":false"
    if isinstance(value, dict):
        if value == {}:
            return "nil"
        else:            
            raise "Can't emit code for non-empty table"
    else:
        return repr(value)

def genMethodArgInitform(field):
    value = field.defaultvalue
    if value == None:
        return ""
    else:
        return " :initform " + convert_value_to_cl(value)
