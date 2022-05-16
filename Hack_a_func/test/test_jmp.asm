global _start

    section .data
sas:    db 0xFF
    section .text
_start:
    jmp l2
l1: mov rax, 60
    syscall

l2: mov rax, 60
    xor rdi, rdi

    jmp l1

    inc rdi
    syscall
