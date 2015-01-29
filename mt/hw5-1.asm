

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
prompt1 	db    "Flipping odd bits and zeroing out even bits.", 10 ,"Enter number: ", 0
outmsg1 	db	  "The output is: ", 0	

segment .bss
;
; uninitialized data is put in the bss segment
;
input1  resd 1



segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

		
		
		mov		eax, prompt1
		call	print_string
		call	read_int
		
		mov		[input1], eax
		xor		eax, 0xFFFFFFFF
		and		eax, 0x55555555
		mov 	ebx, eax
		
		mov		eax, outmsg1
		call	print_string
		mov		eax, ebx
		call 	print_int
		
		
        popa
        mov     eax, 0            ; return back to C
        leave
        ret


