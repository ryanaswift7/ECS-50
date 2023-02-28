In this lab you will write x86 assembly language routines that will work with the C programming language. For each assembly language routine you must write a test routine in C that takes parameters from the command line and provides appropriate input to the assembly language routine. You will write all routines in 32 bit assembly using the GAS format. 

 

# 1) Fibonacci -Iterative

This routine will take an integer n as a parameter and will report back the nth Fibonacci number. Your assembler routine must be iterative. If the number cannot be computed in a 32 bit signed integer then your routine must return -1 as an error code. Your test routine will take a number n from the command line and will print out the nth Fibonacci number, or -1, on a line by itself. 

submit : testfiboi.c fiboi.s


# 2) Fibonacci -Recursive

This routine will take an integer n as a parameter and will report back the nth Fibonacci number. Your assembler routine must be recursive. If the number cannot be computed in a 32 bit signed integer then your routine must return -1 as an error code. Your test routine will take a number n from the command line and will print out the nth Fibonacci number, or -1, on a line by itself. 

submit : testfibor.c fibor.s

# 3) 32 Bit unsigned multiply using shift and add

Using the shift and add algorithm

Links to an external site. your routine will take two 32 bit integer values and return a 32 bit integer product. If the result overflows, your routine will return a -1. Note that you are using normal signed integers as input but your routine should only workswith non-negative values.  You may not use any x86 multiply instructions to solve this problem. Your test routine will take two numbers n1, n2 from the command line and will print out n1*n2 , or -1, on a line by itself. 

submit : testmul.c mul.s

## Fibonacci Notes

For the Fibonacci routines F(0)= 0 and F(1) = 1. 

## Error Checking

    You cannot assume that you will receive only valid inputs. 
    You can assume that all inputs will be integers.
    You can assume that you will be passed the correct number of inputs. 
    You may not do any error checking in the C code. This is a class in assembly language, check for all out of bounds conditions in assembler. The C code should simply parse the command line into integers and pass those on to the assembly routines, and then print the returned value. No more, no less.  

## Update 2/27

There are two requirements that were not specified but are necessary. If you've already submitted you may have to edit your submission. There is time, these are minor. 

    First, you must use consistent naming for the functions.
        For both Fibonacci programs your assembler function must be named fibonacci
        For the multiply program your assembler function must be named multiply

    For Fibonacci, you must test for overflow in the arithmetic as opposed to simply testing for some "magic number" for a bound for Fibonacci.  It is bad coding style to test for magic numbers. If you don't want to change this and your code still works, that's ok, but you will lose some points for style. Since I've pointed this out, it will be line-item in the TA's grading guidelines. 

