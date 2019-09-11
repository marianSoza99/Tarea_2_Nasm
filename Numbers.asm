%include "io.mac"

.DATA
    number_prompt   db  "Please type your number: ",0
    out_msg         db  "Your number is: ",0
    invalid_msg		db	"Invalid number",0
    banderita 		db 	"Wenas",0
    
.UDATA
in_number             resb 13
variable 			  resb 34


.CODE
    .STARTUP
    PutStr  number_prompt     ; request number in string
    GetStr  in_number,13  		 

    mov     EBX,in_number
    mov 	ESI,0     		;Check sign
    mov 	EDI,0  			;Check dot
    mov 	ECX,0  			;Result
    push  	1
    mov 	EBP,0

 process_beg:
    mov    	AL,[EBX]        ; move the char to AL
    cmp     AL,0           ; if it is the NULL
    je      done
    cmp 	AL,45
    je		negative_sgn
    cmp 	AL,43
    je 		validate_numb
    cmp 	AL,48
    jb 		invalid_numb
    cmp 	AL,57
    ja  	invalid_numb
    inc 	EBX
    inc 	EBP

 validate_numb:
 	mov    	AL,[EBX]
 	cmp     AL,0          	 ; if it is the NULL
    je     	pre_convert   	 ;salir
    cmp  	AL,46
    je 		float_point
 	cmp 	AL,48
    jb 		invalid_numb
    cmp 	AL,57
    ja  	invalid_numb
    inc 	EBX
    inc 	EBP
    jmp 	validate_numb

pre_convert:
	cmp 	EDI,1
	dec 	EBX
	;dec 	EBP
	je 		convert_fl
	mov 	EDI,1    	 	;exponente
	mov 	EDX,10
	jmp 	convert_int

convert_int:
	mov 	EAX, 0
	mov 	AL,[EBX]
	sub 	AL,'0'
	mov 	EDX,EDI
	mul 	EDX	

	add 	ECX,EAX	
	mov 	EAX,EDI
	mov 	EDX,10
	mul 	EDX
	mov 	EDI,EAX
	cmp 	EBP,1
	je 		print_res
	dec 	EBX
	dec 	EBP
	jmp 	convert_int

convert_fl:

	jmp 	done

float_point:
	inc 	EDI
	inc 	EBX
	mov    	AL,[EBX]
 	cmp 	AL,48
    jb 		invalid_numb
    cmp 	AL,57
    ja  	invalid_numb
	jmp 	validate_numb

print_res:
	cmp 	ESI, 1
	je 		c2
	mov 	[variable],ECX
	PutLInt	[variable]
	nwln
	jmp done

c2:
	not ECX
	inc ECX
	mov 	[variable],ECX
	PutLInt	[variable]
	nwln
	jmp done

 negative_sgn:
 	mov 	ESI,1
 	inc 	EBX
 	mov    	AL,[EBX]
 	cmp 	AL,48
    jb 		invalid_numb
    cmp 	AL,57
    ja  	invalid_numb
 	jmp 	validate_numb

 invalid_numb:
	PutStr	invalid_msg
	jmp 	done

done:
    nwln
    .EXIT

to_end:
	inc 	EBX
	cmp     AL,0          	 ; if it is the NULL
    jne     to_end  
    dec 	EBX
    mov 	AL,[EBX]
    ret 	;AL



