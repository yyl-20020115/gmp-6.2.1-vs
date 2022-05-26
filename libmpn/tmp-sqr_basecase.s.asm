[Bits 64]
	align 32, db 0x90
	global __gmpn_sqr_basecase
	
	;.def	__gmpn_sqr_basecase
	;.scl	2
	;.type	32
	;.endef
__gmpn_sqr_basecase:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8


	cmp	rdx, 4
	jl	Lsmall

	push	rbx
	push	rbp
	push	r12
	push	r13
	push	r14

	mov	r10, [rsi]
	mov	rax, [rsi + 8]
	mov	r11, rax

	mov	r8d, 1
	sub	r8, rdx
	push	r8

	lea	rsi, [rsi + rdx * 8]
	lea	rdi, [rdi + rdx * 8]

	mul	r10

	test	r8b, 1
	jnz	Lbx1

Lbx0:
	test	r8b, 2
	mov	[rdi + r8 * 8], rax
	jnz	Lb10

Lb00:
	lea	r13, [r8]
	mov	rcx, rdx
	xor	ebp, ebp
	jmp	Lm2e0

Lb10:
	lea	r13, [r8 + 2]
	mov	rax, [rsi + r8 * 8 + 8]
	mov	r9, rdx
	xor	ebx, ebx
	xor	ecx, ecx
	jmp	Lm2e2

Lbx1:
	test	r8b, 2
	mov	[rdi + r8 * 8], rax
	jz	Lb11

Lb01:
	lea	r13, [r8 + 1]
	mov	rbx, rdx
	xor	ecx, ecx
	jmp	Lm2e1

Lb11:
	lea	r13, [r8 - 1]
	mov	rbp, rdx
	xor	r9d, r9d
	jmp	Lm2e3


	align 16, db 0x90
Lm2top1:
	mul	r10
	add	r9, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r9
	adc	rbx, rdx
	adc	ecx, 0
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
Lm2e1:
mov	ebp, 0
	mov	rax, [rsi + r13 * 8]
	mul	r10
	add	rbx, rax
	mov	[rdi + r13 * 8], rbx
	adc	rcx, rdx
	mov	rax, [rsi + r13 * 8]
	adc	ebp, 0
	mul	r11
	add	rcx, rax
	adc	rbp, rdx
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	mov	r9d, 0
	add	rcx, rax
	adc	rbp, rdx
	adc	r9d, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r11
	add	rbp, rax
	mov	[rdi + r13 * 8 + 8], rcx
	adc	r9, rdx
	mov	ebx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	rbp, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	r9, rdx
	adc	ebx, 0
	mul	r11
	mov	ecx, 0
	add	r9, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top1

	mul	r10
	add	r9, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r9
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rax, rbx
	adc	rdx, rcx
	mov	[rdi], rax
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2
	jmp	Lam2o3

	align 16, db 0x90
Lm2top3:
	mul	r10
	add	r9, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r9
	adc	rbx, rdx
	adc	ecx, 0
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	ebp, 0
	mov	rax, [rsi + r13 * 8]
	mul	r10
	add	rbx, rax
	mov	[rdi + r13 * 8], rbx
	adc	rcx, rdx
	mov	rax, [rsi + r13 * 8]
	adc	ebp, 0
	mul	r11
	add	rcx, rax
	adc	rbp, rdx
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	mov	r9d, 0
	add	rcx, rax
	adc	rbp, rdx
	adc	r9d, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r11
	add	rbp, rax
	mov	[rdi + r13 * 8 + 8], rcx
	adc	r9, rdx
Lm2e3:
mov	ebx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	rbp, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	r9, rdx
	adc	ebx, 0
	mul	r11
	mov	ecx, 0
	add	r9, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top3

	mul	r10
	add	r9, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r9
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rax, rbx
	adc	rdx, rcx
	mov	[rdi], rax
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2
	cmp	r8, -1
	jz	Lcor1

Lam2o1:
	mov	r10, [rsi + r8 * 8 - 8]
	mov	rax, [rsi + r8 * 8]
	mov	r11, rax
	lea	r13, [r8 + 1]
	mul	r10
	mov	r14, rax
	mov	r12, rdx
	mov	rcx, [rdi + r8 * 8]
	xor	ebp, ebp
	mov	rax, [rsi + r8 * 8 + 8]
	xor	r9d, r9d
	jmp	Llo1

	align 16, db 0x90
