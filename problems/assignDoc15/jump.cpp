#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
using namespace std;

ifstream inp("jump.inp");
ofstream out("jump.out");

int T;
int temp[100002] = { 0, };
int ans[100002] = { 0, };


int main() {
    inp >> T;
    for (int i = 0; i < T; i++) {
        int max_result = 0;

        int n;
        inp >> n;


        for (int j = 1; j < n + 1; j++) {
            inp >> temp[j];
        }

        for (int j = n; j > 0; j--) {
            if (j + temp[j] > n) {
                ans[j] = temp[j];

                if (max_result < temp[j]) max_result = temp[j];

            }
            else {
                ans[j] = temp[j] + ans[j + temp[j]];
                if (ans[j] + j> n) {
                    if (max_result < ans[j]) max_result = ans[j];
                }
            }
        }

        out << max_result << endl;
        cout << max_result << endl;
    }

    inp.close();
    out.close();

    return 0;
}