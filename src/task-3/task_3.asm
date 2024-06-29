%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    ;; create the new stack frame
    push ebp
    mov ebp, esp

    ;; save the registers
save_registers:
    pusha

get_params:
    ;; current node
    mov esi, [ebp + 8]
    ;; function pointer to 'expand'
    mov edi, [ebp + 12]

check_visited:
    ;; check if current node is not visited
    cmp dword [visited + esi * 4], 0
    jne restore_registers
    ;; set the current node as visited
    mov dword [visited + esi * 4], 1

print_node:
    push esi
    push fmt_str
    call printf
    ;; move back the stack pointer to discard printf params
    add esp, 8

call_expand:
    push esi
    call edi
    pop esi

select_structure_data:
    xor ecx, ecx
    ;; edx is the list of neighbours
    mov edx, [eax + 4]
    jmp loop_cond

visit_current_node_neighbours:
    ;; push the function pointer for 'expand'
    push edi
    ;; push the neighbour node
    push dword [edx + ecx * 4]
    call dfs
    ;; move back the stack pointer to discard params
    add esp, 8
    inc ecx

loop_cond:
    ;; compare iterator with the len of neighbours list
    cmp ecx, [eax]
    jne visit_current_node_neighbours

    ;; restore the  registers
restore_registers:
    popa

    leave
    ret
