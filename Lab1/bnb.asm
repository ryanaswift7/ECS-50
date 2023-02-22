// Program implements a BnB dice roll of either two 8-sided dice,
// or one 16-sided die. The outcome of the roll is displayed using
// LEDs on GP0/1/2/5. If an LED is on, then the bit represented by
// that GPIO pin is a 1, and if the LED is off, the bit is a 0.
// The value of the roll can be computed using the formula:
// roll = 1*GP0 + 2*GP1 + 4*GP2 + 8*GP5


// Define standard constants
$w	0
$f	1

// Reserve register to store mode
@mode 	0x08

// Reserve registers to store roll outcome
@roll_num	0x09 // stores the value to be output from either mode

// Reserve register to store output of lfsr
@lfsr 0x0A

// Reserve registers to store circular buffer
@circbuf0	0x10
@circbuf1	0x11
@circbuf2	0x12
@circbuf3	0x13
@circbuf4	0x14
@circbuf5	0x15
@circbuf6	0x16
@circbuf7	0x17
@circbuf8	0x18
@circbuf9	0x19
@circbuf10	0x1A
@circbuf11	0x1B
@circbuf12	0x1C
@circbuf13	0x1D
@circbuf14	0x1E
@circbuf15	0x1F

:origin
	// Set GP0/1/2/5 to output, GP3/4 input
	movlw	00011000b
	tris	6

	// Set starting address for FSR/INDF
	movlw	0x10 // first buffer address
	movwf	FSR

	// Load seed value into lfsr
	movwf	lfsr // any non-zero value will work (0x10 in this case)
	


:start
	btfsc	GPIO, GP3 	// clear=0->start->break waiting loop
	goto	start      	// repeat loop until start is pressed

	// first thing to do once button pressed is read mode
	movlw	0		// 0 = two, 8-sided dice
	btfsc	GPIO, GP4	// clear = mode 0 = switch closed
	movlw	1		// 1 = one, 16-sided die
	movwf	mode	// store initial mode selection (ignore later changes)
	call 	razzle_dazzle //-----------------------
	call	lfsr_galois

	// Determines mode and completes appropriate roll outcome computation
	// Will always compute 1d16z case because that requires fewer instructions
	// than choosing the correct one to go to
	call	get_num_1d16z	// if mode=1, we have one 16-sided die
	movf 	mode,f 			// trigger zero flag 		
	btfsc	STATUS,Z 		// if mode=0, the zero flag will be set
	call	get_num_2d8z	// if mode=1, Z is clear, this will be skipped
							// and 1d16z num will be kept, else get 2d8z num
	

	// Store output in circular buffer
	// Copy current roll value into address of current buffer pointer
	movf 	roll_num,w
	movwf	INDF

	// increment buffer pointer (implement circularity)
	incf	FSR,f 	// move buffer pointer to next position
	movlw	0x0F
	andwf	FSR,f 	// mask everything except bottom 4 bits (0-15)
	movlw 	0x10
	iorwf	FSR,f 	// effectively adds 16 (0001 0000), which
					// maintains range of 0x10 thru 0x1F


	// Set GPIO LEDs to display output
	// pin(bit): GP0(0), GP1(1), GP2(2), GP5(3)
	// GP0 = 1's, GP1 = 2's, GP2 = 4's, GP5 = 8's
	// GPIO: bit set = off, bit clear = on
	// zero flag: bit set = 0, bit clear = nonzero
	// AND is used in output to mask every bit other
	// than the single bit of interest

	// Start by setting lights off (bit = 0), turn on if bit is 1
	bcf 	GPIO,GP0	// turn off light = roll bit 0 = GPIO bit clear
	bcf 	GPIO,GP1
	bcf 	GPIO,GP2
	bcf 	GPIO,GP5

	// Rotates rightmost bit into carry each time
	// Ruins roll_num during process, which is why it was
	// stored prior to output

	// get 1's bit
	rrf 	roll_num,f
	btfsc 	STATUS,C
	bsf 	GPIO,GP0	// turn on light = roll bit 1 = bit set

	// get 2's bit
	rrf 	roll_num,f
	btfsc 	STATUS,C
	bsf 	GPIO,GP1

	// get 4's bit
	rrf 	roll_num,f
	btfsc 	STATUS,C
	bsf 	GPIO,GP2


	// get 8's bit
	rrf 	roll_num,f
	btfsc 	STATUS,C
	bsf 	GPIO,GP5

	goto 	start // roll again!

//---------SUBROUTINES BELOW------------

:razzle_dazzle
	// Give 'em the ol' razzle dazzle
	// as long as button still pressed
	// 0 = on = clear| 1 = off = set
	btfsc	GPIO, GP3 	// check if button released
	//---------------------------------------------------
	retlw	0	// if it is released, generate random number 
	bcf 	GPIO, 5		// light off
	bsf 	GPIO, 5		// light on
	goto	razzle_dazzle


// lsfr_galois implements an 8-bit linear feedback shift register 
// that can be used to generate a pseudo random binary number sequence
// The output sequence can be viewed in the register lfsr.

:lfsr_galois
	// First clear the carry so that we know that it is zero. Now, shift the lfsr right
	// putting the LSB in carry and copying the lfsr into the working register for more
	// processing
	
	bcf 	STATUS,C
	rrf 	lfsr, w
	
	// If the carry (LSB) is set we want to
	// xor the lfsr with our xor taps 8,6,5,4 (0,2,3,4)
	
	btfsc 	STATUS, C
	xorlw 	10111000b
	movwf 	lfsr // save the new lfsr
	retlw 0


// Generate single value from lfsr by taking the bottom 4 bits (0-15)
:get_num_1d16z
		movlw	0x0F
		andwf	lfsr,w
		movwf	roll_num
		retlw	0
		


// Generate 2 values from 2 lfsr values by taking bottom 3 bits
// from current lfsr, then generate another lfsr and repeat, then add them
:get_num_2d8z
	// get outcome for 1st die
	// (stored in roll_num to reduce instruction count)
	movlw	0x07
	andwf	lfsr,w
	movwf	roll_num

	// generate 2nd random number
	call lfsr_galois

	// get outcome for 2nd die
	movlw	0x07
	andwf	lfsr,w
	
	// Sum the two dice and store it
	// (outcome from 2nd die is still in W)
	addwf	roll_num,f
	retlw	0

