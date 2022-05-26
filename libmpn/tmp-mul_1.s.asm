[Bits 64]
	align 16, db 0x90
	global __gmpn_mul_1c
	
	;.def	__gmpn_mul_1c
	;.scl	2
	;.type	32
	;.endef
__gmpn_mul_1c:

push	rsi
push	rdi
mov	rsi, rdx
	push	rbx

	mov	r10, [rsp + 64]
	jmp	Lcommon
	

	global __gmpn_mul_1
	
	;.def	__gmpn_mul_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_mul_1:

push	rsi
push	rdi
mov	rsi, rdx

	push	rbx
	xor	r10, r10
Lcommon:
	mov	rax, [rsi]
	
	mov	rbx, r8
	mul	r9


	add	rax, r10
	adc	rdx, 0

	and	ebx, 3
	jz	Lb0
	cmp	ebx, 2
	jz	Lb2
	jg	Lb3

Lb1:
	dec	r8
	jne	Lgt1
	mov	[rcx], rax
	jmp	Lret
Lgt1:
	lea	rsi, [rsi + r8 * 8 + 8]
	lea	rcx, [rcx + r8 * 8 - 8]
	neg	r8
	xor	r10, r10
	xor	ebx, ebx
	mov	rdi, rax
	mov	rax, [rsi + r8 * 8]
	mov	r11, rdx
	jmp	LL1

Lb0:
	lea	rsi, [rsi + r8 * 8]
	lea	rcx, [rcx + r8 * 8 - 16]
	neg	r8
	xor	r10, r10
	mov	r11, rax
	mov	rbx, rdx
	jmp	LL0

Lb3:
	lea	rsi, [rsi + r8 * 8 - 8]
	lea	rcx, [rcx + r8 * 8 - 24]
	neg	r8
	mov	rbx, rax
	mov	r10, rdx
	jmp	LL3

Lb2:
	lea	rsi, [rsi + r8 * 8 - 16]
	lea	rcx, [rcx + r8 * 8 - 32]
	neg	r8
	xor	r11, r11
	xor	ebx, ebx
	mov	r10, rax
	mov	rax, [rsi + r8 * 8 + 24]
	mov	rdi, rdx
	jmp	LL2

	align 16, db 0x90
Ltop:
	mov	[rcx + r8 * 8], r10
	add	rdi, rax
	mov	rax, [rsi + r8 * 8]
	adc	r11, rdx
	mov	r10d, 0
LL1:
	mul	r9
	mov	[rcx + r8 * 8 + 8], rdi
	add	r11, rax
	adc	rbx, rdx
LL0:
	mov	rax, [rsi + r8 * 8 + 8]
	mul	r9
	mov	[rcx + r8 * 8 + 16], r11
	add	rbx, rax
	adc	r10, rdx
LL3:
	mov	rax, [rsi + r8 * 8 + 16]
	mul	r9
	mov	[rcx + r8 * 8 + 24], rbx
	mov	r11d, 0
	mov	rbx, r11
	add	r10, rax
	mov	rax, [rsi + r8 * 8 + 24]
	mov	rdi, r11
	adc	rdi, rdx
LL2:
	mul	r9
	add	r8, 4
	js	Ltop

	mov	[rcx + r8 * 8], r10
	add	rdi, rax
	adc	rdx, r11
	mov	[rcx + r8 * 8 + 8], rdi
	add	rdx, r11
Lret:
	mov	rax, rdx

	pop	rbx
pop	rdi
pop	rsi
	ret
	
