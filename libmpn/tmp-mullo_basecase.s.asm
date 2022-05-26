[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_mullo_basecase
	
	;.def	__gmpn_mullo_basecase
	;.scl	2
	;.type	32
	;.endef
__gmpn_mullo_basecase:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9


	mov	rax, [rsi]
	mov	r8, rdx

	cmp	rcx, 4
	jb	Lsmall

	mov	r10, [rdx]
	push	rbx
	lea	rdi, [rdi + rcx * 8]
	push	rbp
	lea	rsi, [rsi + rcx * 8]
	push	r12
	mov	r9d, 0
	sub	r9, rcx
	push	r13
	mul	r10
	mov	r11, [r8 + 8]

	test	cl, 1
	jnz	Lm2x1

Lm2x0:
test	cl, 2
	jnz	Lm2b2

Lm2b0:
lea	r13, [r9]
	mov	[rdi + r9 * 8], rax
	mov	rcx, rdx
	mov	rax, [rsi + r9 * 8]
	xor	ebp, ebp
	jmp	Lm2e0

Lm2b2:
lea	r13, [r9 - 2]
	mov	rbp, rax
	mov	rax, [rsi + r9 * 8]
	mov	r12, rdx
	xor	ebx, ebx
	jmp	Lm2e2

Lm2x1:
test	cl, 2
	jnz	Lm2b3

Lm2b1:
lea	r13, [r9 + 1]
	mov	[rdi + r9 * 8], rax
	mov	rax, [rsi + r9 * 8]
	mov	rbx, rdx
	xor	ecx, ecx
	jmp	Lm2e1

Lm2b3:
lea	r13, [r9 - 1]
	xor	r12d, r12d
	mov	rcx, rax
	mov	rbp, rdx
	mov	rax, [rsi + r9 * 8]
	jmp	Lm2e3

	align 16, db 0x90
Lm2tp:
mul	r10
	add	r12, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r12
	adc	rbx, rdx
	adc	ecx, 0
Lm2e1:
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
Lm2e0:
mul	r11
	add	rcx, rax
	adc	rbp, rdx
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	mov	r12d, 0
	add	rcx, rax
	adc	rbp, rdx
	adc	r12d, 0
	mov	rax, [rsi + r13 * 8 + 8]
Lm2e3:
mul	r11
	add	rbp, rax
	mov	[rdi + r13 * 8 + 8], rcx
	adc	r12, rdx
	mov	ebx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	rbp, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	r12, rdx
	adc	ebx, 0
Lm2e2:
mul	r11
	mov	ecx, 0
	add	r12, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2tp

Lm2ed:
imul	rax, r10
	add	rax, r12
	mov	[rdi - 8], rax

	add	r9, 2
	lea	r8, [r8 + 16]
	lea	rsi, [rsi - 16]
	cmp	r9, -2
	jge	Lcor1

	push	r14
	push	r15

Louter:
	mov	r10, [r8]
	mov	r11, [r8 + 8]
	mov	rax, [rsi + r9 * 8]
	mul	r10
	test	r9b, 1
	jnz	La1x1

La1x0:
mov	r15, rax
	mov	r14, rdx
	mov	rax, [rsi + r9 * 8]
	mul	r11
	test	r9b, 2
	jnz	La110

La100:
lea	r13, [r9]
	mov	r12, [rdi + r9 * 8]
	mov	rbx, rax
	lea	rcx, [rdx]
	jmp	Llo0

La110:
lea	r13, [r9 + 2]
	mov	rcx, [rdi + r9 * 8]
	mov	rbp, rax
	mov	rax, [rsi + r9 * 8 + 8]
	lea	r12, [rdx]
	jmp	Llo2

La1x1:
mov	r14, rax
	mov	r15, rdx
	mov	rax, [rsi + r9 * 8]
	mul	r11
	test	r9b, 2
	jz	La111

La101:
lea	r13, [r9 + 1]
	lea	rbx, [rdx]
	mov	rbp, [rdi + r9 * 8]
	mov	r12, rax
	jmp	Llo1

La111:
lea	r13, [r9 - 1]
	lea	rbp, [rdx]
	mov	rcx, rax
	mov	rbx, [rdi + r9 * 8]
	mov	rax, [rsi + r9 * 8 + 8]
	jmp	Llo3

	align 16, db 0x90
Ltop:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8 - 8]
	lea	r12, [rdx]
	adc	r12, 0
