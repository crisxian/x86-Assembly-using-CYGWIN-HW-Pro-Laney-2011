

;
; file: hw6-1.asm

%include "asm_io.inc"
segment .data

; To assemble- 
;assemble both files:
;link both files's .o files
; 	nasm -f elf hw6-1.asm
;	nasm -f elf hw6-1b.asm
; 	gcc -o hw6-1 hw6-1.o hw6-1b.o driver.c asm_io.o
; 	nasm -f elf hw6-1.asm; nasm -f elf hw6-1b.asm
;
; initialized data is put in the data segment here
;
prompt1 	db    "Enter a positive number: ", 0
outmsg1 	db	  "The product is ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;
input  resd 1
product resd 1


segment .text
        global  _asm_main
		extern	_calc_factorial
		
_asm_main:
        enter   0,0               ; setup routine
        pusha

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;
		mov		eax, prompt1	; prompt1
		call	print_string
		call	read_int		; ask for a number
		
		mov		[input], eax
		
		push	dword [input]
		push	dword product
		
		call	_calc_factorial
		add		esp, 8			; remove input and &product
		
		mov		eax, outmsg1	; print output
		call	print_string
		mov		eax, [product]
		call	print_int
		
        popa
        mov     eax, 0            ; return back to C
        leave
        ret


