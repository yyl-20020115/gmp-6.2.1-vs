[Bits 64]
	section .text
	align 32, db 0x90
	global __gmpn_nand_n
	
	;.def	__gmpn_nand_n
	;.scl	2
	;.type	32
	;.endef
__gmpn_nand_n:

	push	rdi
	push	rsi
	mov	rdi, rcx
	mov	rsi, rdx
	mov	rdx, r8
	mov	rcx, r9

	mov	r8, [rdx]
	mov	eax, ecx
	and	eax, 3
	je	Lb00
	cmp	eax, 2
	jc	Lb01
	je	Lb10

Lb11:
	and	r8, [rsi]
	not	r8
	mov	[rdi], r8
	inc	rcx
	lea	rsi, [rsi - 8]
	lea	rdx, [rdx - 8]
	lea	rdi, [rdi - 8]
	jmp	Le11
Lb10:
	add	rcx, 2
	lea	rsi, [rsi - 16]
	lea	rdx, [rdx - 16]
	lea	rdi, [rdi - 16]
	jmp	Le10
Lb01:
	and	r8, [rsi]
	not	r8
	mov	[rdi], r8
	dec	rcx
	jz	Lret
	lea	rsi, [rsi + 8]
	lea	rdx, [rdx + 8]
	lea	rdi, [rdi + 8]

	align 16, db 0x90
Ltop:
	mov	r8, [rdx]
Lb00:
	mov	r9, [rdx + 8]
	and	r8, [rsi]
	not	r8
	and	r9, [rsi + 8]
	not	r9
	mov	[rdi], r8
	mov	[rdi + 8], r9
Le11:
	mov	r8, [rdx + 16]
Le10:
	mov	r9, [rdx + 24]
	lea	rdx, [rdx + 32]
	and	r8, [rsi + 16]
	not	r8
	and	r9, [rsi + 24]
	lea	rsi, [rsi + 32]
	not	r9
	mov	[rdi + 16], r8
	mov	[rdi + 24], r9
	lea	rdi, [rdi + 32]
	sub	rcx, 4
	jnz	Ltop

Lret:
	pop	rsi
	pop	rdi
	ret
	

