

;
; file: convertlength.asm
; This file is a skeleton that can be used to start assembly programs.
; To create executable:
; Using Linux and gcc:
; nasm -f elf convertlength.asm
; gcc -o convertlength convertlength.o driver.c asm_io.o

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
; These labels refer to strings used for output
;

promptyards db    "Enter a length of yards: ", 0       ; don't forget nul terminator
promptinches db    "Enter a length in inches: ", 0
outmsg1 db	  "You entered ", 0
outmsg2 db    " yd = ", 0
outmsg3 db    " ft = ", 0
outmsg4 db    " in", 0
outmsg5 db	  " inches = ", 0
outmsg6 db	  " ft ", 0

promptlow db 	"enter the lowest number: ", 0
prompthigh db 	"enter the highest number: ", 0
outmsgrange db 	"the sum of all the numbers in range[", 0
outmsgcomma db 	",", 0
outmsglast db 	"] is ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;
input1  resd 1
input2  resd 1


 

segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

;
; code is put in the text segment. Do not modify the code before this comment.


		; length conversion
		
		mov 	eax, promptyards
		call	print_string
		
		call	read_int
		mov		ebx, eax		; store input in ebx
		
		mov		eax, outmsg1
		call	print_string
		mov		eax, ebx		; redisplay input
		call	print_int
		
		mov		eax, outmsg2
		call	print_string
		imul	ebx, 3			; yds->ft
		mov		eax, ebx	
		call	print_int		; display ft
		
		mov		eax, outmsg3
		call	print_string
		imul	ebx, 12			; ft->inches
		mov		eax, ebx
		call	print_int		; display inches
		
		mov		eax, outmsg4
		call	print_string
		call 	print_nl
		
		mov 	eax, promptinches
		call	print_string
		
		call	read_int
		mov		ebx, eax		; store input in ebx
		
		mov		eax, outmsg1	; 'you entered'
		call	print_string
		
		mov		eax, ebx		
		call	print_int		; redisplay input
		
		mov		eax, outmsg5	; ' inches = '
		call	print_string

        cdq                     ; initialize edx by sign extension
		mov		eax, ebx
		mov		ecx, 12			; store divisor in register
		idiv	ecx				; inches->yds, eax/12
		call	print_int		; display yards
		mov		eax, outmsg6	; ' ft '
		call	print_string
		
		mov		eax, edx		; remainder of division stored in edx
		call	print_int
		mov		eax, outmsg4	; ' in '
		call 	print_string
		call	print_nl
		
		; compute the sum of values between two integers
		
		mov		eax, promptlow
		call	print_string
		call	read_int
		mov		[input1], eax
		
		mov		eax, prompthigh
		call	print_string
		call	read_int
		mov		[input2], eax
		
								; sum of range[low,high] = (low+high)*N / 2
		mov		eax, [input2]	; N is the difference of high and low + 1
		sub		eax, [input1]
		inc		eax
		mov		ebx, eax		; store difference in ebx
		
		mov		eax, [input1]	; add highest and lowest
		add		eax, [input2]
		imul	eax, ebx	; mul by N
		
		cdq
		mov		ecx, 2			; divide by 2 by storing in ecx
		idiv	ecx
		
		mov 	ebx, eax		; store sum in ebx

		mov		eax, outmsgrange
		call	print_string
		mov		eax, [input1]	; redisplay low
		call 	print_int
		mov		eax, outmsgcomma
		call	print_string	
		mov		eax, [input2]	; redisplay high
		call	print_int
		mov		eax, outmsglast
		call	print_string
		mov		eax, ebx		; display sum
		call	print_int
		call	print_nl
		
		
; Do not modify the code after this comment.
;

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


