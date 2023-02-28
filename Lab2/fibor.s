.global fibonacci
.text

fibonacci:
	pushl %ebp			# setup stack frame
	movl %esp, %ebp

	movl 8(%ebp), %edi	# edi holds n

	pushl %eax 		# save prev value of eax

	# check if edi is negative or zero
	movl $0, %eax
	cmpl %eax, %edi		# compute edi-0
	je base_case		# return if edi is 0
	js error			# neg inputs are invalid

	# check if edi is 1
	movl $1, %eax
	cmpl %eax, %edi 	# compute edi-1
	je base_case

	popl %eax		# reload prev eax value

#------- if reach here, 2 <= n <= 41 -------------------------

	# calculate f(n-1) and store in ecx
	decl %edi
	pushl %edi
	call fibonacci
	popl %edi

	# if edi=-1, there's an overflow and we need to pass it up the recursion
	cmpl $0, %edi
	js error

	pushl %eax
	popl %ecx
	pushl %ecx		# save ecx

	# calculate f(n-2), automatically returns to eax
	decl %edi
	pushl %edi
	call fibonacci
	popl %edi

	# if edi=-1, there's an overflow and we need to pass it up the recursion
	cmpl $0, %edi
	js error

	popl %ecx 		# restore ecx

	# add them together to get f(n), store in eax
	addl %ecx, %eax
	jo OF_error			# return error message if too big for 32 signed bits

end:
	popl %ebp
	ret


base_case:
	popl %eax
	movl %edi, %eax
	popl %ebp
	ret

error:
	popl %eax
	movl $-1, %edi
	movl $-1, %eax
	popl %ebp
	ret

OF_error: 
	movl $-1, %eax
	popl %ebp
	ret




