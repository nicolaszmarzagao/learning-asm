section .text
    global strlen

; -------------------------------------------------
; strlen
; args:
;   rdi = null-terminated string
; returns:
;   rax = string length
; -------------------------------------------------
strlen:
    xor rax, rax

.loop:
    cmp byte [rdi + rax], 0
    je .done

    inc rax
    jmp .loop

.done:
    ret
