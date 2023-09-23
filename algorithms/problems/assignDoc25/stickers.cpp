#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>

using namespace std;

ifstream inp("stickers.inp");
ofstream out("stickers.out");

int solve(int num, vector<int> dp[], vector<int> data[]) {
    int value = 0;
    for (int i = 2; i < num; i++) {
        dp[0].push_back(max(dp[1][i - 1], dp[1][i - 2]) + data[0][i]);
        dp[1].push_back(max(dp[0][i - 1], dp[0][i - 2]) + data[1][i]);
    }
    value = max(dp[0][num - 1], dp[1][num - 1]);
    return value;
}

int main()
{
    int T;

    inp >> T;

    for (int i = 0; i < T; i++) {
        vector <int> data[2];
        vector <int> dp[2];

        int value = 0;
        int num;
        int temp;

        inp >> num;
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < num; k++) {
                inp >> temp;
                data[j].push_back(temp);
            }
        }
        dp[0].push_back(data[0][0]);
        dp[1].push_back(data[1][0]);
        if (num > 1) {
            dp[0].push_back(dp[1][0] + data[0][1]);
            dp[1].push_back(dp[0][0] + data[1][1]);
        }

        value = solve(num, dp, data);
        cout << value << endl;
        out << value << endl;
    }

    inp.close();
    out.close();
    return 0;
}