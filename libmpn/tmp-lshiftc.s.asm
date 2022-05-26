[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_lshiftc
	
	;.def	__gmpn_lshiftc
	;.scl	2
	;.type	32
	;.endef
__gmpn_lshiftc:

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
	lea	rsi, [rsi + rdx * 8 - 8]
	lea	rdi, [rdi + rdx * 8 + 16]
	mov	r10, [rsi]
	mov	r11, [rsi - 8]
	shld	rax, r10, cl
	mov	r8, [rsi - 16]
	shr	rdx, 2
	shld	r10, r11, cl
	jmp	L00

Lbx1:
	test	dl, 2
	jnz	Lb11

Lb01:
	lea	rsi, [rsi + rdx * 8 - 16]
	lea	rdi, [rdi + rdx * 8 + 8]
	mov	r9, [rsi + 8]
	shld	rax, r9, cl
	shr	rdx, 2
	jz	L1
	mov	r10, [rsi]
	mov	r11, [rsi - 8]
	shld	r9, r10, cl
	jmp	L01

Lb10:
	lea	rsi, [rsi + rdx * 8 - 24]
	lea	rdi, [rdi + rdx * 8]
	mov	r8, [rsi + 16]
	mov	r9, [rsi + 8]
	shld	rax, r8, cl
	shr	rdx, 2
	jz	L2
	mov	r10, [rsi]
	shld	r8, r9, cl
	jmp	L10

	align 16, db 0x90
Lb11:
	lea	rsi, [rsi + rdx * 8 - 32]
	lea	rdi, [rdi + rdx * 8 - 8]
	mov	r11, [rsi + 24]
	mov	r8, [rsi + 16]
	mov	r9, [rsi + 8]
	shld	rax, r11, cl
	shr	rdx, 2
	jz	Lend

	align 16, db 0x90
Ltop:
	shld	r11, r8, cl
	mov	r10, [rsi]
	not	r11
	shld	r8, r9, cl
	mov	[rdi], r11
L10:
	mov	r11, [rsi - 8]
	not	r8
	shld	r9, r10, cl
	mov	[rdi - 8], r8
L01:
	mov	r8, [rsi - 16]
	not	r9
	shld	r10, r11, cl
	mov	[rdi - 16], r9
L00:
	mov	r9, [rsi - 24]
	not	r10
	add	rsi, -32
	mov	[rdi - 24], r10
	add	rdi, -32
	dec	rdx
	jnz	Ltop

Lend:
	shld	r11, r8, cl
	not	r11
	mov	[rdi], r11
L2:
	shld	r8, r9, cl
	not	r8
	mov	[rdi - 8], r8
L1:
	shl	r9, cl
	not	r9
	mov	[rdi - 16], r9
	pop	rsi
	pop	rdi
	ret
	
