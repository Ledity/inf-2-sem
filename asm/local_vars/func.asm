global func

    section .bss
    section .data
    section .text
func:
    push rbp
    mov rbp, rsp
    mov dword [rbp - 0xC], 7
    mov dword [rbp - 0x8], 8
    mov edx, dword [rbp - 0xc]
    mov eax, dword [rbp - 0x8]
    add eax, edx
    mov dword [rbp - 0x4], eax ; summ is still in eax
    pop rbp
    ret
