section .bss
    argc_value resq 1
    argv_base  resq 1

section .text
    global args_init
    global get_argc
    global get_argv
    global get_arg

; -------------------------------------------------
; args_init
; args:
;   rdi = original rsp from _start
; returns:
;   nothing
; -------------------------------------------------
args_init:
    mov rax, [rdi]              ; argc
    mov [rel argc_value], rax

    lea rax, [rdi + 8]          ; argv base
    mov [rel argv_base], rax

    ret

; -------------------------------------------------
; get_argc
; returns:
;   rax = argc
; -------------------------------------------------
get_argc:
    mov rax, [rel argc_value]
    ret

; -------------------------------------------------
; get_argv
; returns:
;   rax = argv base pointer
; -------------------------------------------------
get_argv:
    mov rax, [rel argv_base]
    ret

; -------------------------------------------------
; get_arg
; args:
;   rdi = argument index
;
; returns:
;   rax = pointer to argv[index]
;   rax = 0 if index does not exist
;
; example:
;   index 0 = program name
;   index 1 = first real argument
; -------------------------------------------------
get_arg:
    mov rax, [rel argc_value]
    cmp rdi, rax
    jae .not_found

    mov rax, [rel argv_base]
    mov rax, [rax + rdi * 8]
    ret

.not_found:
    xor rax, rax
    ret
