#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
#include <string.h>
using namespace std;

ifstream inp("backspace.inp");
ofstream out("backspace.out");

int T;
string s, t;

bool solve(int j, bool flag) {
    int k = t.length() - 1;

    while (j >= 0 && k >= 0) {
        if (s[j] == t[k]) {
            j--;
            k--;
        }
        else {
            j -= 2;
        }
    }
    if (k == -1) flag = true;

    return flag;

}

int main() {
    inp >> T;

    for (int i = 0; i < T; i++) {
        bool flag = false;

        inp >> s;
        inp >> t;

        if (s.length() < t.length()) {
            //  cout << "NO\n";
            out << "NO\n";
            continue;
        }
        int idx = t.length() - 1;

        for (int j = s.length() - 1; j >= 0; j -= 2) {
            if (s[j] == t[idx]) {
                flag = solve(j, flag);
                break;
            }

        }
        if (flag) {
            out << "YES\n";
            //   cout << "YES\n";
        }
        else {
            out << "NO\n";
            //   cout << "NO\n";
        }
    }

    inp.close();
    out.close();
    return 0;
}