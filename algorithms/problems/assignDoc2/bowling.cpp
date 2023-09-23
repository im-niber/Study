#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

typedef struct score {
    int x;
    int x1 = 0;
    int x2 = 0;
    int chk = 0;
};

int main() {
    int n;

    FILE* fin = fopen("1.inp", "r");
    FILE* fout = fopen("bridge.txt", "w");

    fscanf(fin, "%d", &n);

    for (int i = 0; i < n; i++) {
        score temp[11];
        int frame[11];
        frame[0] = 0;
        for (int k = 0; k < 10; k++) {
            if (k == 9) {
                fscanf(fin, "%d %d", &temp[k].x, &temp[k].x1);
                if (temp[k].x + temp[k].x1 == 10 || temp[k].x == 10) {
                    fscanf(fin, "%d", &temp[k].x2);
                }
            }
            else {
                fscanf(fin, "%d", &temp[k].x);
                if (temp[k].x != 10) {
                    fscanf(fin, "%d", &temp[k].x1);
                    if (temp[k].x + temp[k].x1 == 10) temp[k].chk = 2;
                }
                else temp[k].chk = 1;

            }

        }
        for (int k = 1; k < 11; k++) {
            if (temp[k - 1].chk == 0) {
                frame[k] = frame[k - 1] + temp[k - 1].x + temp[k - 1].x1 + temp[k - 1].x2;
                continue;
            }
            if (temp[k - 1].chk == 2) {
                frame[k] = frame[k - 1] + temp[k - 1].x + temp[k - 1].x1 + temp[k - 1].x2 + temp[k].x;
                continue;
            }
            if (temp[k - 1].chk == 1) {
                frame[k] = frame[k - 1] + temp[k - 1].x + temp[k - 1].x1;
                if (temp[k].chk == 1) {
                    frame[k] += temp[k].x + temp[k + 1].x;
                }
                else frame[k] += temp[k].x + temp[k].x1;
                continue;
            }
        }
        //printf("%d", frame[10]);

        fprintf(fout, "%d\n", frame[10]);

    }

    fclose(fin);
    fclose(fout);
    return 0;
}