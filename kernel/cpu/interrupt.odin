package cpu

@export
int03_handler:: proc"c"() {
    
}

setup_idt:: proc() {
    //idt: ^gate_reg
    //sidt(idt)
    //gates: [^]gate = idt.offset

    assert(255 == 256, "!!!!!")

    //cli()
    //int_gate(&gates[0x03], 0x08, rawptr(int03_idt_handler), 0)
    //sti() 
    //int03()
}

