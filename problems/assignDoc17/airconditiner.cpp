#define _CRT_SECURE_NO_WARNINGS

#include <fstream>
#include <iostream>
using namespace std;

ifstream inp("airconditiner.inp");
ofstream out("airconditiner.out");

int T;
int room[100002] = {};
int air[100002] = { 0, };

int main() {
    inp >> T;

    int n;
    int k;

    int a;

    for (int i = 0; i < T; i++) {

        inp >> n >> k;

        for (int j = 0; j < k; j++) {
            inp >> a;
            air[j] = a - 1;
        }

        for (int j = 0; j < n; j++) {
            room[j] = 1000000001;
        }

        for (int j = 0; j < k; j++) {
            inp >> a;
            room[air[j]] = a;
        }

        int temp = room[0] + 1;

        for (int j = 1; j < n; j++) {
            if (temp <= room[j]) {
                room[j] = temp;
                temp++;
            }
            else {
                temp = room[j] + 1;
            }
        }

        temp = room[n - 1] + 1;

        for (int j = n - 2; j >= 0; j--) {
            if (temp <= room[j]) {
                room[j] = temp;
                temp++;
            }
            else {
                temp = room[j] + 1;
            }
        }

        for (int j = 0; j < n; j++) {
            out << room[j] << ' ';
           // cout << room[j] << ' ';
        }

        out << "\n";
      //  cout << "\n";
    }

    inp.close();
    out.close();

    return 0;
}
