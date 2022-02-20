package kernel

import "core:runtime"
import "kern:vga"

generic_error:: proc "contextless"(
    prefix,
    message,
    fname: string,
    line,
    col: i32)->!
{
    context = {assertion_failure_proc = kassert,}

    vga.set_attr(0x47)
    vga.clear()

    vga.set_attr(0xf0)

    kassert_title: = "SIOS INTERNAL ERROR"
    vga.set_cur(4, 2)
    vga.prints(kassert_title)

    vga.set_cur(4, 4)
    vga.prints(fname)
    vga.printc('(')
    vga.printd(int(line))
    vga.printc(':')
    vga.printd(int(col))
    vga.printc(')')

    vga.set_cur(4, 5)
    vga.prints(prefix)
    if len(message)>0 {
        vga.prints(": ")
        vga.prints(message)
    }

    for{}
}

@export
bounds_check_error:: proc "contextless"(
    file: string,
    line,
    column: i32,
    index,
    count: int)
{
    if 0 <= index && index < count do return
    generic_error("Bounds check fail", "", file, line, column)
}

@export
slice_handle_error :: proc "contextless" (
    file: string,
    line,
    column: i32,
    lo, hi: int,
    len: int) -> !
{
    generic_error("Slice error", "", file, line, column)
}

@export
multi_pointer_slice_handle_error :: proc "contextless" (
    file: string,
    line,
    column: i32,
    lo,
    hi: int) -> !
{
    generic_error("Multi pointer slice error", "", file, line, column)
}

@export
multi_pointer_slice_expr_error :: proc "contextless" (
    file: string,
    line,
    column: i32,
    lo,
    hi: int)
{
    if lo <= hi do return
    generic_error("Multi pointer slice error", "", file, line, column)
}

@export
slice_expr_error_hi :: proc "contextless" (
    file: string,
    line,
    column: i32,
    hi: int,
    len: int) 
{
    if 0 <= hi && hi < len do return
    generic_error("Slice expr error", "", file, line, column)
}

@export
slice_expr_error_lo_hi :: proc "contextless" (
    file: string,
    line,
    column: i32,
    lo,
    hi: int,
    len: int)
{
    if 0 <= lo && lo <= hi do return
    if hi < len do return
    generic_error("Slice expr error", "", file, line, column)
}

@export
dynamic_array_expr_error :: proc "contextless" (
    file: string,
    line, column: i32,
    low, high, max: int)
{
    if 0 <= low && low <= high && high <= max do return
    generic_error("Dynamic array expr error", "", file, line, column)
}

@export
matrix_bounds_check_error :: proc "contextless" (
    file: string,
    line, column: i32,
    row_index, column_index, row_count, column_count: int)
{
    if 0 <= row_index && row_index < row_count && 
       0 <= column_index && column_index < column_count {
        return
    }
    generic_error("Matrix bounds check fail", "", file, line, column)
}

@export
type_assertion_check :: proc "contextless" (
    ok: bool,
    file: string,
    line, column: i32,
    from, to: typeid)
{
    if ok do return
    generic_error("Type assertion check", "", file, line, column)
}

@export
type_assertion_check2 :: proc "contextless" (
    ok: bool,
    file: string,
    line, column: i32,
    from, to: typeid,
    from_data: rawptr)
{
    if ok do return
    generic_error("Type assertion check", "", file, line, column)
}

@export
make_slice_error_loc :: proc "contextless" (
    loc := #caller_location,
    len: int)
{
    if 0 <= len do return
    generic_error("Bad slice length for make", "", loc.file_path, loc.line, loc.column)
}

@export
make_dynamic_array_error_loc :: proc "contextless" (
    using loc := #caller_location,
    len, cap: int)
{
    if 0 <= len && len <= cap do return
    generic_error("Bad dynamic array params for make", "", file_path, line, column)
}

@export
make_map_expr_error_loc :: proc "contextless" (
    loc := #caller_location,
    cap: int)
{
    if 0 <= cap do return
    generic_error("Bad map capacity for make", "", loc.file_path, loc.line, loc.column)
}
