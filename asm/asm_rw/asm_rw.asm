global _start
    N equ 100

    code_a equ 97
    code_z equ 122
    code_A equ 65
    code_Z equ 90

    section .bss
input:  resb N
output: resb N

    section .text
_start:
    call read_to_input
    mov rcx, N

loop_strt:
    mov rdx, N
    sub rdx, rcx                ; these two lines put the iteration number i to EDX
    mov bl, [input + rdx]       ; now in BL there is symbol input[i]

    cmp bl, code_a
    jge more_than_a             ; if bl is more than 'a' ... <1>
    jmp go_further              ; else

more_than_a:
    cmp bl, code_z
    jbe make_higher              ; <1> ... and less than 'z' ... <2>
    jmp go_further              ; else

make_higher:
    sub bl, 32                  ; <2> ... make it higher
    jmp loop_end

go_further:
    cmp bl, code_A
    jge more_than_A             ; if bl is more than 'A' ... <3>
    jmp loop_end              ; else

more_than_A:
    cmp bl, code_Z
    jbe make_lower              ; <3> ... and less than 'Z' ... <4>
    jmp go_further              ; else

make_lower:
    add bl, 32
    jmp loop_end

loop_end:
    mov [output + rdx], bl
    loop loop_strt

    call write_to_output
    call exit


read_to_input:                  ; reads 100 symbols to "input" variable
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, N

    syscall
    ret

write_to_output:                ; writes 100 simbols from "output" variable
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, N

    syscall
    ret

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret
