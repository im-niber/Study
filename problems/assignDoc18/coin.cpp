#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
using namespace std;

ifstream inp("coin.inp");
ofstream out("coin.out");

int T;

int chk[102][102][102] = { 0, };

int main() {
    inp >> T;

    chk[0][0][0] = chk[1][1][0] = chk[1][0][1] = chk[0][1][1] = 
        chk[0][0][2] = chk[0][2][0] = chk[2][0][0] = chk[0][1][2] = chk[0][2][1] =
        chk[1][0][2] = chk[1][2][0] = chk[2][1][0] = chk[2][0][1] = 1;

    chk[0][0][1] = chk[0][1][0] = chk[1][0][0] = chk[1][1][1] = -1;

    for (int i = 0; i < 101; i++) {
        for (int j = 0; j < 101; j++) {
            for (int k = 0; k < 101; k++) {
                bool flag = false;
                if (chk[i][j][k] != 0) continue;
                else {
                    for (int z = 1; z <= 3; z++) {
                        if (i - z  >= 0 && chk[i - z][j][k] == -1) {
                            chk[i][j][k] = 1;
                            flag = true; 
                            break;
                        }
                        if (j - z >= 0 && chk[i][j - z][k] == -1) {
                            chk[i][j][k] = 1;
                            flag = true;
                            break;
                        }
                        if (k - z >= 0 && chk[i][j][k - z] == -1) {
                            chk[i][j][k] = 1;
                            flag = true;
                            break;
                        }
                    }
                    if (!flag) {
                        chk[i][j][k] = -1;
                    }
                }
            }
        }
    }

    int A, B, C;

    for (int i = 0; i < T; i++) {
        int ans;
        inp >> A >> B >> C;
        ans = chk[A][B][C];
        cout << "(" << A << ' ' << B << ' ' << C << ") : " << ans << endl;
        out << "(" << A << ' ' << B << ' ' << C << ") : " << ans << endl;
    }

    inp.close();
    out.close();

    return 0;
}
