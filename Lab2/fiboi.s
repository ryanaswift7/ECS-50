
.global fibonacci
.text	

fibonacci:

	# setup stack frame
	pushl %ebp			# save prev base ptr
	movl %esp, %ebp		# set base ptr to current stack ptr (bc stack is empty)

	# fibonacci(n) [n is # iterations, f is fibonacci # at n]
	movl 8(%ebp), %ecx 	# param for n moved into ecx

	# need two prev terms to compute, so start by initialzing n=0 & n=1
	movl $1, %edx		# init prev=1
	movl $0, %eax		# init current=0 (n=0 => f=0)


	# perform checks for valid inputs and n=0 and n=1 cases
	cmpl $0, %ecx	# computes n-0
	je send_it		# if n=0, f=0 (already in eax) => ret
	js beep_boop_cannot_compute 	# n < 0, invalid input => ret error

	call swap		# if n=1, f=1 (need to swap edx and eax)
	cmpl $1, %ecx 	# computes n-1
	je send_it		# if n=1, f=1 (now in eax) => ret

	# if you've made it this far, n >= 2
#--------------------------------------------------------------------
	## computes sum of prev 2 nums, keeps sum (eax) and most recent prev num (edx),
	## then decrements counter to see if we're done
	decl %ecx			# takes into account the "decrement" for 1
	
fibonacci_loop:
	addl %eax, %edx 	# eax still holds most recent prev f, but now edx holds the current f
	jo beep_boop_cannot_compute		# if new f overflows => return error
	call swap	# now newest f in eax, and most recent prev f in edx
	dec %ecx
	cmpl $0, %ecx	# computes new n-0
	je send_it		# if n=0, we're done => ret
	jne fibonacci_loop	# if n not zero yet, iterate again


	## uses ebx, edi as temporary registers to swap values of eax and edx
	## (using extra register to swap values should be faster than accessing memory addresses)
swap:
	pushl %eax 	#movl (%eax), %ebx
	pushl %edx 	#movl (%edx), %edi
	popl %eax 	#movl %ebx, (%edx)
	popl %edx 	#movl %edi, (%eax)
	ret



	## returns -1 in the case of an invalid input or overflow of 32 bit signed int
beep_boop_cannot_compute:
	movl $-1, %eax
	popl %ebp
	ret

send_it:
	popl %ebp
	ret


