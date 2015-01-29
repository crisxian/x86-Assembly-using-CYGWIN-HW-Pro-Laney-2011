

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
prompt1 db    "Enter number to factorial: ", 0
outmsg1 db	  "The factorial is ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;
input1  resd 1
input2 	resd 1

segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

; factorial (n!) = n * n-1 * n-2 * ... * 1
; input N
; while (n) {
;	--n;
;	N * n
; }

	mov 	eax, prompt1
	call 	print_string
	call	read_int
	mov		[input1], eax
	mov		ebx, 1
	mov		ecx, [input1]
	
loop_start:
	imul	ebx, ecx 
	loop 	loop_start

	mov		eax, outmsg1
	call	print_string
	mov		eax, ebx
	call	print_int	

; Prime finder

	cdq                     ; initialize edx for remainder	
while:
	mov		eax, prompt2 	; db 	"Enter a number to check if it is a prime: "
	call	print_string
	call	read_int
	
	cmp		eax, 0			; jumpleft if less negative
	jl		endwhile
	
	mov		[input2], eax

	mov		ecx, [input2]
	dec		ecx
	
	
loop_test:
	mov		eax, [input2]
	cmp		ecx, 1			; end condition, is prime
	je		is_prime
	
	idiv	ecx
	
	cmp		edx, 0			; end condition isn't prime, because has a factor
	je		is_notprime


	
	loop	loop_test
	
	; two possibilities
is_prime:
	mov		eax, outmsgP1	; db	"Your number is a prime"
	call	print_string
	jmp		next
is_notprime:
	mov		eax, outmsgP2	; db	"Your number is not a prime"
	call	print_string
next:
	jmp	while

endwhile:





        popa
        mov     eax, 0            ; return back to C
        leave
        ret
		
		
