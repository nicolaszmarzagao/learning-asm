%include "macros.inc"
extern print_string

section .data
    msg db "Hello, World!", 10
    len equ $ - msg

section .text
    global _start

_start:
    mov rsi, msg
    mov rdx, len
    call print_string

    exit 0

