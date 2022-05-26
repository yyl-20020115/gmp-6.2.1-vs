[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_preinv_divrem_1
	extern __gmpn_invert_limb
	;.def	__gmpn_preinv_divrem_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_preinv_divrem_1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rsp + 56]
	mov	r9, [rsp + 64]
	xor	eax, eax
	push	r13
	push	r12
	push	rbp
	push	rbx

	mov	r12, rsi
	mov	rbx, rcx
	add	rcx, rsi
	mov	rsi, rdx

	lea	rdi, [rdi + rcx * 8 - 8]

	mov	cl, [rsp + 104]
	shl	r8, cl
	jmp	Lent
	

	align 16, db 0x90
	global __gmpn_divrem_1
	
	;.def	__gmpn_divrem_1
	;.scl	2
	;.type	32
	;.endef
__gmpn_divrem_1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rsp + 56]
	xor	eax, eax
	push	r13
	push	r12
	push	rbp
	push	rbx

	mov	r12, rsi
	mov	rbx, rcx
	add	rcx, rsi
	mov	rsi, rdx
	je	Lret

	lea	rdi, [rdi + rcx * 8 - 8]
	xor	ebp, ebp

Lunnormalized:
	test	rbx, rbx
	je	L44
	mov	rax, [rsi + rbx * 8 - 8]
	cmp	rax, r8
	jae	L44
	mov	[rdi], rbp
	mov	rbp, rax
	lea	rdi, [rdi - 8]
	je	Lret
	dec	rbx
L44:
	bsr	rcx, r8
	not	ecx
	sal	r8, cl
	sal	rbp, cl

	push	rcx


	push	r8


	sub	rsp, 40
	mov	rcx, r8
	
	call	__gmpn_invert_limb

	add	rsp, 40
	pop	r8


	pop	rcx

	mov	r9, rax
	mov	rax, rbp
	test	rbx, rbx
	je	Lfrac

Lent:
	mov	rbp, [rsi + rbx * 8 - 8]
	shr	rax, cl
	shld	rax, rbp, cl
	sub	rbx, 2
	js	Lend

	align 16, db 0x90
Ltop:
	lea	r11, [rax + 1]
	mul	r9
	mov	r10, [rsi + rbx * 8]
	shld	rbp, r10, cl
	mov	r13, rbp
	add	r13, rax
	adc	rdx, r11
	mov	r11, rdx
	imul	rdx, r8
	sub	rbp, rdx
	lea	rax, [r8 + rbp]
	sub	rdi, 8
	cmp	rbp, r13
	cmovc	rax, rbp
	adc	r11, -1
	cmp	rax, r8
	jae	Lufx
Luok:
	dec	rbx
	mov	[rdi + 8], r11
	mov	rbp, r10
	jns	Ltop

Lend:
	lea	r11, [rax + 1]
	sal	rbp, cl
	mul	r9
	add	rax, rbp
	adc	rdx, r11
	mov	r11, rax
	mov	r13, rdx
	imul	rdx, r8
	sub	rbp, rdx
	mov	rax, r8
	add	rax, rbp
	cmp	rbp, r11
	cmovc	rax, rbp
	adc	r13, -1
	cmp	rax, r8
	jae	Lefx
Leok:
	mov	[rdi], r13
	sub	rdi, 8
	jmp	Lfrac

Lufx:
	sub	rax, r8
	inc	r11
	jmp	Luok
Lefx:
	sub	rax, r8
	inc	r13
	jmp	Leok

Lfrac:
mov	rbp, r8
	neg	rbp
	jmp	Lfent

	align 16, db 0x90
Lftop:
mul	r9
	add	rdx, r11
	mov	r11, rax
	mov	r13, rdx
	imul	rdx, rbp
	mov	rax, r8
	add	rax, rdx
	cmp	rdx, r11
	cmovc	rax, rdx
	adc	r13, -1
	mov	[rdi], r13
	sub	rdi, 8
Lfent:
lea	r11, [rax + 1]
	dec	r12
	jns	Lftop

	shr	rax, cl
Lret:
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	rsi
	pop	rdi
	ret
	
