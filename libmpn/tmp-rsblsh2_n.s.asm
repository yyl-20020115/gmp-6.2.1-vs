[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_rsblsh2_n
	
	;.def	__gmpn_rsblsh2_n
	;.scl	2
	;.type	32
	;.endef
__gmpn_rsblsh2_n:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	push	r12
	push	r13
	push	r14
	push	r15

	mov	r8, [rdx]
	lea	r12, [r8 * 4]
	shr	r8, 62

	mov	eax, ecx
	lea	rdi, [rdi + rcx * 8]
	lea	rsi, [rsi + rcx * 8]
	lea	rdx, [rdx + rcx * 8]
	neg	rcx
	and	al, 3
	je	Lb00
	cmp	al, 2
	jc	Lb01
	je	Lb10

Lb11:
	mov	r10, [rdx + rcx * 8 + 8]
	lea	r14, [r8 + r10 * 4]
	shr	r10, 62
	mov	r11, [rdx + rcx * 8 + 16]
	lea	r15, [r10 + r11 * 4]
	shr	r11, 62
	sub	r12, [rsi + rcx * 8]
	sbb	r14, [rsi + rcx * 8 + 8]
	sbb	r15, [rsi + rcx * 8 + 16]
	sbb	eax, eax
	mov	[rdi + rcx * 8], r12
	mov	[rdi + rcx * 8 + 8], r14
	mov	[rdi + rcx * 8 + 16], r15
	add	rcx, 3
	js	Ltop
	jmp	Lend

Lb01:
	mov	r11, r8
	sub	r12, [rsi + rcx * 8]
	sbb	eax, eax
	mov	[rdi + rcx * 8], r12
	add	rcx, 1
	js	Ltop
	jmp	Lend

Lb10:
	mov	r11, [rdx + rcx * 8 + 8]
	lea	r15, [r8 + r11 * 4]
	shr	r11, 62
	sub	r12, [rsi + rcx * 8]
	sbb	r15, [rsi + rcx * 8 + 8]
	sbb	eax, eax
	mov	[rdi + rcx * 8], r12
	mov	[rdi + rcx * 8 + 8], r15
	add	rcx, 2
	js	Ltop
	jmp	Lend

Lb00:
	mov	r9, [rdx + rcx * 8 + 8]
	mov	r10, [rdx + rcx * 8 + 16]
	jmp	Le00

	align 16, db 0x90
Ltop:
	mov	r10, [rdx + rcx * 8 + 16]
	mov	r8, [rdx + rcx * 8]
	mov	r9, [rdx + rcx * 8 + 8]
	lea	r12, [r11 + r8 * 4]
	shr	r8, 62
Le00:
	lea	r13, [r8 + r9 * 4]
	shr	r9, 62
	mov	r11, [rdx + rcx * 8 + 24]
	lea	r14, [r9 + r10 * 4]
	shr	r10, 62
	lea	r15, [r10 + r11 * 4]
	shr	r11, 62
	add	eax, eax
	sbb	r12, [rsi + rcx * 8]
	sbb	r13, [rsi + rcx * 8 + 8]
	sbb	r14, [rsi + rcx * 8 + 16]
	sbb	r15, [rsi + rcx * 8 + 24]
	mov	[rdi + rcx * 8], r12
	mov	[rdi + rcx * 8 + 8], r13
	mov	[rdi + rcx * 8 + 16], r14
	sbb	eax, eax
	mov	[rdi + rcx * 8 + 24], r15
	add	rcx, 4
	js	Ltop
Lend:


	add	eax, r11d
	movsx	rax, eax

	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rsi
	pop	rdi
	ret
	

