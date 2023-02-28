#----------------------------------------------------------------------------
# minofthree.asm
#
# GAS implementation of a function that returns the minimum value of its
# three integer parameters.  The function has prototype:
#
#   int maxofthree(int x, int y, int z)
#
# Note that only eax, ecx, and edx were used so no registers had to be saved
# and restored.
#----------------------------------------------------------------------------	

	.globl	minofthree
	.text

minofthree:
	mov	4(%esp), %eax
	mov	8(%esp), %ecx
	mov	12(%esp), %edx
	cmp	%ecx, %eax
	cmovg	%ecx, %eax
	cmp	%edx, %eax
	cmovg	%edx, %eax
	ret
