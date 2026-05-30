section .data
    space db " "
    newline db 10

    title db "Welcome to FizzBuzz in Assembly! By Nicolas M.", 10
    title_len $ - title 

    prompt db "Pick a number between 1 and 999: "
    prompt_len $ - prompt

section .bss
    counter resb 4
    buffer resb 4
    buffer_len resb

section .text
    global _start

_start:
    ; get user input


    mov byte [counter], 20

print_string:
    ; ags:
    ; rsi = string address, rdx = string len
    mov rax, 1
    mov rdi, 1
    syscall

    ret

convert_counter:
    ; args:
    ; this function will directly check what number is in counter
    ; returns:
    ; [buffer] = full number in string
    ; [buffer_len] = length of that string (used to print)

    movzx rax, byte [counter] ; clear upper bit
    xor rdx, rdx
    mov rcx, 10
    div rcx ; results in rax and rdx

    cmp al, 0
    je single_digit_step

    add al, '0'
    mov [buffer], al

    add dl, '0'
    mov [buffer + 1], dl

    mov byte [buffer_len], 2

    ret

single_digit_step:
    add dl, '0'
    mov [buffer], dl

    mov byte [buffer_len], 1

    ret 


