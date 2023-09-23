#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int dictionary(char key, char* order) {
    for (int i = 0; i < 13; i++) {
        if (key == order[i]) return i;
    }
}

int main() {
    char c;

    FILE* fin = fopen("bridge.inp", "r");
    FILE* fout = fopen("bridge.out", "w");

    char order[4] = { 'C','D','S','H' };
    char num_order[13] = { '2','3','4','5','6','7','8','9','T','J','Q','K','A' };

    while (true) {
        int t = 0; int z = 0;
        int count;
        char player[5][15][3];
        char chek[4] = { 'S','W','N','E' };
        char line[60];

        fscanf(fin, "%c", &c);
        if (c == '#') {
            break;
        }
        fscanf(fin, "%s", &line);



        for (int j = 0; j < 4; j++) {
            if (chek[j] == c) {
                if (j == 3) {
                    t = 0;
                    break;
                }
                else {
                    t = j + 1;
                    break;
                }
            }
        }

        for (int i = 0; i < 13; i++) {
            count = 0;
            while (count != 4) {
                player[t][i][0] = line[z++];
                player[t][i][1] = line[z++];

                if (z == 52 && i < 7) {
                    fscanf(fin, "%s", &line);
                    z = 0;
                }
                count++; t++;
                if (t == 4) t = 0;
            }
        }
        for (int t = 0; t < 4; t++) {
            for (int i = 0; i < 13; i++) {
                for (int j = i; j < 13; j++) {

                    if (dictionary(player[t][i][0], order) > dictionary(player[t][j][0], order)) {
                        char temp = player[t][i][0];
                        char temp1 = player[t][i][1];

                        player[t][i][0] = player[t][j][0];
                        player[t][i][1] = player[t][j][1];
                        player[t][j][0] = temp;
                        player[t][j][1] = temp1;


                    }
                }
            }
            for (int i = 0; i < 13; i++) {
                for (int j = i; j < 13; j++) {
                    if (player[t][i][0] == player[t][j][0]) {
                        if (dictionary(player[t][i][1], num_order) > dictionary(player[t][j][1], num_order)) {
                            char temp1 = player[t][i][1];
                            player[t][i][1] = player[t][j][1];
                            player[t][j][1] = temp1;

                        }
                    }
                }
            }
        }



        for (int i = 0; i < 4; i++) {

            fprintf(fout, "%c: ", chek[i]);
            for (int k = 0; k < 13; k++) {

                fprintf(fout, "%c%c ", player[i][k][0], player[i][k][1]);
            }

            fprintf(fout, "\n");
        }
        fgetc(fin);
    }

    fclose(fin);
    fclose(fout);
    return 0;
}