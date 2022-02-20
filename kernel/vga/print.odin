package vga

clear: : proc() {
    for j in 0..<height do for i in 0..<width do vga[i+j*width] = {0, attr}
}

set_cur: : proc(x,y: int)
{
    cur_x = x
    cur_y = y
}

set_attr: : proc(new_attr: u8)
{
    attr = new_attr
}

printc: : proc(char: u8)
{
    point_idx: = cur_x + cur_y*width
    vga[point_idx].char = char
    vga[point_idx].attr = attr
    
    cur_x += 1
    if char == '\n' {
        cur_x = 0
        cur_y += 1
    }
    else if char == '\t' {
        cur_x = cur_x&0xf8 + 8
        if cur_x == width {
            cur_x = 0
                cur_y += 1
        }
    }
}

prints: : proc(s: string)
{
    for c in transmute([]u8)s {
        printc(c)
    }
}

printd: : proc(number: int)
{
    D: [20]u8
    i: int = len(D)
    n: = number
    for {
        i -= 1
        d: = cast(u8)(i % 10)+'0'
        D[i] = d
        n /= 10
        if n == 0 do break
    }
    s: = transmute(string) D[i:len(D)]
    prints(s)
}

printh: : proc(integer: int, do_0x := false)
{
    if do_0x {
        printc('0')
        printc('x')
    }
    i: = integer
    for {
        d: = cast(u8)(i & 0x0f)
        if d >= 10 do d = d - 10 + 'a'
        else       do d = d + '0'
        printc(d)
        i >>= 16
        if i == 0 do break
    }
}

