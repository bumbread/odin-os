package kernel

import "core:runtime"
import "kern:cpu"
import "kern:vga"

@(export) kernel_stack: [8196]u8 = {}

kmain :: proc() {
    assert(0 != 0)
    //vga.prints("Hello, world!", 0x04)
    for(true){}
}

assert :: proc(condition: bool, message := "", loc := #caller_location) {
    // Note(bumbread): see core:tunrime/core_builtin.odin
    // this is the same but no default_assertion_failure_proc
    if !condition {
        context.assertion_failure_proc("runtime assertion", message, loc)
    }
}

kassert :: proc (prefix, message: string, loc: runtime.Source_Code_Location)->!
{
    vga.set_attr(0x47)
    vga.clear()

    vga.set_attr(0xf0)

    kassert_title: = "SIOS ASSERTION"
    vga.set_cur(4, 2)
    vga.prints(kassert_title)

    vga.set_cur(4, 4)
    vga.prints(loc.file_path)
    vga.printc('(')
    vga.printd(int(loc.line))
    vga.printc(':')
    vga.printd(int(loc.column))
    vga.printc(')')

    vga.set_cur(4, 5)
    vga.prints(prefix)
    if len(message)>0 {
        vga.prints(": ")
        vga.prints(message)
    }

    for{}
}