Lam2top1:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r9, [rdx]
	adc	r9, 0
Llo1:
	mul	r10
	add	r14, rcx
	mov	[rdi + r13 * 8 - 8], r14
	adc	r12, rax
	mov	r14, rdx
	adc	r14, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r9, rax
	adc	rbx, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r12, rbp
	adc	r14, rax
	mov	[rdi + r13 * 8], r12
	mov	r12, rdx
	adc	r12, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r9, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	r14, r9
	mov	[rdi + r13 * 8 + 8], r14
	adc	r12, rax
	mov	r14, rdx
	mov	r9, [rdi + r13 * 8 + 16]
	adc	r14, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r9
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
	mul	r10
	add	r12, rbx
	mov	[rdi + r13 * 8 + 16], r12
	mov	r12, rdx
	adc	r14, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r12, 0
	add	r13, 4
	jnc	Lam2top1

	mul	r11
	add	rcx, rbx
	adc	rax, rbp
	adc	rdx, r13
	add	r14, rcx
	adc	r12, r13
	mov	[rdi - 8], r14
	add	rax, r12
	mov	[rdi], rax
	adc	rdx, r13
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2

Lam2o3:
	mov	r10, [rsi + r8 * 8 - 8]
	mov	rax, [rsi + r8 * 8]
	mov	r11, rax
	lea	r13, [r8 - 1]
	mul	r10
	mov	r14, rax
	mov	r12, rdx
	mov	r9, [rdi + r8 * 8]
	xor	ebx, ebx
	xor	ecx, ecx
	mov	rax, [rsi + r8 * 8 + 8]
	jmp	Llo3

	align 16, db 0x90
Lam2top3:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r9, [rdx]
	adc	r9, 0
	mul	r10
	add	r14, rcx
	mov	[rdi + r13 * 8 - 8], r14
	adc	r12, rax
	mov	r14, rdx
	adc	r14, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r9, rax
	adc	rbx, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r12, rbp
	adc	r14, rax
	mov	[rdi + r13 * 8], r12
	mov	r12, rdx
	adc	r12, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r9, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
Llo3:
	mul	r10
	add	r14, r9
	mov	[rdi + r13 * 8 + 8], r14
	adc	r12, rax
	mov	r14, rdx
	mov	r9, [rdi + r13 * 8 + 16]
	adc	r14, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r9
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
	mul	r10
	add	r12, rbx
	mov	[rdi + r13 * 8 + 16], r12
	mov	r12, rdx
	adc	r14, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r12, 0
	add	r13, 4
	jnc	Lam2top3

	mul	r11
	add	rcx, rbx
	adc	rax, rbp
	adc	rdx, r13
	add	r14, rcx
	adc	r12, r13
	mov	[rdi - 8], r14
	add	rax, r12
	mov	[rdi], rax
	adc	rdx, r13
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2
	cmp	r8, -1
	jnz	Lam2o1

Lcor1:
pop	r8
	mov	r9, rdx
	mov	r10, [rsi - 16]
	mov	rax, [rsi - 8]
	mul	r10
	add	rax, r9
	adc	rdx, 0
	mov	[rdi - 8], rax
	mov	[rdi], rdx
	jmp	Lsqr_diag_addlsh1

	align 16, db 0x90
Lm2top2:
Lm2e2:
mul	r10
	add	r9, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r9
	adc	rbx, rdx
	adc	ecx, 0
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	ebp, 0
	mov	rax, [rsi + r13 * 8]
	mul	r10
	add	rbx, rax
	mov	[rdi + r13 * 8], rbx
	adc	rcx, rdx
	mov	rax, [rsi + r13 * 8]
	adc	ebp, 0
	mul	r11
	add	rcx, rax
	adc	rbp, rdx
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	mov	r9d, 0
	add	rcx, rax
	adc	rbp, rdx
	adc	r9d, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r11
	add	rbp, rax
	mov	[rdi + r13 * 8 + 8], rcx
	adc	r9, rdx
	mov	ebx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	rbp, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	r9, rdx
	adc	ebx, 0
	mul	r11
	mov	ecx, 0
	add	r9, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top2

	mul	r10
	add	r9, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r9
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rax, rbx
	adc	rdx, rcx
	mov	[rdi], rax
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2
	jmp	Lam2o0

	align 16, db 0x90
