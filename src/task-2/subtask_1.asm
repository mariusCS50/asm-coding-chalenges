; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
save_registers:
    push ebx
    push esi
    push edi

    ;; recursive qsort implementation goes here
get_function_params:
    ;; adress of the array
    mov eax, [ebp + 8]
    ;; start index
    mov esi, [ebp + 12]
    ;; end index
    mov edi, [ebp + 16]

check_current_interval:
    cmp esi, edi
    jge restore_registers

sort_elems_around_pivot:
    ;; set the pivot as the last element
    mov ebx, [eax + edi * 4]
    ;; the array index which is used to loop
    mov ecx, esi 
    ;; index of element to swap with
    mov edx, esi 

check_higher_lower:
    ;; compare the current element with the pivot
    cmp [eax + ecx * 4], ebx
    jg check_loop_cond

swap_elems:
    ;; push the first element
    push dword [eax + ecx * 4]
    ;; push the second element
    push dword [eax + edx * 4]
    ;; pop the second element value in first element
    pop dword [eax + ecx * 4]
    ;; pop the fisrt element value in second element
    pop dword [eax + edx * 4]
    inc edx

check_loop_cond:
    inc ecx
    cmp ecx, edi
    jne check_higher_lower

set_final_pivot_position:
    ;; push the pivot
    push dword [eax + edi * 4]
    ;; push the first element greater than pivot
    push dword [eax + edx * 4]
    ;; pop the greater element at the end of the array
    pop dword [eax + edi * 4]
    ;; pop the pivot in it's correct position in the array
    pop dword [eax + edx * 4]

sort_lower_half:
    ;; set the end index of the lower half
    lea ebx, [edx - 1]
    ;; push the next function params: end, start, array
    push ebx
    push esi
    push eax
    call quick_sort
    ;; move back the stack pointer to discard params
    add esp, 12

sort_higher_half:
    ;; set the start index of the higher half
    lea ebx, [edx + 1]
    ;; push the next function params: end, start, array
    push edi
    push ebx
    push eax
    call quick_sort
    ;; move back the stack pointer to discard params
    add esp, 12

    ;; restore the preserved registers
restore_registers:
    pop edi
    pop esi
    pop ebx

    leave
    ret