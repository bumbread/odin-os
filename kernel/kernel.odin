package kernel

import "core:runtime"
import "kern:cpu"
import "kern:vga"

@(export) kernel_stack: [8196]u8 = {}

kmain :: proc() {
    //cpu.setup_idt()

    b: = 2
    a: [2]int
    a[b] = 5
    
    //assert(0 != 0)
    //vga.prints("Hello, world!", 0x04)
    for(true){}
}

assert :: proc(condition: bool, message := "", loc := #caller_location) {
    // Note(bumbread): see core:runtime/core_builtin.odin
    // this is the same but no default_assertion_failure_proc
    if !condition {
        context.assertion_failure_proc("runtime assertion", message, loc)
    }
}

kassert :: proc (prefix, message: string, loc: runtime.Source_Code_Location)->!
{
    generic_error(prefix, message, loc.file_path, loc.line, loc.column)
}
