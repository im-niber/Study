#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main() {
    int n;

    FILE* fin = fopen("cross.inp", "r");
    FILE* fout = fopen("cross.out", "w");

    fscanf(fin, "%d", &n);

    for (int i = 1; i < n + 1; i++) {
        int temp[10002];
        int temp1[10002];
        int count = 0;
        int length;
        fscanf(fin, "%d", &length);

        for (int k = 0; k < length; k++) {
            fscanf(fin, "%d", &temp[k]);
        }

        for (int k = 0; k < length; k++) {
            fscanf(fin, "%d", &temp1[k]);
        }

        int pointed[10002];
        int pointed2[10002];

        for (int k = 0; k < length; k++) {
            pointed[temp1[k]] = k;
            pointed2[temp[k]] = k;
        }


        for (int k = 0; k < length; k++) {
            for (int j = 0; j < pointed[temp[k]]; j++) {
                if (pointed2[temp1[j]] > k) count++;
            }
        }
        //printf("%d", count);

        fprintf(fout, "Case %d: %d\n", i, count);

    }

    fclose(fin);
    fclose(fout);
    return 0;
}