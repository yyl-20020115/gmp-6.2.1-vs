[Bits 64]
	align 16, db 0x90
	global __gmpn_bdiv_q_1
	extern __gmp_binvert_limb_table
	;.def	__gmpn_bdiv_q_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_bdiv_q_1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	push	rbx

	mov	rax, rcx
	xor	ecx, ecx
	mov	r10, rdx

	bt	eax, 0
	jnc	Levn

Lodd:
	mov	rbx, rax
	shr	eax, 1
	and	eax, 127

	;.byte 0x48,0x8d,0x15,0x00,0x00,0x00,0x00

	lea	rdx, [rip + __gmp_binvert_limb_table]
	
	movzx	eax, byte [rdx + rax]

	mov	r11, rbx

	lea	edx, [rax + rax]
	imul	eax, eax
	imul	eax, ebx
	sub	edx, eax

	lea	eax, [rdx + rdx]
	imul	edx, edx
	imul	edx, ebx
	sub	eax, edx

	lea	r8, [rax + rax]
	imul	rax, rax
	imul	rax, rbx
	sub	r8, rax

	jmp	Lpi1

Levn:
	bsf	rcx, rax
	shr	rax, cl
	jmp	Lodd
	

	global __gmpn_pi1_bdiv_q_1
	
	;.def	__gmpn_pi1_bdiv_q_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_pi1_bdiv_q_1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rsp + 56]
	mov	r9, [rsp + 64]
	push	rbx

	mov	r11, rcx
	mov	r10, rdx
	mov	rcx, r9

Lpi1:
	mov	rax, [rsi]

	dec	r10
	jz	Lone

	lea	rsi, [rsi + r10 * 8 + 8]
	lea	rdi, [rdi + r10 * 8]
	neg	r10

	test	ecx, ecx
	jnz	Lunorm
	xor	ebx, ebx
	jmp	Lnent

	align 8, db 0x90
Lntop:
mul	r11
	mov	rax, [rsi + r10 * 8 - 8]
	sub	rax, rbx
	setc	bl
	sub	rax, rdx
	adc	ebx, 0
Lnent:
imul	rax, r8
	mov	[rdi + r10 * 8], rax
	inc	r10
	jnz	Lntop

	mov	r9, [rsi - 8]
	jmp	Lcom

Lunorm:
	mov	r9, [rsi + r10 * 8]
	shr	rax, cl
	neg	ecx
	shl	r9, cl
	neg	ecx
	or	rax, r9
	xor	ebx, ebx
	jmp	Luent

	align 8, db 0x90
Lutop:
mul	r11
	mov	rax, [rsi + r10 * 8]
	shl	rax, cl
	neg	ecx
	or	rax, r9
	sub	rax, rbx
	setc	bl
	sub	rax, rdx
	adc	ebx, 0
Luent:
imul	rax, r8
	mov	r9, [rsi + r10 * 8]
	shr	r9, cl
	neg	ecx
	mov	[rdi + r10 * 8], rax
	inc	r10
	jnz	Lutop

Lcom:
	mul	r11
	sub	r9, rbx
	sub	r9, rdx
	imul	r9, r8
	mov	[rdi], r9
	pop	rbx
	pop	rsi
	pop	rdi
	ret

Lone:
	shr	rax, cl
	imul	rax, r8
	mov	[rdi], rax
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	
