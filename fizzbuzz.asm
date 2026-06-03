%include "macros.inc"
extern print_string
extern args_init
extern get_argc
extern get_arg
extern print_number

section .data
	space db " "
	newline db 10

	error1 db "No arg found, try fizzbuzz <NUMBER>", 10
	error1_len equ $ - error1


section .bss
	counter resb 4
	buffer resb 4
	buffer_len resb 1

section .text
	global _start

_start:
	mov rdi, rsp
	call args_init

	call get_argc
	cmp rax, 1
	je no_arg_exit

	mov rdi, 1	
	call get_arg
	cmp rax, 0
	je no_arg_exit

	mov rsi, rax
	mov rdx, 6
	call print_string


	mov rsi, newline
	mov rdx, 1
	call print_string

	exit 0	

	;mov byte [counter], 20


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

no_arg_exit:
	mov rsi, error1
	mov rdx, error1_len
	call print_string

	exit 1

