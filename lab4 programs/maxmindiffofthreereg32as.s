	.globl maxmindiffofthreereg
	.text

maxmindiffofthreereg:

	mov	4(%esp), %eax		# access parameters on the stack
	mov	8(%esp), %ecx
	mov	12(%esp), %edx

	call 	minofthreereg		# get the min, result is in eax
	mov	%eax, %esi		# save in an index register, it's ok to do that
					# note that eax is "caller save" so we have to
					# save this result as the callee will change it

	mov	4(%esp), %eax		# access first parameter on the stack
					# remaining parameters are undisturbed
	call	maxofthreereg		# get the max, result is in eax

	subl 	%esi, %eax		# compute the difference and return the result
					# in eax
	ret

#----------------------------------------------------------------------------	
# Note that in the register versions of these routines that they are assuming
# that the parameters are not being passed on the stack. That is, these are 
# not following the "C" calling convention. Rather, we are imposing our own 
# simplified calling convention. Note also that we could simply include this 
# code inline above.
#----------------------------------------------------------------------------
	.text

maxofthreereg:
	cmp	%ecx, %eax
	cmovl	%ecx, %eax
	cmp	%edx, %eax
	cmovl	%edx, %eax
	ret

	.text

minofthreereg:
	cmp	%ecx, %eax
	cmovg	%ecx, %eax
	cmp	%edx, %eax
	cmovg	%edx, %eax
	ret
