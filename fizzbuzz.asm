%include 		"macros.inc"
extern 			print_string
extern 			args_init
extern 			get_argc
extern 			get_arg
extern 			atoi
extern 			itoa

section .data
	space 		db " "
	newline 	db 10

	error1 		db "No arg found, try fizzbuzz <NUMBER>", 10
	error1_len 	equ $ - error1

	error2 		db "Invalid number or 0, please enter a higher number", 10
	error2_len 	equ $ - error2

section .bss
	limit 		resb 4
	counter 	resb 4
	buffer 		resb 4
	buffer_len 	resb 1

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
	
	mov 		byte [limit], rax	
	mov 		byte [counter], 0

.fizzbuzz_loop:
	mov		eax, [counter]
	cmp 		eax, [limit]	
	ja 		.exit
	
	mov		rdi, [counter]
	mov 		rsi, 15
	call		.is_divisible
	cmp 		rax, 1
	je		.print_fizzbuzz
	
	mov		rdi, [counter]
	mov		rsi, 3
	call		.is_divisible
	cmp		rax, 1
	je		.print_fizz

	mov		rdi, [counter]
	mov		rsi, 5
	call		.is_divisible
	cmp		rax, 1
	je		.print_buzz
	
	mov		rdi, [counter]	
	call		itoa
	
	

.print_fizzbuzz:
	
	

.is_divisible:
	; args:
	;   rdi = dividend (number to check)
	;   rsi = divisor (number to divide by)
	; returns:
	;   rax = 1 if divisible, 0 if not divisible
	
	xor 		rax, rax
	xor 		rdx, rdx
	
	mov 		rax, rdi
	div		rsx

	cmp 		rdx, 0
	jmp		.divisible_true

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
