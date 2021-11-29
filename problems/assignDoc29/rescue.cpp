#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>

using namespace std;

ifstream inp("rescue.inp");
ofstream out("rescue.out");

int main()
{
    int T;
    inp >> T;

    for (int i = 0; i < T; i++) {
        int person = 0;
        int stage[10001] = { 0, };
        int dp[10001] = { 0, };

        int total;
        inp >> total;
        
        for (int k = 1; k <= total; k++) {
            int a;
            inp >> a;
            stage[k] = a;
        }
        
        dp[1] = max(stage[1], stage[0] + stage[1]);
        dp[2] = max(stage[1] + stage[2], stage[0] + stage[2]);
        for (int k = 3; k <= total; k++) {
            dp[k] = max(dp[k - 2], dp[k - 3] + stage[k-1]) + stage[k];
        }

      //  cout << dp[total] << endl;
        out << dp[total] << endl;
    }

    inp.close();
    out.close();
    return 0;
}