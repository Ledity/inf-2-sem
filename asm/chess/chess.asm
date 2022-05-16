global _start
    n_table equ 128
    n_guide equ 88
    flags equ 0x42              ; flags for creating and rdwr

    section .data
    table db 'r n b q k b n r',10,'p p p p p p p p',10,'. . . . . . . .',10,'. . . . . . . .',10,'. . . . . . . .',10,'. . . . . . . .',10,'P P P P P P P P',10,'R N B Q K B N R',10
    guide db 'Whites are capital, like N = white knight.',10,'Blacks are lowercase, like b = black bishop.',10
    name db 'chesstable.txt',0

    section .bss
file_desc:  resq 1

    section .text
_start:
    mov rax, 2
    mov rdi, name
    mov rsi, flags
    syscall

    push rax                    ; file descriptor into stack

    mov rax, 1                  ; print guide
    mov rdi, 1
    mov rsi, guide
    mov rdx, n_guide
    syscall

    mov rax, 1                  ; put table to file
    pop rdi                    ; file descriptor from stack to rdi
    mov rsi, table
    mov rdx, n_table
    syscall

    mov rax, 60                 ; exit
    xor rdi, rdi
    syscall
