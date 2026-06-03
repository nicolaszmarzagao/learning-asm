section .data
    buffer db 21 dup(0) ; Buffer for string (max 20 digits + null)  

section .text
	global strlen
	global atoi
	global itoa

; -------------------------------------------------
; strlen
; args:
;   rdi = null-terminated string
; returns:
;   rax = string length
; -------------------------------------------------
strlen:
	xor rax, rax

.strlen_loop:
	cmp byte [rdi + rax], 0
	je .strlen_done

	inc rax
	jmp .strlen_loop

.strlen_done:
	ret

; -------------------------------------------------
; atoi "ASCII To Integer"
; args:
; 	rdi = null-terminated string
; returns:
; 	rax = integer value or 0 if nothing found
; -------------------------------------------------
atoi:
	xor rax, rax
	xor rcx, rcx

	mov r8b, 0  ; loop counter

.atoi_loop:
	movzx rcx, byte [rdi] ; load current char
	cmp rcx, 0
	je .atoi_done ; check if string has ended
	
	cmp rcx, '0'
	jb .atoi_done
	
	cmp rcx, '9'
	ja .atoi_done

	sub rcx, '0'
	
	imul rax, rax, 10 ; rax = rax * 10
	add rax, rcx
	
	inc rdi ; mov to next char
	jmp .atoi_loop

.atoi_done:
	ret	

; -------------------------------------------------
; itoa "Integer to ASCII"
; args:
; 	rdi = integer value
; returns:
; 	rax = null terminated string
; -------------------------------------------------
itoa:
	cmp rdi, 0
	je .itoa_zero_done

	push rsp
	mov rbp, rsp
	sub rsp, 32

	mov rax, rdi
	mov rcx, 10

	mov rdi, buffer	
	add rdi, 19 ; start at the end of the buffer	
	mov byte [rdi+1], 0 ; make sure we have a null at the end	

.itoa_loop:
	xor rdx, rdx
	div rcx

	add dl, '0'
	dec rdi
	mov [rdi], dl

	cmp rax, 0
	jne .itoa_loop

	mov rax, rdi
	
	mov rsp, rbp
	pop rbp
	ret	

.itoa_zero_done:
	mov rax, buffer
	mov byte [rax], '0'
	mov byte [rax+1], 0

	ret
	
