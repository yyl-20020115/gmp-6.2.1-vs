[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_hamdist
	
	;.def	__gmpn_hamdist
	;.scl	2
	;.type	32
	;.endef
__gmpn_hamdist:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8

	push	rbx
	push	rbp

	mov	r10, [rdi]
	xor	r10, [rsi]

	mov	r8d, edx
	and	r8d, 3

	xor	ecx, ecx
	db 0xf3,0x49,0x0f,0xb8,0xc2

	lea	r9, [rip + Ltab]
	;.byte 0x4c,0x8d,0x0d,0x00,0x00,0x00,0x00
	
	;.byte 0x4f,0x63,0x04,0x81
	movsx	r8, dword [r9 + r8 * 4]
	add	r8, r9
	jmp	r8


L3:
	mov	r10, [rdi + 8]
	mov	r11, [rdi + 16]
	xor	r10, [rsi + 8]
	xor	r11, [rsi + 16]
	xor	ebp, ebp
	sub	rdx, 4
	jle	Lx3
	mov	r8, [rdi + 24]
	mov	r9, [rdi + 32]
	add	rdi, 24
	add	rsi, 24
	jmp	Le3

L0:
	mov	r9, [rdi + 8]
	xor	r9, [rsi + 8]
	mov	r10, [rdi + 16]
	mov	r11, [rdi + 24]
	xor	ebx, ebx
	xor	r10, [rsi + 16]
	xor	r11, [rsi + 24]
	add	rdi, 32
	add	rsi, 32
	sub	rdx, 4
	jle	Lx4

	align 16, db 0x90
Ltop:
Le0:
	db 0xf3,0x49,0x0f,0xb8,0xe9
	mov	r8, [rdi]
	mov	r9, [rdi + 8]
	add	rax, rbx
Le3:
	db 0xf3,0x49,0x0f,0xb8,0xda
	xor	r8, [rsi]
	xor	r9, [rsi + 8]
	add	rcx, rbp
Le2:
	db 0xf3,0x49,0x0f,0xb8,0xeb
	mov	r10, [rdi + 16]
	mov	r11, [rdi + 24]
	add	rdi, 32
	add	rax, rbx
Le1:
	db 0xf3,0x49,0x0f,0xb8,0xd8
	xor	r10, [rsi + 16]
	xor	r11, [rsi + 24]
	add	rsi, 32
	add	rcx, rbp
	sub	rdx, 4
	jg	Ltop

Lx4:
	db 0xf3,0x49,0x0f,0xb8,0xe9
	add	rax, rbx
Lx3:
	db 0xf3,0x49,0x0f,0xb8,0xda
	add	rcx, rbp
	db 0xf3,0x49,0x0f,0xb8,0xeb
	add	rax, rbx
	add	rcx, rbp
Lx2:
	add	rax, rcx
Lx1:
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret

L2:
	mov	r11, [rdi + 8]
	xor	r11, [rsi + 8]
	sub	rdx, 2
	jle	Ln2
	mov	r8, [rdi + 16]
	mov	r9, [rdi + 24]
	xor	ebx, ebx
	xor	r8, [rsi + 16]
	xor	r9, [rsi + 24]
	add	rdi, 16
	add	rsi, 16
	jmp	Le2
Ln2:
	db 0xf3,0x49,0x0f,0xb8,0xcb
	jmp	Lx2

L1:
	dec	rdx
	jle	Lx1
	mov	r8, [rdi + 8]
	mov	r9, [rdi + 16]
	xor	r8, [rsi + 8]
	xor	r9, [rsi + 16]
	xor	ebp, ebp
	mov	r10, [rdi + 24]
	mov	r11, [rdi + 32]
	add	rdi, 40
	add	rsi, 8
	jmp	Le1

	
		section .rdata
	align 8, db 0x90
Ltab:
	dd L0-Ltab
	dd L1-Ltab
	dd L2-Ltab
	dd L3-Ltab
