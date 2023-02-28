#include <stdio.h>
#include <stdlib.h>

extern int fibonacci(int n);
int main(int argc, char **argv){
	printf("%d\n", fibonacci(atoi(argv[1])));
	return 0;
}

// test values: -1, 0, 1, 5, 9999999