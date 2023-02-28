	.globl maxmindiffofthree
	.text

maxmindiffofthree:

	mov	4(%esp), %eax		# access parameters on the stack
	mov	8(%esp), %ecx
	mov	12(%esp), %edx

	mov 	%esp, %edi		# save stack pointer
	pushl	%edx			# setup expected stack frame
	pushl	%ecx
	pushl	%eax

	call 	minofthree		# get the min, result is in eax
	mov	%eax, %esi		# save in an index register, it's ok to do that
					# note that eax is "caller save" so we have to
					# save this result as the callee will change it
	
	# note that, at this point, the stack still contains thre three
	# parameters as the callee did not disrupt the stack frame
	
	call	maxofthree		# get the max, result is in eax

	subl 	%esi, %eax		# compute the difference and return the result
					# in eax

	# now  we are almost ready to return, but, our stack fram is not as expected
	# by the caller. We need to reset the stack pointer to where it was.

	mov %edi, %esp
	ret
