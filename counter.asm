section .data
    msg db "Counting down...", 10
    msg_len equ $ - msg

    newline db 10
    space db " "

section .bss
    counter resb 4
    buffer resb 4

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov byte [counter], 99

loop_count:
    ; parse numbers
    movzx rax, byte [counter] ; clear upper bit
    xor rdx, rdx
    mov rcx, 10
    div rcx ; results in rax and rdx

    push rdx

    cmp al, 0
    je single_digit

    ; convert the fist number
    add rax, '0'   
    mov [buffer], al

    ; print the first number
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 1
    syscall


single_digit:
    pop rdx
    ; convert the second number
    add rdx, '0'   
    mov [buffer], dl

    ; print the second number
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 1
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    sub byte [counter], 1

    cmp byte [counter], 0
    jnz loop_count

exit:
    mov rax, 60
    mov rdi, 0
    syscall
