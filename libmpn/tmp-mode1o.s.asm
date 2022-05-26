[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_modexact_1_odd
	extern __gmp_binvert_limb_table
	;.def	__gmpn_modexact_1_odd
	;.scl	2
	;.type	32
	;.endef
__gmpn_modexact_1_odd:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8

	mov	ecx, 0
	jmp	Lent

	global __gmpn_modexact_1c_odd
	
	;.def	__gmpn_modexact_1c_odd
	;.scl	2
	;.type	32
	;.endef
__gmpn_modexact_1c_odd:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

Lent:
	
	
	
	

	mov	r8, rdx
	shr	edx, 1

	;.byte 0x4c,0x8d,0x0d,0x00,0x00,0x00,0x00 
	lea	r9, [__gmp_binvert_limb_table]


	and	edx, 127
	mov	r10, rcx

	movzx	edx, byte [r9 + rdx]

	mov	rax, [rdi]
	lea	r11, [rdi + rsi * 8]
	mov	rdi, r8

	lea	ecx, [rdx + rdx]
	imul	edx, edx

	neg	rsi

	imul	edx, edi

	sub	ecx, edx

	lea	edx, [rcx + rcx]
	imul	ecx, ecx

	imul	ecx, edi

	sub	edx, ecx
	xor	ecx, ecx

	lea	r9, [rdx + rdx]
	imul	rdx, rdx

	imul	rdx, r8

	sub	r9, rdx
	mov	rdx, r10

	

	inc	rsi
	jz	Lone


	align 16, db 0x90
Ltop:
	
	
	
	
	
	
	
	

	sub	rax, rdx

	adc	rcx, 0
	imul	rax, r9

	mul	r8

	mov	rax, [r11 + rsi * 8]
	sub	rax, rcx
	setc	cl

	inc	rsi
	jnz	Ltop


Lone:
	sub	rax, rdx

	adc	rcx, 0
	imul	rax, r9

	mul	r8

	lea	rax, [rcx + rdx]
	pop	rsi
	pop	rdi
	ret

	
	
