#include <stdio.h>
#pragma warning(disable:4996)

// 한수 문제. 각 자리수가 등차수열을 이루는 수를 한수라고함 123 (o) 한자리수 두자리수는 그냥 한수로 취급
// 1000 이하의 입력, 입력된수 까지 한수의 개수를 출력하는 문제


int main() {
	int n, i, k, t, a[3], han; 
  scanf("%d", &n);
  
	for (i = 1; i <= n; i++) {
		if (i < 100) han = i;
		else if (i == 1000) break;
		else {
			k = 0; t = i;
			while (t > 0) {
				a[k] = t % 10;
				t /= 10; k++;
			}
			if (a[0] - a[1] == a[1] - a[2]) han++;
		}
	}
	printf("%d", han);
	return 0;
}



