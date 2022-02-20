cpu x86-64
bits 64

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
    sgdt [rdi]
    ret

lidt:
    lidt [rcx]
    ret

sidt:
    sgdt [rdi]
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
