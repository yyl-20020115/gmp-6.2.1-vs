[Bits 64]
	align 32, db 0x90
	global __gmpn_redc_1
	extern __gmpn_add_n
	;.def	__gmpn_redc_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_redc_1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rsp + 56]
	push	rbx
	push	rbp
	push	r12
	push	r13
	push	r14
	push	r15

	mov	r13, [rsi]
	mov	r15, rcx
	lea	r12, [rdx + rcx * 8]
	lea	rsi, [rsi + rcx * 8]
	neg	rcx
	imul	r13, r8

	test	cl, 1
	jz	Lbx0

Lbx1:
	test	cl, 2
	jz	Lb3

Lb1:
	cmp	ecx, -1
	jz	Ln1

Lotp1:
lea	r14, [rcx + 3]
	mov	rax, [r12 + rcx * 8]
	mov	rbp, [rsi + rcx * 8]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + rcx * 8 + 8]
	adc	r9, rdx
	mul	r13
	mov	r11d, 0
	mov	rbx, [rsi + rcx * 8 + 8]
	add	rbx, rax
	mov	rax, [r12 + rcx * 8 + 16]
	adc	r11, rdx
	add	rbx, r9
	adc	r11, 0
	mov	rbp, [rsi + rcx * 8 + 16]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + rcx * 8 + 24]
	adc	r9, rdx
	mov	[rsi + rcx * 8 + 8], rbx
	imul	rbx, r8
	jmp	Le1

	align 16, db 0x90
Ltp1:
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8 - 16]
	adc	r9, rdx
	mul	r13
	add	rbp, r11
	mov	r11d, 0
	mov	r10, [rsi + r14 * 8 - 16]
	adc	r9, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 - 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 24], rbp
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 - 8]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8]
	adc	r9, rdx
	mov	[rsi + r14 * 8 - 16], r10
Le1:
	add	rbp, r11
	adc	r9, 0
	mul	r13
	mov	r10, [rsi + r14 * 8]
	mov	r11d, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 + 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 8], rbp
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 + 8]
	mov	[rsi + r14 * 8], r10
	add	r14, 4
	jnc	Ltp1

Led1:
	mul	r13
	add	rbp, rax
	adc	rdx, 0
	add	rbp, r11
	adc	rdx, 0
	mov	[rsi - 8], rbp
	mov	[rsi + rcx * 8], rdx
	mov	r13, rbx
	lea	rsi, [rsi + 8]
	dec	r15
	jnz	Lotp1
	jmp	Lcj

Lb3:
	cmp	ecx, -3
	jz	Ln3

Lotp3:
lea	r14, [rcx + 5]
	mov	rax, [r12 + rcx * 8]
	mov	rbp, [rsi + rcx * 8]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + rcx * 8 + 8]
	adc	r9, rdx
	mul	r13
	mov	rbx, [rsi + rcx * 8 + 8]
	mov	r11d, 0
	add	rbx, rax
	mov	rax, [r12 + rcx * 8 + 16]
	adc	r11, rdx
	add	rbx, r9
	adc	r11, 0
	mov	rbp, [rsi + rcx * 8 + 16]
	mov	[rsi + rcx * 8 + 8], rbx
	imul	rbx, r8


	align 16, db 0x90
Ltp3:
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8 - 16]
	adc	r9, rdx
	mul	r13
	add	rbp, r11
	mov	r11d, 0
	mov	r10, [rsi + r14 * 8 - 16]
	adc	r9, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 - 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 24], rbp
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 - 8]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8]
	adc	r9, rdx
	mov	[rsi + r14 * 8 - 16], r10
	add	rbp, r11
	adc	r9, 0
	mul	r13
	mov	r10, [rsi + r14 * 8]
	mov	r11d, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 + 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 8], rbp
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 + 8]
	mov	[rsi + r14 * 8], r10
	add	r14, 4
	jnc	Ltp3

Led3:
	mul	r13
	add	rbp, rax
	adc	rdx, 0
	add	rbp, r11
	adc	rdx, 0
	mov	[rsi - 8], rbp
	mov	[rsi + rcx * 8], rdx
	mov	r13, rbx
	lea	rsi, [rsi + 8]
	dec	r15
	jnz	Lotp3


Lcj:
	

	lea	rdx, [rsi + rcx * 8]
	lea	r8, [rdx + rcx * 8]
	neg	ecx
	mov	r9, rcx
	mov	rcx, rdi


	sub	rsp, 40
	
	call	__gmpn_add_n

	add	rsp, 40

Lret:
	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret

Lbx0:
	test	cl, 2
	jnz	Lb2

Lb0:
Lotp0:
lea	r14, [rcx + 2]
	mov	rax, [r12 + rcx * 8]
	mul	r13
	mov	r11d, 0
	mov	r10, [rsi + rcx * 8]
	add	r10, rax
	mov	rax, [r12 + rcx * 8 + 8]
	adc	r11, rdx
	mov	rbx, [rsi + rcx * 8 + 8]
	mul	r13
	add	rbx, rax
	mov	r9d, 0
	mov	rax, [r12 + rcx * 8 + 16]
	adc	r9, rdx
	add	rbx, r11
	adc	r9, 0
	mul	r13
	mov	r10, [rsi + rcx * 8 + 16]
	mov	r11d, 0
	add	r10, rax
	mov	rax, [r12 + rcx * 8 + 24]
	adc	r11, rdx
	mov	[rsi + rcx * 8 + 8], rbx
	imul	rbx, r8
	jmp	Le0

	align 16, db 0x90
