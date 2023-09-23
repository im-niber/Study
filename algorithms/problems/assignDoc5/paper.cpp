/*
    original code : https://github.com/seongho-joo/Programming-Challenges/blob/master/Algorithm/source/paper.cpp

*/

#define _CRT_SECURE_NO_WARNINGS

#include <algorithm>
#include <fstream>
#include <vector>
using namespace std;

ifstream inp("paper.inp");
ofstream out("paper.out");

struct Paper {
    int x, y, w, h;
};

int board[10000][10000];
vector<Paper> paper;
vector<int> idx;
// ������ ������ ����, �κ������� ������ ����, ������ ���̴� ����
int cover, section, all;

void Insert(Paper p) {
    idx.push_back(p.x);
    idx.push_back(p.y);
    idx.push_back(p.w);
    idx.push_back(p.h);
}
// ��ǥ����
void Compression(int len) {
    sort(idx.begin(), idx.end());
    idx.erase(unique(idx.begin(), idx.end()), idx.end());  // �ߺ� ����

    for (int i = 0; i < len; i++) {
        paper[i].x =
            lower_bound(idx.begin(), idx.end(), paper[i].x) - idx.begin();
        paper[i].y =
            lower_bound(idx.begin(), idx.end(), paper[i].y) - idx.begin();
        paper[i].w =
            lower_bound(idx.begin(), idx.end(), paper[i].w) - idx.begin();
        paper[i].h =
            lower_bound(idx.begin(), idx.end(), paper[i].h) - idx.begin();
    }
}
// 2�����迭�� ���̼���
void paperCover(int len) {
    for (int i = 0; i < len; i++)
        for (int j = paper[i].y; j < paper[i].h; j++)
            for (int k = paper[i].x; k < paper[i].w; k++) board[j][k] = i;
}

void solution() {
    int n = paper.size();
    Compression(n);
    paperCover(n);

    bool visible = false, unvisible = false;

    for (int i = 0; i < n; i++) {
        visible = false, unvisible = false;
        for (int j = paper[i].y; j < paper[i].h; j++) {
            for (int k = paper[i].x; k < paper[i].w; k++) {
                if (board[j][k] == i)
                    visible = true;
                else
                    unvisible = true;
            }
        }
        if (visible && unvisible) // �κ������� ������ ����
            section += 1;
        else if (visible) // ������ ���̴� ����
            all += 1;
        else // ������ ������ ����
            cover += 1;
    }
}

int main() {
    Paper p;

    int n;  // �������� ��
    inp >> n;
    paper.reserve(n);

    while (n--) {
        inp >> p.x >> p.y >> p.w >> p.h;
        p.w += p.x;
        p.h += p.y;
        paper.push_back(p);
        Insert(p);
    }

    solution();

    out << cover << ' ' << section << ' ' << all;

    inp.close();
    out.close();
    return 0;
}