[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_mod_34lsub1
	
	;.def	__gmpn_mod_34lsub1
	;.scl	2
	;.type	32
	;.endef
__gmpn_mod_34lsub1:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx


	mov	r11, 0x0000FFFFFFFFFFFF

	mov	rax, [rdi]

	cmp	rsi, 2
	ja	Lgt2

	jb	Lone

	mov	rsi, [rdi + 8]
	mov	rdx, rax
	shr	rax, 48

	and	rdx, r11
	add	rax, rdx
	mov	edx, esi

	shr	rsi, 32
	add	rax, rsi

	shl	rdx, 16
	add	rax, rdx
Lone:
	pop	rsi
	pop	rdi
	ret





Lgt2:
	mov	rcx, [rdi + 8]
	mov	rdx, [rdi + 16]
	xor	r9, r9
	add	rdi, 24
	sub	rsi, 12
	jc	Lend
	align 16, db 0x90
Ltop:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	adc	r9, 0
	add	rax, [rdi + 24]
	adc	rcx, [rdi + 32]
	adc	rdx, [rdi + 40]
	adc	r9, 0
	add	rax, [rdi + 48]
	adc	rcx, [rdi + 56]
	adc	rdx, [rdi + 64]
	adc	r9, 0
	add	rdi, 72
	sub	rsi, 9
	jnc	Ltop

Lend:
	lea	r8, [Ltab]
	;.byte 0x4c,0x8d,0x05,0x00,0x00,0x00,0x00
	movsx	r10, dword [r8 + rsi * 4 + 36]
	add	r8, r10
	jmp	r8

		section .rdata
	align 8, db 0x90
Ltab:
	dd L0-Ltab
	dd L1-Ltab
	dd L2-Ltab
	dd L3-Ltab
	dd L4-Ltab
	dd L5-Ltab
	dd L6-Ltab
	dd L7-Ltab
	dd L8-Ltab
	section .text

L6:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	adc	r9, 0
	add	rdi, 24
L3:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	jmp	Lcj1

L7:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	adc	r9, 0
	add	rdi, 24
L4:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	adc	r9, 0
	add	rdi, 24
L1:
	add	rax, [rdi]
	adc	rcx, 0
	jmp	Lcj2

L8:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	adc	r9, 0
	add	rdi, 24
L5:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]
	adc	rdx, [rdi + 16]
	adc	r9, 0
	add	rdi, 24
L2:
	add	rax, [rdi]
	adc	rcx, [rdi + 8]

Lcj2:
	adc	rdx, 0
Lcj1:
	adc	r9, 0
L0:
	add	rax, r9
	adc	rcx, 0
	adc	rdx, 0
	adc	rax, 0

	mov	rdi, rax
	shr	rax, 48

	and	rdi, r11
	mov	r10d, ecx

	shr	rcx, 32

	add	rax, rdi
	movzx	edi, dx
	shl	r10, 16

	add	rax, rcx
	shr	rdx, 16

	add	rax, r10
	shl	rdi, 32

	add	rax, rdx
	add	rax, rdi

	pop	rsi
	pop	rdi
	ret
	
