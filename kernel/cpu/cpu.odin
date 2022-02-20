package cpu
foreign import cpu "bin/cpu.o"

@(default_calling_convention="c")
foreign cpu {
    enable_sse:: proc () ---
    lgdt:: proc(gdt: ^gate_reg) ---
    sgdt:: proc()->gate_reg ---
    lidt:: proc(idt: ^gate_reg) ---
    sidt:: proc()->gate_reg ---
    sti:: proc() ---
    cli:: proc() ---
    inp1:: proc(value: int, port: int) ---
    inp2:: proc(value: int, port: int) ---
    inp4:: proc(value: int, port: int) ---
    out1:: proc(value: int, port: int) ---
    out2:: proc(value: int, port: int) ---
    out4:: proc(value: int, port: int) ---
}
