#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>

int ans;

char temp[20];
char two[6];
char checked[6];
char dice[6];

FILE* fin = fopen("cube.inp", "r");
FILE* fout = fopen("cube.out", "w");

void dfs()
{
	int flag = 0;

	for (int i = 0; i < 6; i++) {
		dice[i] = checked[i];
	}
	for (int j = 1; j <= 4; j++) {
		dice[1] = checked[3];
		dice[2] = checked[1];
		dice[3] = checked[4];
		dice[4] = checked[2];

		for (int i = 0; i < 6; i++) {
			if (two[i] == dice[i]) flag = 1;
			else {
				flag = 0;
				break;
			}
		}

		if (flag == 1) ans = 1;

		for (int i = 0; i < 6; i++) {
			checked[i] = dice[i];
		}
	}
}
int main()
{
	while (true) {
		int check = 0;
		fscanf(fin, "%s", temp);

		for (int i = 0; i < 12; i++) {
			if (temp[0] == temp[i]) check = 1;
			else {
				check = 0;
				break;
			}
		}
		if (check == 1) {
			fprintf(fout, "TRUE");
			break;
		}
		ans = 0;

		for (int i = 0; i < 6; i++) {
			two[i] = temp[i + 6];
			checked[i] = temp[i];
		}

		dfs();
		checked[0] = temp[1]; checked[1] = temp[5]; checked[2] = temp[2]; checked[3] = temp[3]; checked[4] = temp[0]; checked[5] = temp[4];
		dfs();
		checked[0] = temp[2]; checked[1] = temp[5]; checked[2] = temp[4]; checked[3] = temp[1]; checked[4] = temp[0]; checked[5] = temp[3];
		dfs();
		checked[0] = temp[3]; checked[1] = temp[5]; checked[2] = temp[1]; checked[3] = temp[4]; checked[4] = temp[0]; checked[5] = temp[2];
		dfs();
		checked[0] = temp[4]; checked[1] = temp[0]; checked[2] = temp[2]; checked[3] = temp[3]; checked[4] = temp[5]; checked[5] = temp[1];
		dfs();
		checked[0] = temp[5]; checked[1] = temp[4]; checked[2] = temp[2]; checked[3] = temp[3]; checked[4] = temp[1]; checked[5] = temp[0];
		dfs();

		if (ans == 1) fprintf(fout, "TRUE\n");
		else fprintf(fout, "FALSE\n");
	}

	fclose(fin);
	fclose(fout);
	return 0;

}