%include 		"macros.inc"
extern 			print_string
extern 			args_init
extern 			get_argc
extern 			get_arg
extern 			atoi
extern 			itoa
extern 			strlen

section .data
	space 		db " "
	newline 	db 10

	error1 		db "No arg found, try fizzbuzz <NUMBER>", 10
	error1_len 	equ $ - error1

	error2 		db "Invalid number or 0, please enter a higher number", 10
	error2_len 	equ $ - error2

	fizz		db "Fizz", 10
	buzz		db "Buzz", 10
	msg_len		equ 5
	
	fizzbuzz	db "FizzBuzz", 10
	fizzbuzz_len	equ $ - fizzbuzz

section .bss
	limit 		resw 1
	counter 	resw 1

section .text
	global 		_start

_start:
	mov 		rdi, rsp
	call 		args_init

	call 		get_argc
	cmp 		rax, 1
	je 		.no_arg_exit

	mov 		rdi, 1	
	call 		get_arg
	cmp 		rax, 0
	je 		.no_arg_exit
	
	mov 		rdi, rax
	call 		atoi

	cmp 		rax, 0
	je 		.invalid_number_exit
	
	mov 		word [limit], ax	
	mov 		word [counter], 0

.fizzbuzz_loop:
	inc		word [counter]

	movzx		rax, word [counter]
	cmp 		ax, word [limit]	
	ja 		.exit
	
	movzx		rdi, word [counter]
	mov 		rsi, 15
	call		.is_divisible
	cmp 		rax, 1
	je		.print_fizzbuzz
	
	movzx		rdi, word [counter]
	mov		rsi, 3
	call		.is_divisible
	cmp		rax, 1
	je		.print_fizz

	movzx		rdi, word [counter]
	mov		rsi, 5
	call		.is_divisible
	cmp		rax, 1
	je		.print_buzz
	
	movzx		rdi, word [counter]	
	call		itoa
	push		rax
	
	mov 		rdi, rax
	call		strlen
	
	pop		rsi
	mov		rdx, rax
	call		print_string	

	mov		rsi, newline
	mov		rdx, 1
	call		print_string

	jmp		.fizzbuzz_loop
	

.print_fizzbuzz:
	mov 		rsi, fizzbuzz	
	mov		rdx, fizzbuzz_len
	call		print_string

	jmp 		.fizzbuzz_loop
	
.print_fizz:
	mov		rsi, fizz
	mov		rdx, msg_len
	call		print_string

	jmp 		.fizzbuzz_loop

.print_buzz:
	mov		rsi, buzz
	mov		rdx, msg_len
	call		print_string

	jmp 		.fizzbuzz_loop

.is_divisible:
	; args:
	;   rdi = dividend (number to check)
	;   rsi = divisor (number to divide by)
	; returns:
	;   rax = 1 if divisible, 0 if not divisible
	
	xor 		rax, rax
	xor 		rdx, rdx
	
	mov 		rax, rdi
	div		rsi

	cmp 		rdx, 0
	je		.divisible_true

	mov 		rax, 0
	ret	

.divisible_true:
	mov 		rax, 1
	ret	


.exit:
	exit 		0


.no_arg_exit:
	mov 		rsi, error1
	mov 		rdx, error1_len
	call 		print_string

	exit 		1

.invalid_number_exit:
	mov 		rsi, error2
	mov 		rdx, error2_len
	call 		print_string
	
	exit 		1
