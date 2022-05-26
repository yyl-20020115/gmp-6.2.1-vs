[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_sub_n
	
	;.def	__gmpn_sub_n
	;.scl	2
	;.type	32
	;.endef
__gmpn_sub_n:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	xor	r8, r8
Lstart:
	mov	r10, [rsi]
	mov	r11, [rdx]

	lea	rsi, [rsi + rcx * 8]
	lea	rdx, [rdx + rcx * 8]
	lea	rdi, [rdi + rcx * 8]
	mov	eax, ecx
	neg	rcx
	and	eax, 3
	je	Lb00
	add	rcx, rax
	cmp	eax, 2
	jl	Lb01
	je	Lb10

Lb11:
	neg	r8
	jmp	Le11

Lb00:
	neg	r8
	mov	r8, r10
	mov	r9, r11
	lea	rcx, [rcx + 4]
	jmp	Le00

	nop
	nop
	nop
Lb01:
	neg	r8
	jmp	Ltop

Lb10:
	neg	r8
	mov	r8, r10
	mov	r9, r11
	jmp	Le10

Lend:
	sbb	r10, r11
	mov	[rdi - 8], r10
	mov	eax, ecx
	adc	eax, eax
	pop	rsi
	pop	rdi
	ret

	align 16, db 0x90
Ltop:
	jrcxz	Lend
	mov	r8, [rsi + rcx * 8]
	mov	r9, [rdx + rcx * 8]
	lea	rcx, [rcx + 4]
	sbb	r10, r11
	mov	[rdi + rcx * 8 - 40], r10
Le00:
	mov	r10, [rsi + rcx * 8 - 24]
	mov	r11, [rdx + rcx * 8 - 24]
	sbb	r8, r9
	mov	[rdi + rcx * 8 - 32], r8
Le11:
	mov	r8, [rsi + rcx * 8 - 16]
	mov	r9, [rdx + rcx * 8 - 16]
	sbb	r10, r11
	mov	[rdi + rcx * 8 - 24], r10
Le10:
	mov	r10, [rsi + rcx * 8 - 8]
	mov	r11, [rdx + rcx * 8 - 8]
	sbb	r8, r9
	mov	[rdi + rcx * 8 - 16], r8
	jmp	Ltop
	

	global __gmpn_sub_nc
	
	;.def	__gmpn_sub_nc
	;.scl	2
	;.type	32
	;.endef
__gmpn_sub_nc:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rsp + 56]
	jmp	Lstart
	
