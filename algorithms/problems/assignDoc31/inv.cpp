#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>
using namespace std;

ifstream inp("inv.inp");
ofstream out("inv.out");

long long invnum = 0;
int seg[100001 * 4];
pair<int, int> temp[100001];

void update(int n) {
	while (n != 0) {
		seg[n]++;
		n /= 2;
	}
}
int get(int s, int e) {
	int ans = 0;
	while (s <= e) {
		if (s % 2 == 1) ans += seg[s++];
		if (e % 2 == 0) ans += seg[e--];
		s /= 2, e /= 2;
	}
	return ans;
}

int main()
{
    int T;
    inp >> T;

    for (int i = 0; i < T; i++) {
		int num;
        inp >> num;
		int s = 1;
		while (s < num) s *= 2;
		s--;
		for (int i = 1, a; i <= num; i++) {
			inp >> a;
			temp[i] = { -a,-i };
		}
		sort(temp + 1, temp + num + 1);
		for (int i = 1; i <= num; i++) {
			invnum += get(s + 1, s - temp[i].second);
			update(s - temp[i].second);
		}
       

        cout << invnum << endl;
        out << invnum << endl;

		for (int i = 0; i < 400005; i++) {
			seg[i] = 0;
		}
		for (int i = 0; i < 100001; i++) {
			temp[i] = pair<int, int>(0, 0);
		}
		invnum = 0;
    }

    inp.close();
    out.close();
    return 0;
}