Llo2:
	mul	r10
	add	r15, rcx
	mov	[rdi + r13 * 8 - 16], r15
	adc	r14, rax
	mov	r15, rdx
	adc	r15, 0
	mov	rax, [rsi + r13 * 8 - 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8 - 8]
	add	rbp, rcx
	adc	r12, rax
	adc	rbx, 0
Llo1:
	mov	rax, [rsi + r13 * 8]
	mul	r10
	add	r14, rbp
	adc	r15, rax
	mov	[rdi + r13 * 8 - 8], r14
	mov	r14, rdx
	adc	r14, 0
	mov	rax, [rsi + r13 * 8]
	mov	rbp, [rdi + r13 * 8]
	mul	r11
	add	r12, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
Llo0:
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r15, r12
	mov	[rdi + r13 * 8], r15
	adc	r14, rax
	mov	r15, rdx
	mov	r12, [rdi + r13 * 8 + 8]
	adc	r15, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r11
	add	rbx, r12
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	rbp, 0
Llo3:
	mul	r10
	add	r14, rbx
	mov	[rdi + r13 * 8 + 8], r14
	mov	r14, rdx
	adc	r15, rax
	mov	rax, [rsi + r13 * 8 + 16]
	mov	rbx, [rdi + r13 * 8 + 16]
	adc	r14, 0
	add	r13, 4
	jnc	Ltop

Lend:
	imul	rax, r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi - 8]
	imul	rax, r10
	add	r15, rcx
	mov	[rdi - 16], r15
	adc	rax, r14
	mov	rcx, [rdi - 8]
	add	rbp, rcx
	add	rax, rbp
	mov	[rdi - 8], rax

	add	r9, 2
	lea	r8, [r8 + 16]
	lea	rsi, [rsi - 16]
	cmp	r9, -2
	jl	Louter

	pop	r15
	pop	r14

	jnz	Lcor0

Lcor1:
mov	r10, [r8]
	mov	r11, [r8 + 8]
	mov	rax, [rsi - 16]
	mul	r10
	add	rax, [rdi - 16]
	adc	rdx, [rdi - 8]
	mov	rbx, [rsi - 8]
	imul	rbx, r10
	mov	rcx, [rsi - 16]
	imul	rcx, r11
	mov	[rdi - 16], rax
	add	rcx, rbx
	add	rcx, rdx
	mov	[rdi - 8], rcx
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret

Lcor0:
mov	r11, [r8]
	imul	r11, [rsi - 8]
	add	r11, rax
	mov	[rdi - 8], r11
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret

	align 16, db 0x90
Lsmall:
	cmp	rcx, 2
	jae	Lgt1
Ln1:
	imul	rax, [rdx]
	mov	[rdi], rax
	pop	rsi
	pop	rdi
	ret
Lgt1:
	ja	Lgt2
Ln2:
	mov	r9, [rdx]
	mul	r9
	mov	[rdi], rax
	mov	rax, [rsi + 8]
	imul	rax, r9
	add	rdx, rax
	mov	r9, [r8 + 8]
	mov	rcx, [rsi]
	imul	rcx, r9
	add	rdx, rcx
	mov	[rdi + 8], rdx
	pop	rsi
	pop	rdi
	ret
Lgt2:
Ln3:
	mov	r9, [rdx]
	mul	r9
	mov	[rdi], rax
	mov	r10, rdx
	mov	rax, [rsi + 8]
	mul	r9
	imul	r9, [rsi + 16]
	add	r10, rax
	adc	r9, rdx
	mov	r11, [r8 + 8]
	mov	rax, [rsi]
	mul	r11
	add	r10, rax
	adc	r9, rdx
	imul	r11, [rsi + 8]
	add	r9, r11
	mov	[rdi + 8], r10
	mov	r10, [r8 + 16]
	mov	rax, [rsi]
	imul	r10, rax
	add	r9, r10
	mov	[rdi + 16], r9
	pop	rsi
	pop	rdi
	ret
	
