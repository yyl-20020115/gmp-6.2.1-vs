[Bits 64]
	section .text
	align 16, db 0x90
	global __gmpn_invert_limb
	extern __gmpn_invert_limb_table
	;.def	__gmpn_invert_limb
	;.scl	2
	;.type	32
	;.endef
__gmpn_invert_limb:
		
	push	rdi
	push	rsi
	mov	rdi, rcx

	mov	rax, rdi
	shr	rax, 55
	
	;.byte 0x4c,0x8d,0x05,0x00,0xfe,0xff,0xff
	
	lea	r8, [__gmpn_invert_limb_table - 512]
	movzx	ecx, word [r8 + rax * 2]

	
	mov	rsi, rdi
	mov	eax, ecx
	imul	ecx, ecx
	shr	rsi, 24
	inc	rsi
	imul	rcx, rsi
	shr	rcx, 40
	sal	eax, 11
	dec	eax
	sub	eax, ecx

	
	mov	rcx, 0x1000000000000000
	imul	rsi, rax
	sub	rcx, rsi
	imul	rcx, rax
	sal	rax, 13
	shr	rcx, 47
	add	rcx, rax

	
	mov	rsi, rdi
	shr	rsi, 1
	sbb	rax, rax
	sub	rsi, rax
	imul	rsi, rcx
	and	rax, rcx
	shr	rax, 1
	sub	rax, rsi
	mul	rcx
	sal	rcx, 31
	shr	rdx, 1
	add	rcx, rdx

	mov	rax, rdi
	mul	rcx
	add	rax, rdi
	mov	rax, rcx
	adc	rdx, rdi
	sub	rax, rdx

	pop	rsi
	pop	rdi
	ret
	

