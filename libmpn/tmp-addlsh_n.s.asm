[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_addlsh_n
	
	;.def	__gmpn_addlsh_n
	;.scl	2
	;.type	32
	;.endef
__gmpn_addlsh_n:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8d, [rsp + 56]
	push	rbx
	xor	ebx, ebx
Lent:
	push	rbp
	mov	ebp, ecx
	mov	rax, rcx

	mov	ecx, r8d
	neg	ecx

	lea	rsi, [rsi + rax * 8 - 8]
	lea	rdx, [rdx + rax * 8 - 8]
	lea	rdi, [rdi + rax * 8 - 40]
	neg	rax

	and	ebp, 3
	jz	Lb0
	cmp	ebp, 2
	jc	Lb1
	jz	Lb2

Lb3:
	xor	r9d, r9d
	mov	r10, [rdx + rax * 8 + 8]
	mov	r11, [rdx + rax * 8 + 16]
	shrd	r9, r10, cl
	shrd	r10, r11, cl
	add	ebx, ebx
	adc	r9, [rsi + rax * 8 + 8]
	mov	r8, [rdx + rax * 8 + 24]
	adc	r10, [rsi + rax * 8 + 16]
	sbb	ebx, ebx
	add	rax, 3
	jmp	Llo3

Lb0:
	mov	r9, [rdx + rax * 8 + 8]
	xor	r8d, r8d
	shrd	r8, r9, cl
	mov	r10, [rdx + rax * 8 + 16]
	mov	r11, [rdx + rax * 8 + 24]
	shrd	r9, r10, cl
	shrd	r10, r11, cl
	add	ebx, ebx
	adc	r8, [rsi + rax * 8 + 8]
	mov	[rdi + rax * 8 + 40], r8
	adc	r9, [rsi + rax * 8 + 16]
	mov	r8, [rdx + rax * 8 + 32]
	adc	r10, [rsi + rax * 8 + 24]
	sbb	ebx, ebx
	add	rax, 4
	jmp	Llo0

Lb1:
	mov	r8, [rdx + rax * 8 + 8]
	add	rax, 1
	jz	L1
	mov	r9, [rdx + rax * 8 + 8]
	xor	ebp, ebp
	jmp	Llo1
L1:
	xor	r11d, r11d
	jmp	Lwd1

Lb2:
	xor	r10, r10
	mov	r11, [rdx + rax * 8 + 8]
	shrd	r10, r11, cl
	add	ebx, ebx
	mov	r8, [rdx + rax * 8 + 16]
	adc	r10, [rsi + rax * 8 + 8]
	sbb	ebx, ebx
	add	rax, 2
	jz	Lend

	align 16, db 0x90
Ltop:
	mov	r9, [rdx + rax * 8 + 8]
	mov	rbp, r11
Llo2:
	mov	[rdi + rax * 8 + 24], r10
Llo1:
	shrd	rbp, r8, cl
	shrd	r8, r9, cl
	mov	r10, [rdx + rax * 8 + 16]
	mov	r11, [rdx + rax * 8 + 24]
	shrd	r9, r10, cl
	shrd	r10, r11, cl
	add	ebx, ebx
	adc	rbp, [rsi + rax * 8]
	adc	r8, [rsi + rax * 8 + 8]
	mov	[rdi + rax * 8 + 40], r8
	adc	r9, [rsi + rax * 8 + 16]
	mov	r8, [rdx + rax * 8 + 32]
	adc	r10, [rsi + rax * 8 + 24]
	sbb	ebx, ebx
	add	rax, 4
	mov	[rdi + rax * 8], rbp
Llo0:
Llo3:
	mov	[rdi + rax * 8 + 16], r9
	jnz	Ltop

Lend:
	mov	[rdi + rax * 8 + 24], r10
Lwd1:
	shrd	r11, r8, cl
	add	ebx, ebx
	adc	r11, [rsi + rax * 8]
	mov	[rdi + rax * 8 + 32], r11
	adc	eax, eax
	shr	r8, cl
	add	rax, r8

	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	
	global __gmpn_addlsh_nc
	
	;.def	__gmpn_addlsh_nc
	;.scl	2
	;.type	32
	;.endef
__gmpn_addlsh_nc:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8d, [rsp + 56]
	mov	r9, [rsp + 64]
	push	rbx
	neg	r9
	sbb	ebx, ebx
	jmp	Lent
	
