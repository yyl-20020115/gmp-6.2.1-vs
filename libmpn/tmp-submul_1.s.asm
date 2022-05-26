[Bits 64]
	align 32, db 0x90
	global __gmpn_submul_1
	
	;.def	__gmpn_submul_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_submul_1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	push	rbx

	mov	rax, [rsi]
	lea	rsi, [rsi + rdx * 8 - 8]
	mov	r8, [rdi]
	lea	rdi, [rdi + rdx * 8 - 8]

	test	dl, 1
	jnz	Lbx1

Lbx0:
	test	dl, 2
	jnz	Lb10

Lb00:
	mov	ebx, 3
	sub	rbx, rdx
	mul	rcx
	mov	r11d, 0
	mov	r10, r8
	sub	r10, rax
	mov	rax, [rsi + rbx * 8 - 8]
	adc	r11, rdx
	jmp	Llo0

Lb10:
	mov	ebx, 1
	sub	rbx, rdx
	mul	rcx
	mov	r10, r8
	mov	r11d, 0
	sub	r10, rax
	mov	rax, [rsi + rbx * 8 + 8]
	adc	r11, rdx
	jmp	Llo2

Lbx1:
	test	dl, 2
	jz	Lb01

Lb11:
	mov	ebx, 2
	sub	rbx, rdx
	mul	rcx
	sub	r8, rax
	mov	r9d, 0
	mov	rax, [rsi + rbx * 8]
	adc	r9, rdx
	jmp	Llo3

Lb01:
	mov	ebx, 0
	sub	rbx, rdx
	xor	r11, r11
	add	rbx, 4
	jc	Lend

	align 32, db 0x90
Ltop:
	mul	rcx
	sub	r8, rax
	mov	r9d, 0
	mov	rax, [rsi + rbx * 8 - 16]
	adc	r9, rdx
Llo1:
	mul	rcx
	sub	r8, r11
	mov	r11d, 0
	mov	r10, [rdi + rbx * 8 - 16]
	adc	r9, 0
	sub	r10, rax
	mov	rax, [rsi + rbx * 8 - 8]
	adc	r11, rdx
	mov	[rdi + rbx * 8 - 24], r8
	sub	r10, r9
	adc	r11, 0
Llo0:
	mov	r8, [rdi + rbx * 8 - 8]
	mul	rcx
	sub	r8, rax
	mov	r9d, 0
	mov	rax, [rsi + rbx * 8]
	adc	r9, rdx
	mov	[rdi + rbx * 8 - 16], r10
	sub	r8, r11
	adc	r9, 0
Llo3:
	mul	rcx
	mov	r10, [rdi + rbx * 8]
	mov	r11d, 0
	sub	r10, rax
	mov	rax, [rsi + rbx * 8 + 8]
	adc	r11, rdx
	mov	[rdi + rbx * 8 - 8], r8
	sub	r10, r9
	adc	r11, 0
Llo2:
	mov	r8, [rdi + rbx * 8 + 8]
	mov	[rdi + rbx * 8], r10
	add	rbx, 4
	jnc	Ltop

Lend:
	mul	rcx
	sub	r8, rax
	mov	eax, 0
	adc	rax, rdx
	sub	r8, r11
	adc	rax, 0
	mov	[rdi], r8

	pop	rbx
	pop	rsi
	pop	rdi
	ret
	

