section .data
    prompt db "What is your name? ", 0 
    prompt_len equ $ - prompt

    prompt2 db "What is your last name? ", 0 ; age was too dificult
    prompt2_len equ $ - prompt2

    hello_msg db "Hello, ",
    hello_len equ $ - hello_msg

    result_msg db "So your full name is ",
    result_len equ $ - result_msg

    final_msg db "Nice to meet you!", 10
    final_len equ $ - final_msg

    newline db 10
    space db " "

section .bss
    name_buffer resb 64
    last_buffer resb 64

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, name_buffer
    mov rdx, 64
    syscall

    mov rbx, rax ; save buffer len to use later

    mov rax, 1
    mov rdi, 1
    mov rsi, hello_msg
    mov rdx, hello_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, name_buffer
    mov rdx, rbx
    syscall

    ; print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt2
    mov rdx, prompt2_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, last_buffer
    mov rdx, 64
    syscall

    mov r12, rax ; save buffer len to use later

    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, result_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, name_buffer
    mov rdx, rbx
    syscall

    ; space
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, last_buffer
    mov rdx, r12
    syscall


    mov rax, 1
    mov rdi, 1
    mov rsi, final_msg
    mov rdx, final_len
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall


