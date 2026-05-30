%macro exit 1
    mov rax, 60
    xor rdi, %1
    syscall
%endmacro
