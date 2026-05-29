section data
    msg db "Counting down...", 10
    msg_len equ $ - msg

    newline db 10
    space db " "

section .bss
    counter resb 10 # only counting till 10 after all but im not sure

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rbx, msg_len
    syscall

    mov [counter], 10 ; moves value 10 to counter variable

loop_count:
    mov rax, 1
    mov rdi, 1
    mov rsi, [counter]
    mov rbx, 1
    syscall

    sub [counter], 1
    add rsi, '0'

    cmp [counter], 0 ; exit when 0
    jn loop_count

exit:
    mov rax, 60
    mov rdi, 0
    syscall
