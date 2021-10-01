#define _CRT_SECURE_NO_WARNINGS

#include<stdio.h>
#include<stdlib.h>

FILE* fin = fopen("fibonacci.inp", "r");
FILE* fout = fopen("fibonacci.out", "w");

int MOD;

void multiply(unsigned long long F[2][2], unsigned long long M[2][2]);
void power(unsigned long long F[2][2], unsigned long long p);

int fib(unsigned long long p) {
    unsigned long long F[2][2] = { {1,1},{1,0} };
    if (p == 0) return 0;
    power(F, p - 1);
    return F[0][0];
}

void power(unsigned long long F[2][2], unsigned long long p) {

    if (p == 0 || p == 1) return;
    unsigned long long M[2][2] = { {1,1},{1,0} };
    power(F, p / 2);
    multiply(F, F);

    if (p % 2 != 0) multiply(F, M);
}

void multiply(unsigned long long F[2][2], unsigned long long M[2][2]) {
    unsigned long long x = (F[0][0] * M[0][0] + F[0][1] * M[1][0]) % MOD;
    unsigned long long y = (F[0][0] * M[0][1] + F[0][1] * M[1][1]) % MOD;
    unsigned long long z = (F[1][0] * M[0][0] + F[1][1] * M[1][0]) % MOD;
    unsigned long long w = (F[1][0] * M[0][1] + F[1][1] * M[1][1]) % MOD;

    F[0][0] = x;
    F[0][1] = y;
    F[1][0] = z;
    F[1][1] = w;
}

int n;

int main()
{
    fscanf(fin, "%d", &n);


    unsigned long long a, b, c, d;
    unsigned long long fa, fb, fc, fd;

    unsigned long long answer = 0;


    for (int i = 0; i < n; i++) {

        fscanf(fin, "%llu %llu %llu %llu %d", &a, &b, &c, &d, &MOD);
        fa = fib(a);
        fb = fib(b);
        fc = fib(c);
        fd = fib(d);

        answer = (fa * fb + fc * fd) % MOD;
        // printf("%d\n", answer);

        fprintf(fout, "%d\n", answer);
    }
    fclose(fin);
    fclose(fout);
    return 0;
}