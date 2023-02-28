.global multiply
.text

multiply:
	pushl %ebp				# setup stack frame
	movl %esp, %ebp
	

	movl 8(%ebp), %edx		# setup stack vars (ecx=n2, edx=n1)
	movl 12(%ebp), %ecx
	movl $0, %eax			# init eax=0

	cmpl $0, %edx			# check for negative inputs
	js error				# bit shift ruins 2's comp nums
	cmpl $0, %ecx
	js error

mul_loop:
	cmpl $0, %ecx 			# compute ecx-0
	je end_mul				# if bot=0 => done, ret
	shrl $1, %ecx 			# right shift bot by 1 bit into carry
	jnc no_add				# carry not set => bit=0 => don't add
	addl %edx, %eax			# carry set => bit=1 => add top num
	jo error 				# return error if overflow
no_add:
	addl %edx, %edx			# double edx to account for bit shift
	jo error
	jmp mul_loop 			# loop again for next bit

end_mul:
	popl %ebp
	ret

error:
	movl $-1, %eax
	popl %ebp
	ret

