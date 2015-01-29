

%include "asm_io.inc"



segment .text
        global  _fact
;

_fact:
        enter   0,0
        push ebx               	; IMPORTANT!

		; n is stored in ebp+8
        mov     eax, [ebp+8]  	; ecx = N

		; n <= 1 return
        cmp    eax, 1     		; compare i and n
        jbe    term_cond          ; if not i <= n, quit

		; n * (n-1)	
        dec     eax
		push 	eax	; push (n-1)
		
   		call	_fact		; _fact with fact(n-1)
		
		pop		ecx			; answer to ecx
		mul		dword [ebp+8]			;  ebp+8 *= n-1

		; &product is stored in ebp+12
        mov     ebx, [ebp+12]  	; ebx = &product
		mov		[ebx], eax
		jmp		end
term_cond:
		mov		eax, 1
end:
        pop ebx               ; restore all
        leave
        ret




