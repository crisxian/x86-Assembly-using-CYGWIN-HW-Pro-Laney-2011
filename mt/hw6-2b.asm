

;
; file: sub6-2b.asm
; Subprogram to C interfacing example

%include "asm_io.inc"

; subroutine _calc_factorial
; finds the product of the integers 1 through n
; Parameters:
;   n    - what to product up to (at [ebp + 8])
;   sump - pointer to int to store product into (at [ebp + 12])
; pseudo C code:
 ; void calc_product (int n, int * product_ptr )
 ; {
	; int i, prod = 1;
	; for( i=1; i <= n; i++ )
		; prod *= i;

	; *product_ptr = prod;
     ; }

;


segment .text
        global  _calc_factorial
;
; local variable:
;   sum at [ebp-4]
_calc_factorial:
        enter   4,0               ; allocate room for sum on stack
        push    ebx               ; IMPORTANT!

        ;dump_stack 1, 2, 4        ; print out stack from ebp-8 to ebp+16
		
		cmp		1, [ebp+8]
        jl    end_recursion           ; if not i < n, quit
		
        mov     ecx, [ebp+8]     ; cmp i and n

        imul    eax, ecx      ; prod *= i
        inc     ecx
        jmp     short for_loop

end_recursion:
        mov     ebx, [ebp+12]  	; ebx = &product
		mov		[ebx], eax		; [product] = factorial stored in eax
		
        pop     ebx               ; restore ebx
        leave
        ret




