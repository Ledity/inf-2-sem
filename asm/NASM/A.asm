global main
    N equ 34

;;     section .bss
;; output:  resb N

    section .data
output: db 'Liberté, égalité, fraternité!',10

    section .text
main:
    call write_to_output
    call exit

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
