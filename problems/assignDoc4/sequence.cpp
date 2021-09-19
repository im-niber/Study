#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
int n;
int check = 0;
int S[1001];
int C[1001];
int T[1001];
int answer[1001];
int flag[1001];
int temp[1001];


void swap(int* a, int* b) {
    int temp;
    temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    FILE* fin = fopen("sequence.inp", "r");
    FILE* fout = fopen("sequence.out", "w");
    fscanf(fin, "%d", &n);

    int t = n;

    for (int i = 0; i < n; i++) {
        fscanf(fin, "%d", &S[i]);
    }
    for (int i = 0; i < n; i++) {
        fscanf(fin, "%d", &C[i]);
    }

    for (int i = n - 1; i > 0; i--) {
        int chk = C[i];
        for (int k = 0; k < n; k++) {
            int count = 0;
            for (int j = 0; j < n; j++) {
                if (S[k] > S[j]) count++;
            }
            if (chk == count) {
                swap(&S[k], &S[i]);
                n--;
                break;
            }
        }
    }

    for (int i = 0; i < t; i++) {
        fprintf(fout, "%d\n", S[i]);
    }


    fclose(fin);
    fclose(fout);
    return 0;
}