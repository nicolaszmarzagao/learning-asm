section .text
    global print_string
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
