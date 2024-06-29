; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
save_registers:
    push ebx
    push esi
    push edi

    ;; recursive bsearch implementation goes here
get_interval_boundaries:
    ;; start index
    mov dword esi, [ebp + 8]
    ;; end index
    mov dword edi, [ebp + 12]

check_current_interval:
    cmp esi, edi
    jg element_not_found

check_middle_element:
    ;; start + end
    lea ebx, [esi + edi]
    ;; middle = (start + end) / 2
    shr ebx, 1
    ;; compare the middle element with the needle
    cmp edx, [ecx + ebx * 4]
    je element_found
    jg check_higher_half

check_lower_half:
    ;; set the end index of the lower half
    lea edi, [ebx - 1]
    ;; push the next function params: end, start
    push edi
    push esi
    jmp continue_recursion

check_higher_half:
    ;; set the start index of the higher half
    lea esi, [ebx + 1]
    ;; push the next function params: end, start
    push edi
    push esi
    jmp continue_recursion

element_found:
    ;; save the index of the needle in the array
    mov eax, ebx
    jmp restore_registers

element_not_found:
    ;; needle not found in the array
    mov dword eax, -1
    jmp restore_registers

continue_recursion:
    call binary_search
    ;; move back the stack pointer to discard params
    add esp, 8

    ;; restore the preserved registers
restore_registers:
    pop edi
    pop esi
    pop ebx

    leave
    ret
