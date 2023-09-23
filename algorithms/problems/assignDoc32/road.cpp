#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <stack>
using namespace std;

ifstream inp("road.inp");
ofstream out("road.out");

bool visited[10001] = { false, };

void dfs2(int a, int b, int c, vector<pair<int, int>> hotel[]) {
    stack<int> s;
    s.push(a);
    visited[a] = true;

    while (!s.empty()) {
        int node = s.top();
        s.pop();

        if (node == b) {
            while (!s.empty()) {
                int pre_node = s.top();

                //  chk[node][pre_node] = c;
                //  chk[pre_node][node] = c;

                for (int k = 0; k < hotel[node].size(); k++) {
                    if (hotel[node][k].second == pre_node) {
                        hotel[node][k].first = c;
                    }
                }
                for (int k = 0; k < hotel[pre_node].size(); k++) {
                    if (hotel[pre_node][k].second == node) {
                        hotel[pre_node][k].first = c;
                    }
                }

                node = s.top();
                s.pop();

                if (s.size() == 1) {

                    //  chk[node][a] = c;
                    //  chk[a][node] = c;
                    //  return;

                    for (int k = 0; k < hotel[node].size(); k++) {
                        if (hotel[node][k].second == a) {
                            hotel[node][k].first = c;
                        }
                    }
                    for (int k = 0; k < hotel[a].size(); k++) {
                        if (hotel[a][k].second == node) {
                            hotel[a][k].first = c;
                        }
                    }
                    return;

                }
            }
        }

        for (int i = hotel[node].size() - 1; i >= 0; i--) {
            int next_node = hotel[node][i].second;
            if (visited[next_node] == 0) {
                visited[next_node] = 1;
                s.push(node);
                s.push(next_node);
                break;
            }

        }
    }
}
/*
void dfs(int a, int b, int c, vector<pair<int,int>> hotel[]) {
    int temp;
    int idx;
    for (int i = 0; i < hotel[a].size(); i++) {
        if (visited[hotel[a][i].second] == 0 && visited[b] == 0) {
            temp = 0;
            visited[hotel[a][i].second] = 1;

            temp = hotel[a][i].first;
            hotel[a][i].first = c;

            for (int k = 0; k < hotel[hotel[a][i].second].size(); k++) {
                idx = 0;
                if (hotel[hotel[a][i].second][k].second == a) {
                    hotel[hotel[a][i].second][k].first = c;
                    idx = k;
                }
            }

            dfs(hotel[a][i].second, b, c, hotel);

            if (visited[b] == 1) {
                return;
            }
            hotel[a][i].first = temp;
            hotel[hotel[a][i].second][idx].first = temp;
        }

    }

}
*/

int main()
{
    int T;
    inp >> T;
    for (int i = 0; i < T; i++) {
        int colors[10001] = { 0, };
        int result = 0;

        // map<int, int> hotel[10001];
         // vector <int> HOTEL[10001];
        vector<pair <int, int>> HOTEL[10001];

        int n;
        inp >> n;

        for (int k = 0; k < n - 1; k++) {
            int a, b;
            inp >> a >> b;


            //  HOTEL[a].push_back(b);
            //  HOTEL[b].push_back(a);

            HOTEL[a].push_back(make_pair(0, b));
            HOTEL[b].push_back(make_pair(0, a));

            //  hotel[a][b] = 0;
             // hotel[b][a] = 0;
        }


        int color_num;
        inp >> color_num;

        for (int k = 0; k < color_num; k++) {
            int a, b, c;
            inp >> a >> b >> c;

            visited[a] = 1;
            dfs2(a, b, c, HOTEL);
            for (int j = 1; j < 10001; j++) visited[j] = false;
        }

        for (int k = 1; k < 10001; k++) {
            for (pair<int, int> it : HOTEL[k]) {
                if (colors[it.first] == 0) {
                    colors[it.first] = 1;
                    result++;
                }
            }
        }
        /*
       for (int k = 1; k < 10001; k++) {
           for (pair<int, int> it : HOTEL[k]) {
               if (colors[it.first] == 0) {
                   colors[it.first] = 1;
                   result++;
               }
           }
       }
       */
        //cout << result << endl;
        out << result << endl;
    }

    inp.close();
    out.close();
    return 0;
}