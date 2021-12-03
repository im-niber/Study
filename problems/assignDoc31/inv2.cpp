#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>
#include <queue>

using namespace std;

ifstream inp("inv.inp");
ofstream out("inv.out");

long long invnum = 0;
int numbers[100002] = { 0, };
int temp[100002] = { 0, };

void merge(int left, int mid, int right) {
	int s1 = left, s2 = mid + 1, k = left;

	while (s1 <= mid && s2 <= right) {
		if (numbers[s1] <= numbers[s2]) {
			temp[k++] = numbers[s1++];
		}
		else {
			invnum += (mid - s1 + 1);
			temp[k++] = numbers[s2++];
		}
	}
	if (s1 <= mid) {
		for (int i = s1; i <= mid; i++) temp[k++] = numbers[i];
	}
	else {
		for (int i = s2; i <= right; i++) temp[k++] = numbers[i];
	}
	for (int i = left; i <= right; i++) numbers[i] = temp[i];
}

void mergesort(int left, int right) {
	if (left < right) {
		int mid = (left + right) / 2;
		mergesort(left, mid);
		mergesort(mid + 1, right);
		merge(left, mid, right);
	}
}

int main()
{
    int T;
    inp >> T;

    for (int i = 0; i < T; i++) {
		int num;
        inp >> num;
        for (int k = 1; k <= num; k++) {
            inp >> numbers[k];
        }
        mergesort(1,num);

        cout << invnum << endl;
        out << invnum << endl;

		for (int i = 0; i < 100002; i++) {
			numbers[i] = 0;
			temp[i] = 0;
		}
		invnum = 0;
    }

    inp.close();
    out.close();
    return 0;
}