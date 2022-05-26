[Bits 64]
	align 64, db 0x90
	global __gmpn_com
	
	;.def	__gmpn_com
	;.scl	2
	;.type	32
	;.endef
__gmpn_com:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8


	cmp	rdx, 7
	jbe	Lbc

	pcmpeqb	xmm5, xmm5

	test	dil, 8
	jz	Lrp_aligned

	mov	r8, [rsi]
	lea	rsi, [rsi + 8]
	not	r8
	mov	[rdi], r8
	lea	rdi, [rdi + 8]
	dec	rdx

Lrp_aligned:
	test	sil, 8
	jnz	Luent

	jmp	Lam

	align 16, db 0x90
Latop:
movaps	xmm0, [rsi + 0]
	movaps	xmm1, [rsi + 16]
	movaps	xmm2, [rsi + 32]
	movaps	xmm3, [rsi + 48]
	lea	rsi, [rsi + 64]
	pxor	xmm0, xmm5
	pxor	xmm1, xmm5
	pxor	xmm2, xmm5
	pxor	xmm3, xmm5
	movaps	[rdi], xmm0
	movaps	[rdi + 16], xmm1
	movaps	[rdi + 32], xmm2
	movaps	[rdi + 48], xmm3
	lea	rdi, [rdi + 64]
Lam:
	sub	rdx, 8
	jnc	Latop

	test	dl, 4
	jz	_1
	movaps	xmm0, [rsi]
	movaps	xmm1, [rsi + 16]
	lea	rsi, [rsi + 32]
	pxor	xmm0, xmm5
	pxor	xmm1, xmm5
	movaps	[rdi], xmm0
	movaps	[rdi + 16], xmm1
	lea	rdi, [rdi + 32]

_1:
	test	dl, 2
	jz	_2
	movaps	xmm0, [rsi]
	lea	rsi, [rsi + 16]
	pxor	xmm0, xmm5
	movaps	[rdi], xmm0
	lea	rdi, [rdi + 16]

_2:
	test	dl, 1
	jz	_3
	mov	r8, [rsi]
	not	r8
	mov	[rdi], r8

_3:
	pop	rsi
	pop	rdi
	ret

Luent:




	lea	rax, [rsi - 40]
	sub	rax, rdi
	cmp	rax, 80
	jbe	Lbc

	sub	rdx, 16
	jc	Luend

	movaps	xmm3, [rsi + 120]

	sub	rdx, 16
	jmp	Lum

	align 16, db 0x90
Lutop:
movaps	xmm3, [rsi + 120]
	pxor	xmm0, xmm5
	movaps	[rdi - 128], xmm0
	sub	rdx, 16
Lum:
	movaps	xmm2, [rsi + 104]
	db 0x66,0x0f,0x3a,0x0f,218,8
	movaps	xmm1, [rsi + 88]
	pxor	xmm3, xmm5
	movaps	[rdi + 112], xmm3
	db 0x66,0x0f,0x3a,0x0f,209,8
	movaps	xmm0, [rsi + 72]
	pxor	xmm2, xmm5
	movaps	[rdi + 96], xmm2
	db 0x66,0x0f,0x3a,0x0f,200,8
	movaps	xmm3, [rsi + 56]
	pxor	xmm1, xmm5
	movaps	[rdi + 80], xmm1
	db 0x66,0x0f,0x3a,0x0f,195,8
	movaps	xmm2, [rsi + 40]
	pxor	xmm0, xmm5
	movaps	[rdi + 64], xmm0
	db 0x66,0x0f,0x3a,0x0f,218,8
	movaps	xmm1, [rsi + 24]
	pxor	xmm3, xmm5
	movaps	[rdi + 48], xmm3
	db 0x66,0x0f,0x3a,0x0f,209,8
	movaps	xmm0, [rsi + 8]
	pxor	xmm2, xmm5
	movaps	[rdi + 32], xmm2
	db 0x66,0x0f,0x3a,0x0f,200,8
	movaps	xmm3, [rsi - 8]
	pxor	xmm1, xmm5
	movaps	[rdi + 16], xmm1
	db 0x66,0x0f,0x3a,0x0f,195,8
	lea	rsi, [rsi + 128]
	lea	rdi, [rdi + 128]
	jnc	Lutop

	pxor	xmm0, xmm5
	movaps	[rdi - 128], xmm0

Luend:
test	dl, 8
	jz	_4
	movaps	xmm3, [rsi + 56]
	movaps	xmm2, [rsi + 40]
	db 0x66,0x0f,0x3a,0x0f,218,8
	movaps	xmm1, [rsi + 24]
	pxor	xmm3, xmm5
	movaps	[rdi + 48], xmm3
	db 0x66,0x0f,0x3a,0x0f,209,8
	movaps	xmm0, [rsi + 8]
	pxor	xmm2, xmm5
	movaps	[rdi + 32], xmm2
	db 0x66,0x0f,0x3a,0x0f,200,8
	movaps	xmm3, [rsi - 8]
	pxor	xmm1, xmm5
	movaps	[rdi + 16], xmm1
	db 0x66,0x0f,0x3a,0x0f,195,8
	lea	rsi, [rsi + 64]
	pxor	xmm0, xmm5
	movaps	[rdi], xmm0
	lea	rdi, [rdi + 64]

_4:
	test	dl, 4
	jz	_5
	movaps	xmm1, [rsi + 24]
	movaps	xmm0, [rsi + 8]
	db 0x66,0x0f,0x3a,0x0f,200,8
	movaps	xmm3, [rsi - 8]
	pxor	xmm1, xmm5
	movaps	[rdi + 16], xmm1
	db 0x66,0x0f,0x3a,0x0f,195,8
	lea	rsi, [rsi + 32]
	pxor	xmm0, xmm5
	movaps	[rdi], xmm0
	lea	rdi, [rdi + 32]

_5:
	test	dl, 2
	jz	_6
	movaps	xmm0, [rsi + 8]
	movaps	xmm3, [rsi - 8]
	db 0x66,0x0f,0x3a,0x0f,195,8
	lea	rsi, [rsi + 16]
	pxor	xmm0, xmm5
	movaps	[rdi], xmm0
	lea	rdi, [rdi + 16]

_6:
	test	dl, 1
	jz	_7
	mov	r8, [rsi]
	not	r8
	mov	[rdi], r8

_7:
	pop	rsi
	pop	rdi
	ret




Lbc:
	lea	rdi, [rdi - 8]
	sub	edx, 4
	jc	Lend

	align 16, db 0x90
Ltop:
	mov	r8, [rsi]
	mov	r9, [rsi + 8]
	lea	rdi, [rdi + 32]
	mov	r10, [rsi + 16]
	mov	r11, [rsi + 24]
	lea	rsi, [rsi + 32]
	not	r8
	not	r9
	not	r10
	not	r11
	mov	[rdi - 24], r8
	mov	[rdi - 16], r9
	sub	edx, 4
	mov	[rdi - 8], r10
	mov	[rdi], r11
	jnc	Ltop

Lend:
	test	dl, 1
	jz	_8
	mov	r8, [rsi]
	not	r8
	mov	[rdi + 8], r8
	lea	rdi, [rdi + 8]
	lea	rsi, [rsi + 8]
_8:
	test	dl, 2
	jz	_9
	mov	r8, [rsi]
	mov	r9, [rsi + 8]
	not	r8
	not	r9
	mov	[rdi + 8], r8
	mov	[rdi + 16], r9
_9:
	pop	rsi
	pop	rdi
	ret
	

