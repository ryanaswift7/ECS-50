#include <stdio.h>
#include <stdlib.h>

extern int multiply(int n1, int n2);

int main(int argc, char **argv){
	printf("%d\n", multiply(atoi(argv[1]),atoi(argv[2])));
}