#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
//#include <utility>
#include <algorithm>
#include <fstream>
using namespace std;

ifstream inp("kruskal.inp");
ofstream out("kruskal.out");

int n[10002], nodes, edges;
pair <int, pair <int, pair<int, int> > >g[1000001];
int idx[100002];

void init()
{
    for (int i = 0; i < 10002; i++) {
        n[i] = i;
   
    }
    for (int i = 0; i < 100002; i++) {
        idx[i] = -1;
    }
}

int root(int x)
{
    while (n[x] != x)
    {
        n[x] = n[n[x]];
        x = n[x];
    }
    return x;
}

void union1(int x, int y)
{
    int g = root(x);
    int q = root(y);
    n[g] = n[q];
}

long long kruskal(pair <int, pair<int, pair<int, int> > > g[])
{
    int x, y;
    int temp, mintemp = 0;
    for (int i = 0; i < edges; i++)
    {

        x = g[i].second.second.first;
        y = g[i].second.second.second;
        temp = g[i].first;

        if (root(x) != root(y))
        {
            mintemp += temp;
            union1(x, y);
            idx[i] = g[i].second.first;
        }
    }
    return mintemp;
}

int main()
{
    int x, y;
    int weight, result;
    init();
    inp >> nodes >> edges;
    for (int i = 0; i < edges; i++)
    {
        inp >> x >> y >> weight;
        g[i] = make_pair(weight,make_pair(i, make_pair(x, y)));
    }

    sort(g, g + edges);
    result = kruskal(g);
    cout << result << endl;
    out << result << endl;

    for (int i = 0; i < 100002; i++) {
        if (idx[i] != -1) {
            cout << idx[i] << endl;
            out << idx[i] << endl;
        }
    }
    return 0;
}