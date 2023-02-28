#----------------------------------------------------------------------------
# maxofthree.asm
#
# GAS implementation of a function that returns the maximum value of its
# three integer parameters.  The function has prototype:
#
#   int maxofthree(int x, int y, int z)
#
# Note that only eax, ecx, and edx were used so no registers had to be saved
# and restored.
#----------------------------------------------------------------------------	

	.globl	maxofthree
	.text

maxofthree:
	mov	4(%esp), %eax
	mov	8(%esp), %ecx
	mov	12(%esp), %edx
	cmp	%ecx, %eax
	cmovl	%ecx, %eax
	cmp	%edx, %eax
	cmovl	%edx, %eax
	ret
