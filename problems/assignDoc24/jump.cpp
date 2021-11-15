#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>
using namespace std;

ifstream inp("jump.inp");
ofstream out("jump.out");

int sol(vector<int>box, int num) {
    int chk = abs(box[0] - box[1]);

    int temp = 0;

    for (int i = 0; i < num - 1; i++) {

        if (i == num - 2) {
            temp = abs(box[i] - box[i + 1]);
        }
        else {
            temp = abs(box[i] - box[i + 2]);
        }

        if (chk < temp) chk = temp;

    }

    if (num % 2 == 0) {
        int chk2 = abs(box[0] - box[1]);
        int temp = 0;
        for (int i = 0; i < num - 4; i++) {
            temp = abs(box[i] - box[i + 2]);
            if (chk2 < temp) chk2 = temp;
        }

        temp = abs(box[num - 1] - box[num - 4]);
        if (chk2 < temp) chk2 = temp;

        temp = abs(box[num - 2] - box[num - 3]);
        if (chk2 < temp) chk2 = temp;

        temp = abs(box[num - 1] - box[num - 2]);
        if (chk2 < temp) chk2 = temp;

        if (chk2 < chk) chk = chk2;
        
    }

    return chk;
}


int main()
{
    int T;
    inp >> T;

    for (int i = 0; i < T; i++) {
        int num;
        int temp;
        vector<int>box;

        inp >> num;
        for (int j = 0; j < num; j++) {

            inp >> temp;
            box.push_back(temp);
        }
        sort(box.begin(),box.end());
        cout << sol(box,num) << endl;
        out << sol(box,num) << endl;
    }8
    /*
    for (int i = 0; i < N - 2; i++) {
        ans = max(ans, abs(L[i] - L[i + 2]));
    }
    */

    inp.close();
    out.close();
    return 0;
}