	.text
	.align	32, 0x90
	.globl	__gmpn_addmul_1
	
	.def	__gmpn_addmul_1
	.scl	2
	.type	32
	.endef
__gmpn_addmul_1:

	push	%rdi
	push	%rsi
	mov	%rcx, %rdi
	mov	%rdx, %rsi
	mov	%r8, %rdx
	mov	%r9, %rcx

	push	%rbx

	mov	(%rsi), %rax
	lea	-8(%rsi,%rdx,8), %rsi
	mov	(%rdi), %r8
	lea	-8(%rdi,%rdx,8), %rdi

	test	$1, %dl
	jnz	Lbx1

Lbx0:	test	$2, %dl
	jnz	Lb10

Lb00:	mov	$3, %ebx
	sub	%rdx, %rbx
	mul	%rcx
	mov	$0, %r11d
	mov	%r8, %r10
	add	%rax, %r10
	mov	-8(%rsi,%rbx,8), %rax
	adc	%rdx, %r11
	jmp	Llo0

Lb10:	mov	$1, %ebx
	sub	%rdx, %rbx
	mul	%rcx
	mov	%r8, %r10
	mov	$0, %r11d
	add	%rax, %r10
	mov	8(%rsi,%rbx,8), %rax
	adc	%rdx, %r11
	jmp	Llo2

Lbx1:	test	$2, %dl
	jz	Lb01

Lb11:	mov	$2, %ebx
	sub	%rdx, %rbx
	mul	%rcx
	add	%rax, %r8
	mov	$0, %r9d
	mov	(%rsi,%rbx,8), %rax
	adc	%rdx, %r9
	jmp	Llo3

Lb01:	mov	$0, %ebx
	sub	%rdx, %rbx
	xor	%r11, %r11
	add	$4, %rbx
	jc	Lend

	.align	32, 0x90
Ltop:	mul	%rcx
	add	%rax, %r8
	mov	$0, %r9d
	mov	-16(%rsi,%rbx,8), %rax
	adc	%rdx, %r9
Llo1:	mul	%rcx
	add	%r11, %r8
	mov	$0, %r11d
	mov	-16(%rdi,%rbx,8), %r10
	adc	$0, %r9
	add	%rax, %r10
	mov	-8(%rsi,%rbx,8), %rax
	adc	%rdx, %r11
	mov	%r8, -24(%rdi,%rbx,8)
	add	%r9, %r10
	adc	$0, %r11
Llo0:	mov	-8(%rdi,%rbx,8), %r8
	mul	%rcx
	add	%rax, %r8
	mov	$0, %r9d
	mov	(%rsi,%rbx,8), %rax
	adc	%rdx, %r9
	mov	%r10, -16(%rdi,%rbx,8)
	add	%r11, %r8
	adc	$0, %r9
Llo3:	mul	%rcx
	mov	(%rdi,%rbx,8), %r10
	mov	$0, %r11d
	add	%rax, %r10
	mov	8(%rsi,%rbx,8), %rax
	adc	%rdx, %r11
	mov	%r8, -8(%rdi,%rbx,8)
	add	%r9, %r10
	adc	$0, %r11
Llo2:	mov	8(%rdi,%rbx,8), %r8
	mov	%r10, (%rdi,%rbx,8)
	add	$4, %rbx
	jnc	Ltop

Lend:	mul	%rcx
	add	%rax, %r8
	mov	$0, %eax
	adc	%rdx, %rax
	add	%r11, %r8
	adc	$0, %rax
	mov	%r8, (%rdi)

	pop	%rbx
	pop	%rsi
	pop	%rdi
	ret
	

