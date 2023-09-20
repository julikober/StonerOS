	[bits 16]
print_string16:               ; dx = string
	mov si, dx
	mov ah, 0x0e
.loop:
	lodsb
	cmp al, 0
	je .done
	int 0x10
	jmp .loop
.done:
	ret
	
print_hex16:                  ; dx = number, cx = number of bytes
	push dx
	mov dx, hex_prefix
	call print_string16
	
	pop dx
	imul cx, 8
	mov ah, 0x0e
	
.loop:
	push dx
	sub cl, 4
	shr dx, cl
	and dx, 0xf
	
	mov bx, chars
	add bx, dx
	
	mov al, [bx]
	int 0x10
	
	pop dx
	
	cmp cl, 0
	jg .loop
	ret
	
hex_prefix: db '0x', 0
chars: db '0123456789abcdef'
	
	[bits 32]
	
print_string32:               ; esi = string
	mov si, dx
	mov ebx, 0xb8000
	mov ah, 0x0f
.loop:
	lodsb
	cmp al, 0
	je .done
	mov word [ebx], ax
	add ebx, 2
	jmp .loop
.done:
	ret
