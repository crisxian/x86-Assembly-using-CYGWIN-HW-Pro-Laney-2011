

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
message		db    "Exponent Calculator", 10, 0
prompt1 	db    "Enter number: ", 0
prompt2 	db    "Enter exponent 0 or larger: ", 0
outmsg1 	db	  "The output is: ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;
num  	resd 1
exp 	resd 1



segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

		mov		eax, message
		call	print_string
		
		mov		eax, prompt1
		call	print_string
		call	read_int
		mov		[num], eax
		
		mov		eax, prompt2
		call	print_string
		call	read_int
		mov		[exp], eax
		
		mov		ebx, print_result
		jmp		power
	
	
	print_result:
		mov		ebx, eax
		mov		eax, outmsg1
		call	print_string
		mov		eax, ebx
		call	print_int
		
        popa
        mov     eax, 0            ; return back to C
        leave
        ret
; power subprogram 
power:
	mov		ecx, [exp]
	mov		eax, 1
	cmp		ecx, 0
	je		print_result
	
loop_start:
	imul	eax, [num]
	loop 	loop_start
	
	jmp		ebx

