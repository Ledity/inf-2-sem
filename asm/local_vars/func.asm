global func

    section .bss
    section .data
    section .text
func:
    mov rdx, 7
    mov rbx, 8
    add rdx, rbx

    call exit

exit:
    mov rax, 60
    mov rdi, rdx
    syscall
    ret
