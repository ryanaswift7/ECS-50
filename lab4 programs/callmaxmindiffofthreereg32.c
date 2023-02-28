/*
 * callminmaxdiffofthreereg.c
 */

#include <stdio.h>

int maxmindiffofthreereg(int a, int b, int c);

int main() {
    printf("%d\n", maxmindiffofthreereg(1, -4, -7));
    printf("%d\n", maxmindiffofthreereg(2, -6, 1));
    printf("%d\n", maxmindiffofthreereg(2, 3, 1));
    printf("%d\n", maxmindiffofthreereg(-2, 4, 3));
    printf("%d\n", maxmindiffofthreereg(2, -6, 5));
    printf("%d\n", maxmindiffofthreereg(2, 4, 6));
    return 0;
}

