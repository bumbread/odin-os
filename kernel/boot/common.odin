package boot

import "kern:vga"

kstartup_runtime :: proc "c" () {
    vga.width = 80
    vga.height = 25
    vga.vga = cast([^]vga.point)uintptr(0xb8000)
    vga.attr = 0x0f
}
