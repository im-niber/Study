#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>

using namespace std;

ifstream inp("cycle.inp");
ofstream out("cycle.out");

vector <int> edge[50001];
int edge_length[50001] = { 0, };

void dfs2(vector<int> node, int length, int visited[], int idx) {
    int value = 0;
    if (edge_length[idx] < length) edge_length[idx] = length;

    for (int i = 0; i < node.size(); i++) {
        if (visited[node[i]] == 0) {
            visited[node[i]] = 1;
            dfs2(edge[node[i]], length + 1, visited, idx);
        }
    }
}

void dfs(vector<int> node, int length, int visited[], int idx) {
    int value = 0;
    if (edge_length[idx] < length) edge_length[idx] = length;

    for (int i = 0; i < node.size(); i++) {
        if (visited[node[i]] == 0) {
            visited[node[i]] = 1;
            dfs(edge[node[i]], length + 1, visited, node[i]);
        }
    }
}

int solve(vector<int> edge[], int last) {
    int max_val = 0;
    int idx = 0;
    int visited[50001] = { 0 , };
    dfs(edge[1], 0, visited, 1);

    for (int i = 1; i < 50001; i++) {
        if (edge_length[i] > max_val) {
            max_val = edge_length[i];
            idx = i;
        }
        visited[i] = 0;
        edge_length[i] = 0;
    }

    dfs2(edge[idx], 0, visited, idx);

    return edge_length[idx] + 1;
}

int main()
{
    int T;
    inp >> T;

    for (int i = 0; i < T; i++) {
        int n;
        int max_cycle = 0;
        inp >> n;

        for (int k = 0; k < n - 1; k++) {
            int a, b;
            inp >> a >> b;
            edge[a].push_back(b);
            edge[b].push_back(a);
        }

        max_cycle = solve(edge, n);
        cout << max_cycle << endl;
        out << max_cycle << endl;

        for (int z = 1; z < 50001; z++) edge[z].clear();
        for (int z = 1; z < 50001; z++) edge_length[z] = 0;
    }

    inp.close();
    out.close();
    return 0;
}