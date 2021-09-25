#define _CRT_SECURE_NO_WARNINGS

#include<stdio.h>
#include<string.h>

int n;
int p;
int persons[500001];
int visited[500001];

FILE* fin = fopen("family.inp", "r");
FILE* fout = fopen("family.out", "w");
int main()
{   
    fscanf(fin, "%d", &n);

    for (int i = 0; i < n; i++) {
        int count = 0;
        fscanf(fin, "%d", &p);
        for (int k = 1; k < p + 1; k++) {
            persons[k] = -1;
            visited[k] = -1;
        }
        int parent;
        int child;
        for (int k = 0; k < p - 1; k++) {
            fscanf(fin, "%d %d", &parent, &child);
            persons[child] = parent;
        }
        for (int k = 1; k < p + 1; k++) {
            visited[persons[k]] = 1;
        }
        int c;

        for (int k = 1; k < p + 1; k++) {
            if (visited[k] == -1) {
                c = k;
                int temp = 0;
                while (persons[c] != -1) {
                    c = persons[c];
                    temp++;
                }
                if (count < temp) count = temp;
            }
        }


        fprintf(fout, "%d\n", count+1);
    }
   
    fclose(fin);
    fclose(fout);
    return 0;
}