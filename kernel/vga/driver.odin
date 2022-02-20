package vga

width: int
height: int
vga: [^]point

cur_x: int = 0
cur_y: int = 0

attr: u8

point: : struct {
    char: u8,
    attr: u8,
}


