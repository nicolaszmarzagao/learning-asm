section .data
    phrase1 db "bottles of beer on the wall", 10
    phrase1_len equ $ - phrase1

    phrase2 db "bottles of beer", 10
    phrase2_len equ $ - phrase2

    phrase3 db "Take one down, pass it around", 10
    phrase3_len equ $ - phrase3

    space db " "


section .bss
    counter resb 4
    buffer resb 4
    buffer_len resb 1
    
section .text
    global _start

_start:
    mov byte [counter], 99 ; start at 99

beer_loop:

    ; convert_counter here
    call convert_counter

    mov rsi, buffer
    movzx rdx, byte [buffer_len]
    call print_string

    mov rsi, space
    mov rdx, 1
    call print_string

    mov rsi, phrase1
    mov rdx, phrase1_len
    call print_string
    
    mov rsi, buffer
    movzx rdx, byte [buffer_len]
    call print_string

    mov rsi, space
    mov rdx, 1
    call print_string

    mov rsi, phrase2
    mov rdx, phrase2_len
    call print_string

    mov rsi, phrase3
    mov rdx, phrase3_len
    call print_string

    dec byte [counter]
    cmp byte [counter], 0
    jg beer_loop

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

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



