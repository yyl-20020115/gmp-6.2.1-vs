[Bits 64]
	align 16, db 0x90
	global __gmpn_rshift
	
	;.def	__gmpn_rshift
	;.scl	2
	;.type	32
	;.endef
__gmpn_rshift:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9


	xor	eax, eax

	test	dl, 1
	jnz	Lbx1
Lbx0:
	test	dl, 2
	jnz	Lb10

Lb00:
	lea	rsi, [rsi + 8]
	lea	rdi, [rdi - 24]
	mov	r10, [rsi - 8]
	mov	r11, [rsi]
	shrd	rax, r10, cl
	mov	r8, [rsi + 8]
	shr	rdx, 2
	jmp	L00

Lbx1:
	test	dl, 2
	jnz	Lb11

Lb01:
	lea	rsi, [rsi + 16]
	lea	rdi, [rdi - 16]
	mov	r9, [rsi - 16]
	shrd	rax, r9, cl
	shr	rdx, 2
	jz	L1
	mov	r10, [rsi - 8]
	mov	r11, [rsi]
	jmp	L01

Lb10:
	lea	rsi, [rsi + 24]
	lea	rdi, [rdi - 8]
	mov	r8, [rsi - 24]
	mov	r9, [rsi - 16]
	shrd	rax, r8, cl
	shr	rdx, 2
	jz	L2
	mov	r10, [rsi - 8]
	jmp	L10

Lb11:
	lea	rsi, [rsi + 32]
	mov	r11, [rsi - 32]
	mov	r8, [rsi - 24]
	mov	r9, [rsi - 16]
	shrd	rax, r11, cl
	shr	rdx, 2
	jz	Lend

	align 16, db 0x90
Ltop:
	shrd	r11, r8, cl
	mov	r10, [rsi - 8]
	mov	[rdi], r11
L10:
	shrd	r8, r9, cl
	mov	r11, [rsi]
	mov	[rdi + 8], r8
L01:
	shrd	r9, r10, cl
	mov	r8, [rsi + 8]
	mov	[rdi + 16], r9
L00:
	shrd	r10, r11, cl
	mov	r9, [rsi + 16]
	add	rsi, 32
	mov	[rdi + 24], r10
	add	rdi, 32
	dec	rdx
	jnz	Ltop

Lend:
	shrd	r11, r8, cl
	mov	[rdi], r11
L2:
	shrd	r8, r9, cl
	mov	[rdi + 8], r8
L1:
	shr	r9, cl
	mov	[rdi + 16], r9
	pop	rsi
	pop	rdi
	ret
	
