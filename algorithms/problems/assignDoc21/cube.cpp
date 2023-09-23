#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
using namespace std;

ifstream inp("cube.inp");
ofstream out("cube.out");

int maxx = 123456789;
int sol[201][201][201] = { 0, };

int T;
int main() {

    inp >> T;

    for (int i = 1; i < 201; i++) {
        for (int j = 1; j < 201; j++) {
            for (int k = 1; k < 201; k++) {
                sol[i][j][k] = maxx;
            }
        }
    }

    sol[1][1][1] = 1;
    
    for (int k = 2; k < 201; k++) {
        sol[1][1][k] = sol[1][1][k - 1] + 1;
        sol[1][k][1] = sol[1][k - 1][1] + 1;
        sol[k][1][1] = sol[k - 1][1][1] + 1;
        sol[k][k][k] = 1;
    }

    for (int i = 1; i < 201; i++) {
        for (int k = 1; k < 201; k++) {
            for (int j = 1; j < 201; j++) {
                if (sol[i][k][j] == maxx) {
                    if (i == 1) {
                        sol[i][k][j] = j * k;
                    }
                    else if (k == 1) {
                        sol[i][k][j] = i * j;
                    }
                    else if (j == 1) {
                        sol[i][k][j] = i * k;
                    }
                    else {
                        int& tmp = sol[i][k][j];
                        for (int z = 1; z < i / 2 + 1; z++) {
                            tmp = min(tmp, sol[z][k][j] + sol[i - z][k][j]);
                        }
                        for (int z = 1; z < k / 2 + 1; z++) {
                            tmp = min(tmp, sol[i][z][j] + sol[i][k - z][j]);
                        }
                        for (int z = 1; z < j / 2 + 1; z++) {
                            tmp = min(tmp, sol[i][k][z] + sol[i][k][j - z]);
                        }
                        sol[i][j][k] = tmp;
                        sol[i][k][j] = tmp;
                        sol[k][i][j] = tmp;
                        sol[k][j][i] = tmp;
                        sol[j][i][k] = tmp;
                        sol[j][k][i] = tmp;

                    }
                }
            }
        }
    }

    for (int i = 0; i < T; i++) {
        int w, l, h;
        inp >> w >> l >> h;

        cout << sol[w][l][h] << endl; 
        out << sol[w][l][h] << endl;
    }
   
    inp.close();
    out.close();

    return 0;
}