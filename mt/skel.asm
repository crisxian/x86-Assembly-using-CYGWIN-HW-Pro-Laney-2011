

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
prompt1 	db    "Enter :", 0
outmsg1 	db	  "The output is ", 0

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

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;

        popa
        mov     eax, 0            ; return back to C
        leave
        ret


