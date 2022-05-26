[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_mul_2
	
	;.def	__gmpn_mul_2
	;.scl	2
	;.type	32
	;.endef
__gmpn_mul_2:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	push	rbx
	push	rbp

	mov	r8, [rcx]
	mov	r9, [rcx + 8]

	mov	rax, [rsi]

	mov	r11, rdx
	neg	r11
	lea	rsi, [rsi + rdx * 8 - 8]
	lea	rdi, [rdi + rdx * 8 - 8]

	and	edx, 3
	jz	Lm2p0
	cmp	edx, 2
	jc	Lm2p1
	jz	Lm2p2
Lm2p3:
	mul	r8
	xor	r10d, r10d
	mov	rcx, rax
	mov	rbp, rdx
	mov	rax, [rsi + r11 * 8 + 8]
	add	r11, -1
	mul	r9
	add	rbp, rax
	jmp	Lm23
Lm2p0:
	mul	r8
	xor	ebp, ebp
	mov	rbx, rax
	mov	rcx, rdx
	jmp	Lm20
Lm2p1:
	mul	r8
	xor	r10d, r10d
	xor	ebx, ebx
	xor	ecx, ecx
	add	r11, 1
	jmp	Lm2top
Lm2p2:
	mul	r8
	xor	ebx, ebx
	xor	ecx, ecx
	mov	rbp, rax
	mov	r10, rdx
	mov	rax, [rsi + r11 * 8 + 8]
	add	r11, -2
	jmp	Lm22


	align 32, db 0x90
Lm2top:
	add	r10, rax
	adc	rbx, rdx
	mov	rax, [rsi + r11 * 8 + 0]
	adc	ecx, 0
	mov	ebp, 0
	mul	r9
	add	rbx, rax
	mov	[rdi + r11 * 8 + 0], r10
	adc	rcx, rdx
	mov	rax, [rsi + r11 * 8 + 8]
	mul	r8
	add	rbx, rax
	adc	rcx, rdx
	adc	ebp, 0
Lm20:
	mov	rax, [rsi + r11 * 8 + 8]
	mul	r9
	add	rcx, rax
	adc	rbp, rdx
	mov	rax, [rsi + r11 * 8 + 16]
	mov	r10d, 0
	mul	r8
	add	rcx, rax
	mov	rax, [rsi + r11 * 8 + 16]
	adc	rbp, rdx
	adc	r10d, 0
	mul	r9
	add	rbp, rax
	mov	[rdi + r11 * 8 + 8], rbx
Lm23:
	adc	r10, rdx
	mov	rax, [rsi + r11 * 8 + 24]
	mul	r8
	mov	ebx, 0
	add	rbp, rax
	adc	r10, rdx
	mov	[rdi + r11 * 8 + 16], rcx
	mov	rax, [rsi + r11 * 8 + 24]
	mov	ecx, 0
	adc	ebx, 0
Lm22:
	mul	r9
	add	r10, rax
	mov	[rdi + r11 * 8 + 24], rbp
	adc	rbx, rdx
	mov	rax, [rsi + r11 * 8 + 32]
	mul	r8
	add	r11, 4
	js	Lm2top


	add	r10, rax
	adc	rbx, rdx
	adc	ecx, 0
	mov	rax, [rsi]
	mul	r9
	mov	[rdi], r10
	add	rbx, rax
	adc	rcx, rdx
	mov	[rdi + 8], rbx
	mov	rax, rcx

	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	
