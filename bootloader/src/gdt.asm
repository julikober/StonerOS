GDT_Start:                    ; GDT start address
null_descriptor:              ; Null descriptor
	dd 0
	dd 0                         ; 8 bytes of zeros
code_descriptor:              ; Code segment descriptor
	dw 0xffff                    ; Limit (0 - 15)
	dw 0                         ; Base (0 - 15)
	db 0                         ; Base (16 - 23)
	db 10011010b                 ; 1st flags, type flags
	db 11001111b                 ; 2nd flags, limit (16 - 19)
	db 0                         ; Base (24 - 31)
	
data_descriptor:              ; Data segment descriptor
	dw 0xffff                    ; Limit (0 - 15)
	dw 0                         ; Base (0 - 15)
	db 0                         ; Base (16 - 23)
	db 10010010b                 ; 1st flags, type flags
	db 11001111b                 ; 2nd flags, limit (16 - 19)
	db 0                         ; Base (24 - 31)
	
GDT_End:
GDT_Descriptor:
	dw GDT_End - GDT_Start - 1   ; GDT size
	dd GDT_Start                 ; GDT start address
	
	CODE_SEG equ code_descriptor - GDT_Start ; Address of code segment
	DATA_SEG equ data_descriptor - GDT_Start ; Address of data segment