Ltp0:
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8 - 16]
	adc	r9, rdx
	mul	r13
	add	rbp, r11
	mov	r11d, 0
	mov	r10, [rsi + r14 * 8 - 16]
	adc	r9, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 - 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 24], rbp
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 - 8]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8]
	adc	r9, rdx
	mov	[rsi + r14 * 8 - 16], r10
	add	rbp, r11
	adc	r9, 0
	mul	r13
	mov	r10, [rsi + r14 * 8]
	mov	r11d, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 + 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 8], rbp
Le0:
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 + 8]
	mov	[rsi + r14 * 8], r10
	add	r14, 4
	jnc	Ltp0

Led0:
	mul	r13
	add	rbp, rax
	adc	rdx, 0
	add	rbp, r11
	adc	rdx, 0
	mov	[rsi - 8], rbp
	mov	[rsi + rcx * 8], rdx
	mov	r13, rbx
	lea	rsi, [rsi + 8]
	dec	r15
	jnz	Lotp0
	jmp	Lcj

Lb2:
	cmp	ecx, -2
	jz	Ln2

Lotp2:
lea	r14, [rcx + 4]
	mov	rax, [r12 + rcx * 8]
	mul	r13
	mov	r10, [rsi + rcx * 8]
	mov	r11d, 0
	add	r10, rax
	mov	rax, [r12 + rcx * 8 + 8]
	adc	r11, rdx
	mov	rbx, [rsi + rcx * 8 + 8]
	mul	r13
	add	rbx, rax
	mov	r9d, 0
	mov	rax, [r12 + rcx * 8 + 16]
	adc	r9, rdx
	mul	r13
	add	rbx, r11
	mov	r11d, 0
	mov	r10, [rsi + rcx * 8 + 16]
	adc	r9, 0
	add	r10, rax
	mov	rax, [r12 + rcx * 8 + 24]
	adc	r11, rdx
	mov	[rsi + rcx * 8 + 8], rbx
	imul	rbx, r8
	jmp	Le2

	align 16, db 0x90
Ltp2:
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8 - 16]
	adc	r9, rdx
	mul	r13
	add	rbp, r11
	mov	r11d, 0
	mov	r10, [rsi + r14 * 8 - 16]
	adc	r9, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 - 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 24], rbp
Le2:
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 - 8]
	mul	r13
	add	rbp, rax
	mov	r9d, 0
	mov	rax, [r12 + r14 * 8]
	adc	r9, rdx
	mov	[rsi + r14 * 8 - 16], r10
	add	rbp, r11
	adc	r9, 0
	mul	r13
	mov	r10, [rsi + r14 * 8]
	mov	r11d, 0
	add	r10, rax
	mov	rax, [r12 + r14 * 8 + 8]
	adc	r11, rdx
	mov	[rsi + r14 * 8 - 8], rbp
	add	r10, r9
	adc	r11, 0
	mov	rbp, [rsi + r14 * 8 + 8]
	mov	[rsi + r14 * 8], r10
	add	r14, 4
	jnc	Ltp2

Led2:
	mul	r13
	add	rbp, rax
	adc	rdx, 0
	add	rbp, r11
	adc	rdx, 0
	mov	[rsi - 8], rbp
	mov	[rsi + rcx * 8], rdx
	mov	r13, rbx
	lea	rsi, [rsi + 8]
	dec	r15
	jnz	Lotp2
	jmp	Lcj

Ln1:
	mov	rax, [rdx]
	mul	r13
	add	rax, [rsi - 8]
	adc	rdx, [rsi]
	mov	[rdi], rdx
	mov	eax, 0
	adc	eax, eax
	jmp	Lret

Ln2:
	mov	rax, [rdx]
	mov	rbp, [rsi - 16]
	mul	r13
	add	rbp, rax
	mov	r9, rdx
	adc	r9, 0
	mov	rax, [r12 - 8]
	mov	r10, [rsi - 8]
	mul	r13
	add	r10, rax
	mov	r11, rdx
	adc	r11, 0
	add	r10, r9
	adc	r11, 0
	mov	r13, r10
	imul	r13, r8
	mov	rax, [r12 - 16]
	mul	r13
	add	r10, rax
	mov	r9, rdx
	adc	r9, 0
	mov	rax, [r12 - 8]
	mov	r14, [rsi]
	mul	r13
	add	r14, rax
	adc	rdx, 0
	add	r14, r9
	adc	rdx, 0
	xor	eax, eax
	add	r14, r11
	adc	rdx, [rsi + 8]
	mov	[rdi], r14
	mov	[rdi + 8], rdx
	adc	eax, eax
	jmp	Lret

	align 16, db 0x90
Ln3:
	mov	rax, [r12 - 24]
	mov	r10, [rsi - 24]
	mul	r13
	add	r10, rax
	mov	rax, [r12 - 16]
	mov	r11, rdx
	adc	r11, 0
	mov	rbp, [rsi - 16]
	mul	r13
	add	rbp, rax
	mov	r9, rdx
	adc	r9, 0
	mov	rax, [r12 - 8]
	add	rbp, r11
	mov	r10, [rsi - 8]
	adc	r9, 0
	mul	r13
	mov	r13, rbp
	imul	r13, r8
	add	r10, rax
	mov	r11, rdx
	adc	r11, 0
	mov	[rsi - 16], rbp
	add	r10, r9
	adc	r11, 0
	mov	[rsi - 8], r10
	mov	[rsi - 24], r11
	lea	rsi, [rsi + 8]
	dec	r15
	jnz	Ln3

	mov	rdx, [rsi - 48]
	mov	rbx, [rsi - 40]
	xor	eax, eax
	add	rdx, rbp
	adc	rbx, r10
	adc	r11, [rsi - 8]
	mov	[rdi], rdx
	mov	[rdi + 8], rbx
	mov	[rdi + 16], r11
	adc	eax, eax
	jmp	Lret
	

