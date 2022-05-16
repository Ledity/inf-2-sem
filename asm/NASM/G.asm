global main

    section .bss
input:  resb 1
number: resq 1

    section .data
sas:    db ' ', 10
YES:    db 'YES', 10
NO:     db 'NO', 10

    section .text
main:
    call read_uns

    mov rax, [number]

    call read_uns

    mov rbx, [number]
    add rbx, rax
    jc label_yes
    call put_no
    jmp label_exit
label_yes:
    call put_yes
label_exit:

    ;; call put_uns
    ;; call put_a
    ;; mov [number], rax
    ;; call put_uns
    ;; call put_a

    call exit

    ;; ---

read_uns:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push rsp
    push rbp

    xor rdi, rdi                ; rdi := 0
    xor rsi, rsi                ; rsi := 0
m1:
    jmp getchar
back_getchar:

    xor rax, rax
    mov al, [input]             ; al : = [input]
    cmp al, 0xA
    je m2                       ; (al == 10) ? -> m2

    cmp al, '0'
    jb r_u_exit
    cmp al, '9'
    ja r_u_exit

    inc rdi
    xor rcx, rcx
    mov cl, al
    mov rax, rsi
    mov rbx, 10
    mul rbx
    sub cl, 48
    add rax, rcx
    jc r_u_exit
    mov rsi, rax
    jmp m1
m2:
    mov [number], rsi
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

put_uns:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push rsp
    push rbp
    mov rax, qword [number]
    mov rdi, rax
    mov rsi, 10
    xor rbx, rbx
loop1:
    xor rdx, rdx
    div rsi

    inc rbx
    cmp rax, 0
    jne loop1

    mov rax, 1
    mov rcx, rbx
    dec rcx

    cmp rcx, 0
    je loop4

loop2:
    mul rsi
    loop loop2

    mov rbx, rax

loop3:
    mov rax, rdi
    xor rdx, rdx
    div rbx
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

    mov rdi, rdx
    xor rdx, rdx
    mov rax, rbx
    div rsi
    cmp rax, 1
    je loop4
    mov rbx, rax
    jmp loop3

loop4:
    mov rdx, rdi
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

put_yes:
    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, YES
    mov rdx, 4
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rax

    ret

    ;; ---

put_no:
    push rax
    push rdx
    push rsi
    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, NO
    mov rdx, 3
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
