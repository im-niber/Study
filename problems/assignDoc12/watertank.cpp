#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
using namespace std;

FILE* fin = fopen("watertank.inp", "r");
FILE* fout = fopen("watertank.out", "w");

int M_map[1002][1002];
int N_map[1002][1002];
int tank[1002][1002];

int N, M, H;

struct item {
    int x, y, h;
};

struct cp {
    bool operator () (item x, item y) {
        if (x.h > y.h) return true;
        else return false;
    }
};

priority_queue<item, vector <item>,cp> pq;

void bfs() {
    item temp;

    while (pq.size())
    {
        temp = pq.top();
        int x = temp.x, y = temp.y, h2 = temp.h;
        pq.pop();

        if (h2 != tank[x][y])
            continue;

        if (x > 1 && M_map[x][y] != -1 && tank[x - 1][y] > M_map[x][y] && tank[x][y] <= M_map[x][y])
        {
            tank[x - 1][y] = M_map[x][y];
            temp.x = x - 1; temp.y = y; temp.h = tank[x - 1][y];
            pq.push(temp);
        }
        else if (x > 1 && M_map[x][y] != -1 && tank[x][y] >= M_map[x][y] && tank[x - 1][y] > tank[x][y])
        {
            tank[x - 1][y] = tank[x][y];
            temp.x = x - 1; temp.y = y; temp.h = tank[x - 1][y];
            pq.push(temp);
        }

        if (x < N && M_map[x + 1][y] != -1 && tank[x + 1][y] > M_map[x + 1][y] && tank[x][y] <= M_map[x + 1][y])
        {
            tank[x + 1][y] = M_map[x + 1][y];
            temp.x = x + 1; temp.y = y; temp.h = tank[x + 1][y];
            pq.push(temp);
        }
        else if (x < N && M_map[x + 1][y] != -1 && tank[x][y] >= M_map[x + 1][y] && tank[x + 1][y] > tank[x][y])
        {
            tank[x + 1][y] = tank[x][y];
            temp.x = x + 1; temp.y = y; temp.h = tank[x + 1][y];
            pq.push(temp);
        }

        if (y > 1 && N_map[x][y] != -1 && tank[x][y - 1] > N_map[x][y] && tank[x][y] <= N_map[x][y])
        {
            tank[x][y - 1] = N_map[x][y];
            temp.x = x; temp.y = y - 1; temp.h = tank[x][y - 1];
            pq.push(temp);
        }
        else if (y > 1 && N_map[x][y] != -1 && tank[x][y] >= N_map[x][y] && tank[x][y - 1] > tank[x][y])
        {
            tank[x][y - 1] = tank[x][y];
            temp.x = x; temp.y = y - 1; temp.h = tank[x][y - 1];
            pq.push(temp);
        }

        if (y < M && N_map[x][y + 1] != -1 && tank[x][y + 1] > N_map[x][y + 1] && tank[x][y] <= N_map[x][y + 1])
        {
            tank[x][y + 1] = N_map[x][y + 1];
            temp.x = x; temp.y = y + 1; temp.h = tank[x][y + 1];
            pq.push(temp);
        }
        else if (y < M && N_map[x][y + 1] != -1 && tank[x][y] >= N_map[x][y + 1] && tank[x][y + 1] > tank[x][y])
        {
            tank[x][y + 1] = tank[x][y];
            temp.x = x; temp.y = y + 1; temp.h = tank[x][y + 1];
            pq.push(temp);
        }
    }

}
int main() {
    int n;

    fscanf(fin,"%d", &n);

    for (int i = 0; i < n; i++) {
        int weight = 0;
        item temp;
        fscanf(fin, "%d %d %d", &N, &M, &H);

        for (int j = 1; j <= N + 1; j++) {
            for (int k = 1; k <= M; k++) {
                fscanf(fin, "%d", &M_map[j][k]);
            }
        }
        for (int j = 1; j <= N; j++) {
            for (int k = 1; k <= M + 1; k++) {
                fscanf(fin, "%d", &N_map[j][k]);
            }
        }
        for (int j = 1; j <= N; j++) {
            for (int k = 1; k <= M; k++) {
                tank[j][k] = H;
            }
        }

        for (int i = 1; i <= M; i++)
        {
            if (M_map[1][i] != -1)
                tank[1][i] = M_map[1][i];
            if (M_map[N + 1][i] != -1)
                tank[N][i] = M_map[N + 1][i];
        }

        for (int i = 1; i <= N; i++)
        {
            if (N_map[i][1] != -1 && N_map[i][1] < tank[i][1])
                tank[i][1] = N_map[i][1];
            if (N_map[i][M + 1] != -1 && N_map[i][M + 1] < tank[i][M])
                tank[i][M] = N_map[i][M + 1];
        }

        for (int i = 1; i <= N; i++)
        {
            if (i == 1 || i == N)
            {
                for (int j = 1; j <= M; j++)
                {
                    temp.x = i; temp.y = j; temp.h = tank[i][j];
                    pq.push(temp);
                }
            }
            else
            {
                if (M == 1)
                {
                    temp.x = i; temp.y = 1; temp.h = tank[i][1];
                    pq.push(temp);
                }
                else
                {
                    temp.x = i; temp.y = 1; temp.h = tank[i][1];
                    pq.push(temp);
                    temp.x = i; temp.y = M; temp.h = tank[i][M];
                    pq.push(temp);
                }
            }
        }

        bfs();

        for (int j = 1; j <= N; j++) {
            for (int k = 1; k <= M; k++) {
                weight += tank[j][k];
            }
        }

        fprintf(fout, "%d\n", weight);
    }
   
    fclose(fin);
    fclose(fout);
    return 0;
}
