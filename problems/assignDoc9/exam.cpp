#define _CRT_SECURE_NO_WARNINGS

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char cases[27];
char temp[1001];
char check[1001];
char mtemp[1001];

FILE* fin = fopen("exam.inp", "r");
FILE* fout = fopen("exam.out", "w");

void solution(char* a, char* b) {
    int chk = 1;
    int w = 0;
    for (int j = 0; j < strlen(a); j++) {
        int flag = 0;

        if (a[j] != b[w]) {
            if (a[j] == '?') {
                for (int p = 0; p < strlen(cases); p++) {
                    if (cases[p] == b[w]) {
                        flag = 1;
                        break;
                    }
                }
                if (flag != 1) {
                    chk = 0;
                    break;
                }
                else {
                    w++;
                    continue;
                }
            }


            else if (a[j] == '*') {
                int con = 0;
                char ch[1001];
                int t = 0;
                for (int p = j; p <= strlen(b) - (strlen(a) - j); p++) {
                    ch[t++] = b[p];
                }
                for (int p = 0; p < t; p++) {
                    flag = 0;
                    for (int z = 0; z < strlen(cases); z++) {
                        if (ch[p] == cases[z]) {
                            flag = 1;
                        }
                    }
                    if (flag == 0) {
                        w = j + t;
                        con = 1;
                        break;
                    }
                }
                if (con == 0) {
                    chk = 0;
                    break;
                }
                continue;
            }
            else {
                chk = 0;
                break;
            }
        }
        w++;
    }
    if (chk == 1) fprintf(fout, "Yes\n");
    else fprintf(fout, "No\n");
}

int n;

int main()
{
    fscanf(fin, "%d", &n);
    int t;
   
    for (int i = 1; i < n + 1; i++) {
        fprintf(fout, "Test Case: #%d\n", i);

        fscanf(fin, "%s", cases);
        fscanf(fin, "%s", temp);
        fscanf(fin, "%d", &t);

        for (int k = 0; k < t; k++) {
            fscanf(fin, "%s", check);
            int chk = 1;
            if (strlen(check) < strlen(temp)) {
                strcpy(mtemp, temp);
                int q = -1; 
                for (int j = 0; j < strlen(temp); j++) {
                    if (temp[j] == '*') {
                        q = j;
                        break;
                    }
                }
                if (q != -1) {
                    for (q; q < strlen(temp) - 1; q++) {
                        mtemp[q] = temp[q + 1];
                    }
                    mtemp[strlen(temp) - 1] = '\0';
                }
                solution(mtemp, check);
            }
            else {
                solution(temp, check);
            }
        }
    }

    fclose(fin);
    fclose(fout);
    return 0;
}