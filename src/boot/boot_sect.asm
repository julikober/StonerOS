	[org 0x7c00]
	KERNEL_OFFSET equ 0x5000
	
	mov [BOOT_DRIVE], dl
	mov bp, 0x9000
	mov sp, bp

	; clear screen
	mov ax, 0x3
	int 0x10
	
	call load_kernel
	call switch_to_pm
	[bits 32]
	mov esp, 0x90000
	mov ebp, esp                 ; set stack pointer to 0x90000
	call check_cpuid
	call check_lm
	call enable_pae
	call switch_to_lm
	NoCPUID:
	NoLongMode:
	
	; call main                    ; call main function
	
	jmp $
	
	%include "disk_tools.asm"
	%include "print_tools.asm"
	%include "gdt.asm"
	%include "pm.asm"
	%include "lm.asm"
	
	[bits 16]
load_kernel:
	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call load_disk
	ret
	
	[bits 32]
main:
	
	call KERNEL_OFFSET
	
	jmp $
	
	; Global Variables
BOOT_DRIVE: db 0
	
	times 510 - ($ - $$) db 0
	dw 0xaa55
