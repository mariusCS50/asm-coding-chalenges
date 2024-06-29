; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    ;; create the new stack frame
    enter 0, 0
    ;; get the parantheses string
    mov esi, [ebp + 8]
    xor edx, edx
    mov dl, [esi]
    push edx
    inc esi
processing_parantheses:
    cmp esp, ebp
    je push_paranthesis

    mov edx, [esp]

check_round:
    cmp edx, '('
    jne check_square
    cmp byte [esi], ')'
    jne push_paranthesis
    pop edx
    jmp processing_parantheses_cond

check_square:
    cmp edx, '['
    jne check_curly
    cmp byte [esi], ']'
    jne push_paranthesis
    pop edx
    jmp processing_parantheses_cond

check_curly:
    cmp edx, '{'
    jne bad_parantheses
    cmp byte [esi], '}'
    jne push_paranthesis
    pop edx
    jmp processing_parantheses_cond

push_paranthesis:
    mov dl, [esi]
    push edx

processing_parantheses_cond:
    inc esi
    ;; check if we reached the end of the string
    cmp byte [esi], 0
    jnz processing_parantheses

    cmp esp, ebp
    jne bad_parantheses

good_parantheses:
    ;; save the result for good parantheses
    mov dword eax, 0
    jmp end

bad_parantheses:
    ;; save the result for bad parantheses
    mov dword eax, 1

end:
    leave
    ret
