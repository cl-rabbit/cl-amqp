# -*- coding: utf-8 -*-

def genSingleEncode(spec, cValue, unresolved_domain):
    buffer = []
    type = spec.resolveDomain(unresolved_domain)
    if type == 'shortstr':
        buffer.append("(amqp-sstring-encoder obuffer %s)" % (cValue,))
    elif type == 'longstr':
        buffer.append("(amqp-lstring-encoder obuffer %s)" % (cValue,))
    elif type == 'octet':
        buffer.append("(amqp-sb8-encoder obuffer %s)" % (cValue,))
    elif type == 'short':
        buffer.append("(amqp-sb16-encoder obuffer %s)" % (cValue,))
    elif type == 'long':
        buffer.append("(amqp-sb32-encoder obuffer %s)" % (cValue,))
    elif type == 'longlong':
        buffer.append("(amqp-sb64-encoder obuffer %s)" % (cValue,))
    elif type == 'timestamp':
        buffer.append("(amqp-timestamp-encoder obuffer %s)" % (cValue,))
    elif type == 'bit':
        raise "Can't encode bit in genSingleEncode"
    elif type == 'table':
        buffer.append("(amqp-table-encoder obuffer %s)" % (cValue,))
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
        buffer.append("(setf %s (amqp-sstring-decoder ibuffer))" % (cLvalue,))
    elif type == 'longstr':
        buffer.append("(setf %s (amqp-lstring-decoder ibuffer))" % (cLvalue,))
    elif type == 'octet':
        buffer.append("(setf %s (amqp-sb8-decoder ibuffer))" % (cLvalue,))
    elif type == 'short':
        buffer.append("(setf %s (amqp-sb16-decoder ibuffer))" % (cLvalue,))
    elif type == 'long':
        buffer.append("(setf %s (amqp-sb32-decoder ibuffer))" % (cLvalue,))
    elif type == 'longlong':
        buffer.append("(setf %s (amqp-sb64-decoder ibuffer))" % (cLvalue,))
    elif type == 'timestamp':
        buffer.append("(setf %s (amqp-timestamp-decoder ibuffer))" % (cLvalue,))
    elif type == 'bit':
        raise "Can't decode bit in genSingleDecode"
    elif type == 'table':
        buffer.append("(setf %s (amqp-table-decoder ibuffer))" % (cLvalue,))
    else:
        raise StandardError("Illegal domain '" + type + "' in genSingleDecode")

    return buffer



def genSingleSimpleDecode(spec, field):
    cLvalue = field.name
    unresolved_domain = field.domain

    if cLvalue == "known_hosts":
        import sys
        print >> sys.stderr, field, field.ignored

    type = spec.resolveDomain(unresolved_domain)
    buffer = []
    if type == 'shortstr':
        buffer.append("data.to_s")
    elif type == 'longstr':
        buffer.append("data.to_s")
    elif type == 'octet':
        buffer.append("data.unpack(PACK_INT8).first")
    elif type == 'short':
        buffer.append("data.unpack(PACK_UINT16).first")
    elif type == 'long':
        buffer.append("data.unpack(PACK_UINT32).first")
    elif type == 'longlong':
        buffer.append("AMQ::Pack.unpack_uint64_big_endian(data).first")
    elif type == 'timestamp':
        buffer.append("Time.at(data.unpack(PACK_UINT32_X2).last)")
    elif type == 'bit':
        raise "Can't decode bit in genSingleDecode"
    elif type == 'table':
        buffer.append("Table.decode(data)")
    else:
        raise StandardError("Illegal domain '" + type + "' in genSingleSimpleDecode")

    return buffer


def genEncodeMethodDefinition(spec, m):
    def finishBits():
        if bit_index is not None:
            buffer.append("buffer << [bit_buffer].pack(PACK_CHAR)")

    bit_index = None
    buffer = []

    for f in m.arguments:
        if spec.resolveDomain(f.domain) == 'bit':
            if bit_index is None:
                bit_index = 0
                buffer.append("bit_buffer = 0")
            if bit_index >= 8:
                finishBits()
                buffer.append("bit_buffer = 0")
                bit_index = 0
            buffer.append("bit_buffer = bit_buffer | (1 << %d) if %s" % (bit_index, f.name))
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
                buffer.append("bit_buffer = data[offset, 1].unpack(PACK_CHAR).first")
                buffer.append("offset += 1")
                buffer.append("%s = (bit_buffer & (1 << %d)) != 0" % (f.name, bitindex))
                #### TODO: ADD bitindex TO THE buffer
            else:
                buffer.append("%s = (bit_buffer & (1 << %d)) != 0" % (f.name, bitindex))
            bitindex = bitindex + 1
        else:
            bitindex = None
            buffer += genSingleDecode(spec, f)
    return buffer
