global main

    section .bss
input:  resb 1
flag:   resb 1
number: resd 1

    section .data
sas:    db 'a', 10
minus:  db '-'

    section .text
main:
    mov byte [flag], 0
    call read_sig
    call is_less_than_zero

    mov eax, [number]

    mov byte [flag], 0
    call read_sig
    call is_less_than_zero

    mov ebx, [number]

    cmp eax, ebx
    jl label1
    mov [number], ebx
    jmp label2
label1:
    mov [number], eax
label2:

    call put_sig

    call exit

is_less_than_zero:
    cmp byte [flag], 1
    jne further_sas

    push rax
    xor eax, eax
    sub eax, [number]
    mov [number], eax
    pop rax

further_sas:
    ret

    ;; ---

read_sig:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push rsp
    push rbp

    xor edi, edi                ; edi := 0
    xor esi, esi                ; esi := 0

m1:
    jmp getchar
back_getchar:

    xor eax, eax
    mov al, [input]             ; al : = [input]
    cmp al, 0xA
    je m2
    cmp al, ' '
    je m2

    cmp al, '-'
    je less_than_zero

    cmp al, '0'
    jb r_u_exit
    cmp al, '9'
    ja r_u_exit
    jmp further2

less_than_zero:
    mov byte [flag], 1
    jmp m1

further2:
    inc edi
    xor ecx, ecx
    mov cl, al
    mov eax, esi
    mov ebx, 10
    mul ebx
    sub cl, 48
    add eax, ecx
    jc r_u_exit
    mov esi, eax
    jmp m1

m2:
    mov [number], esi

r_u_exit:
    pop rbp
    pop rsp
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

getchar:
    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 1
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rax

    jmp back_getchar

    ;; ---

put_sig:
    cmp dword [number], 0
    jl print_minus
    jmp further_1

print_minus:
    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, minus
    mov rdx, 1
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rax

    not dword [number]
    inc dword [number]

further_1:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push rsp
    push rbp

    mov eax, dword [number]
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

    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, 1
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rax

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

    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, 1
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rax

    pop rbp
    pop rsp
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

    ;; ---

put_a:
    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, sas
    mov rdx, 2
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rax

    ret

    ;; ---

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret
