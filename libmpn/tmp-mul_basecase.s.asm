[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_mul_basecase
	
	;.def	__gmpn_mul_basecase
	;.scl	2
	;.type	32
	;.endef
__gmpn_mul_basecase:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8d, [rsp + 56]
	mov	rax, [rsi]
	push	rbx
	push	rbp
	push	r12
	push	r13
	push	r14

	mov	r10, [rcx]

	xor	r9, r9
	sub	r9, rdx

	lea	rsi, [rsi + rdx * 8]
	lea	rdi, [rdi + rdx * 8]

	mul	r10

	test	r8b, 1
	jz	Lm2

	lea	r14, [rcx + 8]

	test	r9b, 1
	jnz	Lm1x1

Lm1x0:
test	r9b, 2
	jnz	Lm1s2

Lm1s0:
	lea	r13, [r9]
	mov	[rdi + r9 * 8], rax
	mov	rax, [rsi + r9 * 8 + 8]
	mov	rbx, rdx
	;NOTICE: changes	
	;lea	rbp, qword [Ldo_am0]
	mov rbp, Ldo_am0
	;.byte 0x48,0x8d,0x2d,0x58,0x02,0x00,0x00
	jmp	Lm1e0

Lm1s2:
	lea	r13, [r9 + 2]
	mov	[rdi + r9 * 8], rax
	mov	rax, [rsi + r9 * 8 + 8]
	mov	rbx, rdx
	mul	r10
	;NOTICE: changes
	;lea	rbp, qword [Ldo_am2]
	mov rbp, Ldo_am2
	;.byte 0x48,0x8d,0x2d,0xa9,0x06,0x00,0x00
	test	r13, r13
	jnz	Lm1e2
	add	rbx, rax
	adc	rdx, 0
	mov	[rdi - 8], rbx
	mov	[rdi], rdx
	jmp	Lret2

Lm1x1:
test	r9b, 2
	jz	Lm1s3

Lm1s1:
	lea	r13, [r9 + 1]
	mov	[rdi + r9 * 8], rax
	test	r13, r13
	jz	L1
	mov	rax, [rsi + r9 * 8 + 8]
	mov	rcx, rdx
	;NOTICE: changes
	;lea	rbp, qword [Ldo_am1]
	mov rbp, Ldo_am1
	;.byte 0x48,0x8d,0x2d,0x2f,0x04,0x00,0x00
	jmp	Lm1e1
L1:
	mov	[rdi], rdx
	jmp	Lret2

Lm1s3:
	lea	r13, [r9 - 1]
	mov	[rdi + r9 * 8], rax
	mov	rax, [rsi + r9 * 8 + 8]
	mov	rcx, rdx
	;NOTICE: changes
	;lea	rbp, qword [Ldo_am3]
	mov rbp, Ldo_am3
	;.byte 0x48,0x8d,0x2d,0x8f,0x08,0x00,0x00
	jmp	Lm1e3

	align 16, db 0x90
Lm1top:
	mul	r10
	mov	[rdi + r13 * 8 - 16], rcx
Lm1e2:
xor	ecx, ecx
	add	rbx, rax
	mov	rax, [rsi + r13 * 8]
	adc	rcx, rdx
	mov	[rdi + r13 * 8 - 8], rbx
Lm1e1:
xor	ebx, ebx
	mul	r10
	add	rcx, rax
	mov	rax, [rsi + r13 * 8 + 8]
	adc	rbx, rdx
	mov	[rdi + r13 * 8], rcx
Lm1e0:
xor	ecx, ecx
	mul	r10
	add	rbx, rax
	mov	rax, [rsi + r13 * 8 + 16]
	adc	rcx, rdx
	mov	[rdi + r13 * 8 + 8], rbx
Lm1e3:
xor	ebx, ebx
	mul	r10
	add	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbx, rdx
	add	r13, 4
	js	Lm1top

	mul	r10
	mov	[rdi - 16], rcx
	add	rbx, rax
	adc	rdx, 0
	mov	[rdi - 8], rbx
	mov	[rdi], rdx

	dec	r8
	jz	Lret2
	lea	rdi, [rdi - 8]
	jmp	rbp

Lm2:
	mov	r11, [rcx + 8]
	lea	r14, [rcx + 16]

	test	r9b, 1
	jnz	Lbx1

Lbx0:
	test	r9b, 2
	jnz	Lb10

Lb00:
	lea	r13, [r9]
	mov	[rdi + r9 * 8], rax
	mov	rcx, rdx
	mov	rax, [rsi + r9 * 8]
	mov	ebp, 0
	jmp	Lm2e0

Lb10:
	lea	r13, [r9 - 2]
	mov	rbp, rax
	mov	rax, [rsi + r9 * 8]
	mov	r12, rdx
	mov	ebx, 0
	jmp	Lm2e2

Lbx1:
	test	r9b, 2
	jz	Lb11

Lb01:
	lea	r13, [r9 + 1]
	mov	[rdi + r9 * 8], rax
	mov	rax, [rsi + r9 * 8]
	mov	rbx, rdx
	mov	ecx, 0
	jmp	Lm2e1

Lb11:
	lea	r13, [r9 - 1]
	mov	rcx, rax
	mov	rax, [rsi + r9 * 8]
	mov	rbp, rdx
	mov	r12d, 0
	jmp	Lm2e3

	align 16, db 0x90
Lm2top0:
	mul	r10
	add	r12, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r12
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
	mul	r11
	mov	ecx, 0
	add	r12, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top0

	mul	r10
	add	r12, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r12
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	[rdi], rbx
	mov	[rdi + 8], rcx

	add	r8, -2
	jz	Lret2

Ldo_am0:
	push	r15
	push	r8

Lolo0:
	mov	r10, [r14]
	mov	r11, [r14 + 8]
	lea	r14, [r14 + 16]
	lea	rdi, [rdi + 16]
	mov	rax, [rsi + r9 * 8]

	mov	r13, r9
	mul	r10
	mov	r8, rax
	mov	rax, [rsi + r9 * 8]
	mov	r15, rdx
	mul	r11
	lea	rbx, [rdx]
	mov	rbp, [rdi + r9 * 8]
	mov	r12, rax
	jmp	Llo0

	align 16, db 0x90
Lam2top0:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r12, [rdx]
	adc	r12, 0
	mul	r10
	add	r15, rcx
	mov	[rdi + r13 * 8 - 8], r15
	adc	r8, rax
	mov	r15, rdx
	adc	r15, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r12, rax
	adc	rbx, 0
Llo0:
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r8, rbp
	adc	r15, rax
	mov	[rdi + r13 * 8], r8
	mov	r8, rdx
	adc	r8, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r12, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	r15, r12
	mov	[rdi + r13 * 8 + 8], r15
	adc	r8, rax
	mov	r15, rdx
	mov	r12, [rdi + r13 * 8 + 16]
	adc	r15, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r12
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
	mul	r10
	add	r8, rbx
	mov	[rdi + r13 * 8 + 16], r8
	mov	r8, rdx
	adc	r15, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r8, 0
	add	r13, 4
	jnc	Lam2top0

	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	adc	rdx, r13
	add	r15, rcx
	adc	r8, r13
	mov	[rdi - 8], r15
	add	r8, rbp
	mov	[rdi], r8
	adc	rdx, r13
	mov	[rdi + 8], rdx

	add	dword [rsp], -2
	jnz	Lolo0

Lret:
	pop	rax
	pop	r15
Lret2:
pop	r14
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret


	align 16, db 0x90
Lm2top1:
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
	mul	r11
	mov	ecx, 0
	add	r12, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top1

	mul	r10
	add	r12, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r12
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	[rdi], rbx
	mov	[rdi + 8], rcx

	add	r8, -2
	jz	Lret2

Ldo_am1:
	push	r15
	push	r8

Lolo1:
	mov	r10, [r14]
	mov	r11, [r14 + 8]
	lea	r14, [r14 + 16]
	lea	rdi, [rdi + 16]
	mov	rax, [rsi + r9 * 8]
	lea	r13, [r9 + 1]
	mul	r10
	mov	r15, rax
	mov	r8, rdx
	mov	rax, [rsi + r9 * 8]
	mov	rcx, [rdi + r9 * 8]
	mul	r11
	mov	rbp, rax
	mov	rax, [rsi + r9 * 8 + 8]
	lea	r12, [rdx]
	jmp	Llo1

	align 16, db 0x90
Lam2top1:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r12, [rdx]
	adc	r12, 0
Llo1:
	mul	r10
	add	r15, rcx
	mov	[rdi + r13 * 8 - 8], r15
	adc	r8, rax
	mov	r15, rdx
	adc	r15, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r12, rax
	adc	rbx, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r8, rbp
	adc	r15, rax
	mov	[rdi + r13 * 8], r8
	mov	r8, rdx
	adc	r8, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r12, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	r15, r12
	mov	[rdi + r13 * 8 + 8], r15
	adc	r8, rax
	mov	r15, rdx
	mov	r12, [rdi + r13 * 8 + 16]
	adc	r15, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r12
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
	mul	r10
	add	r8, rbx
	mov	[rdi + r13 * 8 + 16], r8
	mov	r8, rdx
	adc	r15, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r8, 0
	add	r13, 4
	jnc	Lam2top1

	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	adc	rdx, r13
	add	r15, rcx
	adc	r8, r13
	mov	[rdi - 8], r15
	add	r8, rbp
	mov	[rdi], r8
	adc	rdx, r13
	mov	[rdi + 8], rdx

	add	dword [rsp], -2
	jnz	Lolo1

	pop	rax
	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret


	align 16, db 0x90
Lm2top2:
	mul	r10
	add	r12, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r12
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
	mov	r12d, 0
	add	rcx, rax
	adc	rbp, rdx
	adc	r12d, 0
	mov	rax, [rsi + r13 * 8 + 8]
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
	js	Lm2top2

	mul	r10
	add	r12, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r12
	adc	rbx, rdx
	adc	ecx, ecx
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	[rdi], rbx
	mov	[rdi + 8], rcx

	add	r8, -2
	jz	Lret2

Ldo_am2:
	push	r15
	push	r8

Lolo2:
	mov	r10, [r14]
	mov	r11, [r14 + 8]
	lea	r14, [r14 + 16]
	lea	rdi, [rdi + 16]
	mov	rax, [rsi + r9 * 8]
	lea	r13, [r9 - 2]
	mul	r10
	mov	r8, rax
	mov	r15, rdx
	mov	rax, [rsi + r9 * 8]
	mov	rbx, [rdi + r9 * 8]
	mul	r11
	mov	rcx, rax
	lea	rbp, [rdx]
	mov	rax, [rsi + r9 * 8 + 8]
	jmp	Llo2

	align 16, db 0x90
Lam2top2:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r12, [rdx]
	adc	r12, 0
	mul	r10
	add	r15, rcx
	mov	[rdi + r13 * 8 - 8], r15
	adc	r8, rax
	mov	r15, rdx
	adc	r15, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r12, rax
	adc	rbx, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r8, rbp
	adc	r15, rax
	mov	[rdi + r13 * 8], r8
	mov	r8, rdx
	adc	r8, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r12, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r10
	add	r15, r12
	mov	[rdi + r13 * 8 + 8], r15
	adc	r8, rax
	mov	r15, rdx
	mov	r12, [rdi + r13 * 8 + 16]
	adc	r15, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r12
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
Llo2:
	mul	r10
	add	r8, rbx
	mov	[rdi + r13 * 8 + 16], r8
	mov	r8, rdx
	adc	r15, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r8, 0
	add	r13, 4
	jnc	Lam2top2

	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	adc	rdx, r13
	add	r15, rcx
	adc	r8, r13
	mov	[rdi - 8], r15
	add	r8, rbp
	mov	[rdi], r8
	adc	rdx, r13
	mov	[rdi + 8], rdx

	add	dword [rsp], -2
	jnz	Lolo2

	pop	rax
	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret


	align 16, db 0x90
Lm2top3:
	mul	r10
	add	r12, rax
	mov	rax, [rsi + r13 * 8 - 8]
	mov	[rdi + r13 * 8 - 8], r12
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
	mul	r11
	mov	ecx, 0
	add	r12, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	[rdi + r13 * 8 + 16], rbp
	adc	rbx, rdx
	add	r13, 4
	js	Lm2top3

	mul	r10
	add	r12, rax
	mov	rax, [rsi - 8]
	mov	[rdi - 8], r12
	adc	rbx, rdx
	adc	ecx, 0
	mul	r11
	add	rbx, rax
	adc	rcx, rdx
	mov	[rdi], rbx
	mov	[rdi + 8], rcx

	add	r8, -2
	jz	Lret2

Ldo_am3:
	push	r15
	push	r8

Lolo3:
	mov	r10, [r14]
	mov	r11, [r14 + 8]
	lea	r14, [r14 + 16]
	lea	rdi, [rdi + 16]
	mov	rax, [rsi + r9 * 8]
	lea	r13, [r9 - 1]
	mul	r10
	mov	r15, rax
	mov	r8, rdx
	mov	rax, [rsi + r9 * 8]
	mov	r12, [rdi + r9 * 8]
	mul	r11
	mov	rbx, rax
	lea	rcx, [rdx]
	mov	rax, [rsi + r9 * 8 + 8]
	jmp	Llo3

	align 16, db 0x90
Lam2top3:
	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	mov	rax, [rsi + r13 * 8]
	lea	r12, [rdx]
	adc	r12, 0
	mul	r10
	add	r15, rcx
	mov	[rdi + r13 * 8 - 8], r15
	adc	r8, rax
	mov	r15, rdx
	adc	r15, 0
	mov	rax, [rsi + r13 * 8]
	mul	r11
	lea	rbx, [rdx]
	mov	rcx, [rdi + r13 * 8]
	add	rbp, rcx
	adc	r12, rax
	adc	rbx, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mul	r10
	add	r8, rbp
	adc	r15, rax
	mov	[rdi + r13 * 8], r8
	mov	r8, rdx
	adc	r8, 0
	mov	rax, [rsi + r13 * 8 + 8]
	mov	rbp, [rdi + r13 * 8 + 8]
	mul	r11
	add	r12, rbp
	adc	rbx, rax
	lea	rcx, [rdx]
	adc	rcx, 0
	mov	rax, [rsi + r13 * 8 + 16]
Llo3:
	mul	r10
	add	r15, r12
	mov	[rdi + r13 * 8 + 8], r15
	adc	r8, rax
	mov	r15, rdx
	mov	r12, [rdi + r13 * 8 + 16]
	adc	r15, 0
	mov	rax, [rsi + r13 * 8 + 16]
	mul	r11
	add	rbx, r12
	lea	rbp, [rdx]
	adc	rcx, rax
	mov	rax, [rsi + r13 * 8 + 24]
	adc	rbp, 0
	mul	r10
	add	r8, rbx
	mov	[rdi + r13 * 8 + 16], r8
	mov	r8, rdx
	adc	r15, rax
	mov	rax, [rsi + r13 * 8 + 24]
	mov	rbx, [rdi + r13 * 8 + 24]
	adc	r8, 0
	add	r13, 4
	jnc	Lam2top3

	mul	r11
	add	rcx, rbx
	adc	rbp, rax
	adc	rdx, r13
	add	r15, rcx
	adc	r8, r13
	mov	[rdi - 8], r15
	add	r8, rbp
	mov	[rdi], r8
	adc	rdx, r13
	mov	[rdi + 8], rdx

	add	dword [rsp], -2
	jnz	Lolo3

	pop	rax
	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	
