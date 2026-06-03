section .bss
	buffer: resb 32 

section .text
	global print_string
	global print_number
; -------------------------------------------------
; print_string
; args:
;   rsi = string address 
;   rdx = string lenght
; returns:
;   rax = bytes written, or negative error code
; -------------------------------------------------
print_string:
	mov rax, 1      ; sys_write
	mov rdi, 1      ; stdout
	syscall

	ret


; -------------------------------------------------
; print_number
; args:
;	rdi = number to be printed
; returns:
;	rax = bytes writeten, or negative error code 
; -------------------------------------------------
print_number:
	test rdi, rdi
	jnz .not_zero	
	
	mov byte [buffer], '0'
	mov rsi, buffer
	mov rdx, 1
	jmp print_string

.not_zero:
	mov rax, rdi	
	xor r8, r8

.push_digits:
	xor rdx, rdx
	mov rcx, 10
	div rcx

	add dl, '0'
	push rdx
	
	inc r8
	test rax, rax
	jnz .push_digits

	mov rsi, buffer
	mov r9, rsi	

.pop_loop:
	pop rax
	mov [rsi], al
	inc rsi
	dec r8
	jnz .pop_loop

	mov rdx, rsi
	sub rdx, r9
	mov rsi, buffer
	jmp print_string	

