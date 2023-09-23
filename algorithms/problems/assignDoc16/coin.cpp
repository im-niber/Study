#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
using namespace std;

ifstream inp("coin.inp");
ofstream out("coin.out");

int T;
int map[2][100002] = { 0, };
int coin[2][100002] = { 0, };

int main() {
    inp >> T;
    for (int i = 0; i < T; i++) {
        int m;
        int max_score = 0;

        inp >> m;

        int bob_max = 210000000;
        int temp_max = 0;

        int count = 0;
        int count2 = 0;

        for (int k = 0; k < 2; k++) {
            for (int j = 0; j < m; j++) {
                inp >> map[k][j];
                if (k == 0) count += map[k][j];
                else {
                    count2 += map[k][j];
                }
            }
        }

        coin[0][0] = count - map[0][0];
        coin[1][0] = 0;

        for (int k = 1; k < m; k++) {
            coin[0][k] = coin[0][k - 1] - map[0][k];
            coin[1][k] = coin[1][k - 1] + map[1][k - 1];
        }


        for (int k = 0; k < m; k++) {
            if (coin[0][k] < coin[1][k]) {
                if (bob_max > coin[1][k]) bob_max = coin[1][k];
            }
            else {
                if (bob_max > coin[0][k]) bob_max = coin[0][k];
            }
        }

        cout << bob_max << endl;
        out << bob_max << endl;

    }

    inp.close();
    out.close();

    return 0;
}