Lm2top0:
	mul	r10
	add	r9, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r9
	adc	rbx, rdx
	adc	ecx, 0
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	ebp, 0
	mov	rax, [rsi + r13 * 8]
	mul	r10
	add	rbx, rax
	mov	[rdi + r13 * 8], rbx
	adc	rcx, rdx
	mov	rax, [rsi + r13 * 8]
	adc	ebp, 0
	mul	r11
	add	rcx, rax
	adc	rbp, rdx
Lm2e0:
mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	mov	r9d, 0
	add	rcx, rax
	adc	rbp, rdx
	adc	r9d, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r11
	add	rbp, rax
	mov	[rdi + r13 * 8 + 8], rcx
	adc	r9, rdx
	mov	ebx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	rbp, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	r9, rdx
	adc	ebx, 0
	mul	r11
	mov	ecx, 0
	add	r9, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top0

	mul	r10
	add	r9, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r9
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rax, rbx
	adc	rdx, rcx
	mov	[rdi], rax
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2
	cmp	r8, -2
	jz	Lcor2

Lam2o2:
	mov	r10, [rsi + r8 * 8 - 8]
	mov	rax, [rsi + r8 * 8]
	mov	r11, rax
	lea	r13, [r8 - 2]
	mul	r10
	mov	r12, rax
	mov	r14, rdx
	mov	rbx, [rdi + r8 * 8]
	xor	ecx, ecx
	xor	ebp, ebp
	mov	rax, [rsi + r8 * 8 + 8]
	jmp	Llo2

	align 16, db 0x90
Lam2top2:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r9, [rdx]
	adc	r9, 0
	mul	r10
	add	r14, rcx
	mov	[rdi + r13 * 8 - 8], r14
	adc	r12, rax
	mov	r14, rdx
	adc	r14, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r9, rax
	adc	rbx, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r12, rbp
	adc	r14, rax
	mov	[rdi + r13 * 8], r12
	mov	r12, rdx
	adc	r12, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r9, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	r14, r9
	mov	[rdi + r13 * 8 + 8], r14
	adc	r12, rax
	mov	r14, rdx
	mov	r9, [rdi + r13 * 8 + 16]
	adc	r14, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r9
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
Llo2:
	mul	r10
	add	r12, rbx
	mov	[rdi + r13 * 8 + 16], r12
	mov	r12, rdx
	adc	r14, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r12, 0
	add	r13, 4
	jnc	Lam2top2

	mul	r11
	add	rcx, rbx
	adc	rax, rbp
	adc	rdx, r13
	add	r14, rcx
	adc	r12, r13
	mov	[rdi - 8], r14
	add	rax, r12
	mov	[rdi], rax
	adc	rdx, r13
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2

Lam2o0:
	mov	r10, [rsi + r8 * 8 - 8]
	mov	rax, [rsi + r8 * 8]
	mov	r11, rax
	lea	r13, [r8 + 0]
	mul	r10
	mov	r12, rax
	mov	r14, rdx
	xor	ebx, ebx
	mov	rbp, [rdi + r8 * 8]
	xor	r9d, r9d
	jmp	Llo0

	align 16, db 0x90
Lam2top0:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r9, [rdx]
	adc	r9, 0
	mul	r10
	add	r14, rcx
	mov	[rdi + r13 * 8 - 8], r14
	adc	r12, rax
	mov	r14, rdx
	adc	r14, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r9, rax
	adc	rbx, 0
Llo0:
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r12, rbp
	adc	r14, rax
	mov	[rdi + r13 * 8], r12
	mov	r12, rdx
	adc	r12, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r9, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	r14, r9
	mov	[rdi + r13 * 8 + 8], r14
	adc	r12, rax
	mov	r14, rdx
	mov	r9, [rdi + r13 * 8 + 16]
	adc	r14, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r9
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
	mul	r10
	add	r12, rbx
	mov	[rdi + r13 * 8 + 16], r12
	mov	r12, rdx
	adc	r14, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r12, 0
	add	r13, 4
	jnc	Lam2top0

	mul	r11
	add	rcx, rbx
	adc	rax, rbp
	adc	rdx, r13
	add	r14, rcx
	adc	r12, r13
	mov	[rdi - 8], r14
	add	rax, r12
	mov	[rdi], rax
	adc	rdx, r13
	mov	[rdi + 8], rdx

	lea	rdi, [rdi + 16]
	add	r8, 2
	cmp	r8, -2
	jnz	Lam2o2

