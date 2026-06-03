section .text
	global strlen
	global atoi

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

	sub rcx, '0'
	
	imul rax, rax, 10 ; rax = rax * 10
	add rax, rcx
	
	inc rdi ; mov to next char
	jmp .atoi_loop

.atoi_done:
	ret	
