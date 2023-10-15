load_disk:                    ; dx = disk number, al = number of sectors to read
	push dx
	
	mov ah, 0x02                 ; read disk
	mov al, dh                   ; number of sectors to read
	mov ch, 0x00                 ; cylinder number
	mov dh, 0x00                 ; head number
	mov cl, 0x02                 ; sector number
	
	int 0x13
	
	jc disk_error
	
	pop dx
	cmp dh, al
	jne disk_error
	ret
	
disk_error:
	mov dx, DISK_ERROR_MSG
	; call print_string16
	jmp $
	
DISK_ERROR_MSG: db "Disk read error!", 0
