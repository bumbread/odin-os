cpu x86-64
bits 64

extern int03_handler

global enable_sse
global lgdt
global sgdt
global lidt
global sidt
global sti
global cli
global inp1
global inp2
global inp4
global out1
global out2
global out4
global int03_idt_handler
global int03

section .text
enable_sse:
    mov rax, cr0
    ; clear coprocessor emulation CR0.EM
    and ax, 0xFFFB
    ; set coprocessor monitoring  CR0.MP
    or ax, 0x2
    mov cr0, rax
    mov rax, cr4
    ; set CR4.OSFXSR and CR4.OSXMMEXCPT at the same time
    or ax, 3 << 9
    mov cr4, rax
    ret

lgdt:
    lgdt [rcx]
    ret

sgdt:
    sgdt [rcx]
    ret

lidt:
    lidt [rcx]
    ret

sidt:
    sgdt [rcx]
    ret

sti:
    sti
    ret

cli:
    cli
    ret

inp1:
    mov al, cl
    in al, dx
    ret
inp2:
    mov ax, cx
    in al, dx
    ret
inp4:
    mov eax, ecx
    in eax, dx
    ret
out1:
    mov al, cl
    out dx, al
    ret
out2:
    mov ax, cx
    out dx, al
    ret
out4:
    mov eax, ecx
    out dx, eax
    ret

int03_idt_handler:
    ;; Push GP registers
    push rax
    push rcx
    push rdx
    push rbp
    push rdi
    push rsi
    push rbp
    push r8
    push r9
    push r10
    push r11
    ;; Push SSE, MMX and FPU state (512 bytes)
    ;sub sp, 512
    ;fxsave sp
    cld
    call int03_handler
    ;; Pop SSE, MMX and FPU state
    ;fxtract sp
    ;add sp, 512
    ;; Pop GP registers
    pop r11
    pop r10
    pop r9
    pop r8
    pop rbp
    pop rsi
    pop rdi
    pop rbp
    pop rdx
    pop rcx
    pop rax
    iretq

int03:
    int3
    ret
