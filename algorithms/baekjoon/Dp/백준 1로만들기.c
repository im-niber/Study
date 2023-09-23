#include <studio.h>
#pragma warning(disable:4996)

// 1. x 가 3으로 나누어 떨어지면 3으로 나눔
// 2. x가 2로 나누어 떨어지면 2로나눔
// 3. 1을 뺀다.
// 위 세 연산을 적절히 사용하여서 연산횟수의 최솟값을 출력.

int Dp[1000001];

int min(int a, int b) {
	return a > b ? b : a;
}

int main(void) {

	int N;
	scanf("%d", &N);

	Dp[1] = 0;

	for (int i = 2; i <= N; i++)
	{
		Dp[i] = Dp[i - 1] + 1;
		if (i % 2 == 0)
			Dp[i] = min(Dp[i], Dp[i / 2] + 1);
		if (i % 3 == 0)
			Dp[i] = min(Dp[i], Dp[i / 3] + 1);
	}

	printf("%d\n", Dp[N]);
	return 0;
	
