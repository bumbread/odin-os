package cpu

setup_idt:: proc() {
    idt: gate_reg = sidt()
    gates: ^gate = idt.offset

    assert(idt.limit == 256)

    cli()

    

    sti()   
}

