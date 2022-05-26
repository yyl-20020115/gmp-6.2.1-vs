[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_rsh1sub_nc
	
	;.def	__gmpn_rsh1sub_nc
	;.scl	2
	;.type	32
	;.endef
__gmpn_rsh1sub_nc:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rsp + 56]
	push	rbx
	push	rbp

	neg	r8
	mov	r8, [rsi]
	sbb	r8, [rdx]
	jmp	Lent
	

	align 16, db 0x90
	global __gmpn_rsh1sub_n
	
	;.def	__gmpn_rsh1sub_n
	;.scl	2
	;.type	32
	;.endef
__gmpn_rsh1sub_n:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	push	rbx
	push	rbp

	mov	r8, [rsi]
	sub	r8, [rdx]
Lent:
	sbb	ebx, ebx
	mov	rax, r8
	and	eax, 1

	lea	rsi, [rsi + rcx * 8]
	lea	rdx, [rdx + rcx * 8]
	lea	rdi, [rdi + rcx * 8]
	mov	ebp, ecx
	neg	rcx
	and	ebp, 3
	jz	Lb0
	cmp	ebp, 2
	jae	Ln1

Lb1:
	mov	rbp, r8
	inc	rcx
	js	Ltop
	jmp	Lend

Ln1:
	jnz	Lb3
	add	ebx, ebx
	mov	r11, [rsi + rcx * 8 + 8]
	sbb	r11, [rdx + rcx * 8 + 8]
	sbb	ebx, ebx
	mov	r10, r8
	add	rcx, -2
	jmp	L2

Lb3:
	add	ebx, ebx
	mov	r10, [rsi + rcx * 8 + 8]
	mov	r11, [rsi + rcx * 8 + 16]
	sbb	r10, [rdx + rcx * 8 + 8]
	sbb	r11, [rdx + rcx * 8 + 16]
	sbb	ebx, ebx
	mov	r9, r8
	dec	rcx
	jmp	L3

Lb0:
	add	ebx, ebx
	mov	r9, [rsi + rcx * 8 + 8]
	mov	r10, [rsi + rcx * 8 + 16]
	mov	r11, [rsi + rcx * 8 + 24]
	sbb	r9, [rdx + rcx * 8 + 8]
	sbb	r10, [rdx + rcx * 8 + 16]
	sbb	r11, [rdx + rcx * 8 + 24]
	sbb	ebx, ebx
	jmp	L4

	align 16, db 0x90

Ltop:
	add	ebx, ebx
	mov	r8, [rsi + rcx * 8]
	mov	r9, [rsi + rcx * 8 + 8]
	mov	r10, [rsi + rcx * 8 + 16]
	mov	r11, [rsi + rcx * 8 + 24]
	sbb	r8, [rdx + rcx * 8]
	sbb	r9, [rdx + rcx * 8 + 8]
	sbb	r10, [rdx + rcx * 8 + 16]
	sbb	r11, [rdx + rcx * 8 + 24]
	sbb	ebx, ebx
	shrd	rbp, r8, 1
	mov	[rdi + rcx * 8 - 8], rbp
L4:
	shrd	r8, r9, 1
	mov	[rdi + rcx * 8], r8
L3:
	shrd	r9, r10, 1
	mov	[rdi + rcx * 8 + 8], r9
L2:
	shrd	r10, r11, 1
	mov	[rdi + rcx * 8 + 16], r10
L1:
	add	rcx, 4
	mov	rbp, r11
	js	Ltop

Lend:
	shrd	rbp, rbx, 1
	mov	[rdi - 8], rbp
	pop	rbp
	pop	rbx
	pop	rsi
	pop	rdi
	ret
	
