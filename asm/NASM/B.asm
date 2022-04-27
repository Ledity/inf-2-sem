global _start

    section .bss
input:  resb 1
number: resd 1

    section .data
sas:    db 'a', 10

    section .text
_start:
    call read_uns

    ;; and dword [number], 0000FFFFh

    call put_uns

    call exit

    ;; ---

read_uns:
    mov dword [number], 0

loop_read_uns:
    call getchar

    cmp byte [input], 10
    jne l1                      ; if [input] != '\n'

    ret
l1:
    mov eax, [number]           ; eax = [number]
    shl eax, 1                  ; eax = 2[number]
    mov ebx, 5
    mul ebx                     ; eax = 10 [number]
    add eax, dword [input]      ; eax = 10 [number] + [input] + '0'
    sub eax, '0'          ; eax = 10 [number] + [input]

    mov dword [number], eax
    jmp loop_read_uns

getchar:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 1
    syscall

    ret

    ;; ---

put_uns:
    mov eax, [number]
    mov edi, eax
    mov esi, 10
    xor ebx, ebx
loop1:
    xor edx, edx
    div esi

    inc ebx
    cmp eax, 0
    jne loop1

    mov eax, 1
    mov ecx, ebx
    dec ecx

    cmp ecx, 0
    je loop4

loop2:
    mul esi
    loop loop2

    mov ebx, eax

loop3:
    mov eax, edi
    xor edx, edx
    div ebx
    add al, '0'
    mov byte [input], al
    call putchar

    mov edi, edx
    xor edx, edx
    mov eax, ebx
    div esi
    cmp eax, 1
    je loop4
    mov ebx, eax
    jmp loop3

loop4:
    mov edx, edi
    add dl, '0'
    mov byte [input], dl
    call putchar

    ret

putchar:

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, 1
    syscall

    ret

    ;; ---

put_a:
    mov rax, 1
    mov rdi, 1
    mov rsi, sas
    mov rdx, 2
    syscall

    ret

    ;; ---

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret
