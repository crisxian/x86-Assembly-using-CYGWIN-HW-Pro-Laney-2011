

;
; file: sub6-1b.asm
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
; To assemble- 
;assemble both files:
;link both files's .o files
; 	nasm -f elf hw6-1.asm
;	nasm -f elf hw6-1b.asm
; 	gcc -o hw6-1 hw6-1.o hw6-1b.o driver.c asm_io.o
; 	nasm -f elf hw6-1.asm; nasm -f elf hw6-1b.asm

segment .text
        global  _calc_factorial
;
; local variable:
;   sum at [ebp-4]
_calc_factorial:
        enter   4,0               ; allocate room for sum on stack
        push    ebx               ; IMPORTANT!

        mov     dword [ebp-4],0   ; sum = 0
        ;dump_stack 1, 2, 4        ; print out stack from ebp-8 to ebp+16
        mov     ecx, 1            ; ecx is i in pseudocode
		mov		eax, 1
for_loop:
        cmp     ecx, [ebp+12]      ; cmp i and n
        jnle    end_for           ; if not i <= n, quit

        imul    eax, ecx      ; sum += i
        inc     ecx
        jmp     short for_loop

end_for:
        mov     ebx, [ebp+8]  	; ebx = &product
		mov		[ebx], eax		; [product] = factorial stored in eax
		
        pop     ebx               ; restore ebx
        leave
        ret




