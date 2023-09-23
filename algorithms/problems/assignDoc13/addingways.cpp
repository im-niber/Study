#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
using namespace std;
#define MOD 1000000007;

ifstream inp("addingways.inp");
ofstream out("addingways.out");

int answer;

int main() {
    while (true) {
        int temp[302][302] = { 0, };
        int n, k;
        inp >> n >> k;

        if (n == 0 && k == 0) break;
        answer = 0;

        if (k == 1 || n == k) {
            answer = 1;
            out << answer;
            out << '\n';
            continue;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 21; j++) {
                if (j == 1 || i == j)temp[i][j] = 1;
                else if (j < i) {
                    temp[i][j] = temp[i - 1][j - 1] + temp[i - j][j];
                    temp[i][j] %= MOD;
                }
            }
        }
        temp[n][k] %= MOD;

        printf("%d\n", temp[n][k]);
        out << temp[n][k] << endl;
    }

    inp.close();
    out.close();
    return 0;
}