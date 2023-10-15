	[bits 16]
switch_to_pm:
	cli
	lgdt [GDT_Descriptor]
	
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax                 ; switch to protected mode
	
jmp CODE_SEG:init_pm
	
	[bits 32]
init_pm:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax                   ; set all segment registers to DATA_SEG
	
	ret