Lcor2:
pop	r8
	mov	r10, [rsi - 24]
	mov	rbp, rax
	mov	rbx, rdx
	mov	rax, [rsi - 16]
	mov	r11, rax
	mul	r10
	mov	r12, rax
	mov	r14, rdx
	mov	rax, [rsi - 8]
	mul	r10
	add	r12, rbp
	mov	[rdi - 16], r12
	mov	r12, rdx
	adc	r14, rax
	mov	rax, [rsi - 8]
	adc	r12, 0
	mul	r11
	add	r14, rbx
	adc	r12, 0
	mov	[rdi - 8], r14
	add	rax, r12
	mov	[rdi], rax
	adc	rdx, 0
	mov	[rdi + 8], rdx
	lea	rdi, [rdi + 8]

Lsqr_diag_addlsh1:
	mov	rax, [rsi + r8 * 8 - 8]
	shl	r8, 1
	xor	ebx, ebx
	mul	rax
	mov	r11, [rdi + r8 * 8 + 8]
	lea	r10, [rdx]
	mov	r9, [rdi + r8 * 8 + 16]
	add	r11, r11
	jmp	Ldm

	align 16, db 0x90
Ldtop:
mul	rax
	add	r10, r11
	mov	r11, [rdi + r8 * 8 + 8]
	mov	[rdi + r8 * 8 - 8], r10
	adc	rax, r9
	lea	r10, [rdx + rbx]
	mov	r9, [rdi + r8 * 8 + 16]
	adc	r11, r11
Ldm:
	mov	[rdi + r8 * 8], rax
	mov	rax, [rsi + r8 * 4]
	adc	r9, r9
	setc	bl
	add	r8, 2
	js	Ldtop

	mul	rax
	add	r10, r11
	mov	[rdi - 8], r10
	adc	rax, r9
	lea	r10, [rdx + rbx]
	mov	[rdi], rax
	adc	r10, 0
	mov	[rdi + 8], r10

	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret

	align 16, db 0x90
Lsmall:
	mov	rax, [rsi]
	cmp	rdx, 2
	jae	Lgt1
Ln1:
	mul	rax
	mov	[rdi], rax
	mov	[rdi + 8], rdx
	pop	rsi
	pop	rdi
	ret

Lgt1:
	jne	Lgt2
Ln2:
	mov	r8, rax
	mul	rax
	mov	r11, [rsi + 8]
	mov	[rdi], rax
	mov	rax, r11
	mov	r9, rdx
	mul	rax
	mov	r10, rax
	mov	rax, r11
	mov	r11, rdx
	mul	r8
	xor	r8, r8
	add	r9, rax
	adc	r10, rdx
	adc	r11, r8
	add	r9, rax
	mov	[rdi + 8], r9
	adc	r10, rdx
	mov	[rdi + 16], r10
	adc	r11, r8
	mov	[rdi + 24], r11
	pop	rsi
	pop	rdi
	ret

Lgt2:
Ln3:
	mov	r10, rax
	mul	rax
	mov	r11, [rsi + 8]
	mov	[rdi], rax
	mov	rax, r11
	mov	[rdi + 8], rdx
	mul	rax
	mov	rcx, [rsi + 16]
	mov	[rdi + 16], rax
	mov	rax, rcx
	mov	[rdi + 24], rdx
	mul	rax
	mov	[rdi + 32], rax
	mov	[rdi + 40], rdx

	mov	rax, r11
	mul	r10
	mov	r8, rax
	mov	rax, rcx
	mov	r9, rdx
	mul	r10
	xor	r10, r10
	add	r9, rax
	mov	rax, r11
	mov	r11, r10
	adc	r10, rdx

	mul	rcx
	add	r10, rax
	adc	rdx, r11
	add	r8, r8
	adc	r9, r9
	adc	r10, r10
	adc	rdx, rdx
	adc	r11, r11
	add	[rdi + 8], r8
	adc	[rdi + 16], r9
	adc	[rdi + 24], r10
	adc	[rdi + 32], rdx
	adc	[rdi + 40], r11
	pop	rsi
	pop	rdi
	ret
	
