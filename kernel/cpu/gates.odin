package cpu

gate:: struct {
    offset0: u16,
    segment: u16,
    stack: u8,
    attribs: u8,
    offset1: u16,
    offset2: u32,
    resv: u32,
}

gate_reg:: struct {
    limit: u16,
    offset: ^gate,
}

int_gate:: proc(desc: ^gate, seg: int, offset: u64, dpl: int)
{
    desc.offset0 = u16(offset & 0xffff)
    desc.segment = u16(seg)
    desc.stack = 0
    desc.attribs = u8(0b1110 | (dpl << 5))
    desc.offset1 = u16((offset >> 16) & 0xffff)
    desc.offset2 = u32(offset >> 32)
}

gate_enable:: proc(desc: ^gate) {
    desc.attribs |= 0b1000_0000
}

gate_disable:: proc(desc: ^gate) {
    desc.attribs &= 0b0111_1111
}
