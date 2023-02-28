/*
 * callmaxofthree.c
 *
 * A small program that illustrates how to call the maxofthree function we wrote in
 * assembly language.
 */

#include <stdio.h>

int minofthree(int a, int b, int c);

int main() {
    printf("%d\n", minofthree(1, -4, -7));
    printf("%d\n", minofthree(2, -6, 1));
    printf("%d\n", minofthree(2, 3, 1));
    printf("%d\n", minofthree(-2, 4, 3));
    printf("%d\n", minofthree(2, -6, 5));
    printf("%d\n", minofthree(2, 4, 6));
    return 0;
}

