#define _CRT_SECURE_NO_WARNINGS

#include <string>
#include <iostream>
#include <vector>
#include <fstream>
using namespace std;

ifstream inp("queue.inp");
ofstream out("queue.out");

class tree {
public:
    int temp;
    tree* left;
    tree* right;
    tree* parent;
    tree() {
        this->temp = -1;
        this->left = NULL;
        this->right = NULL;
        this->parent = NULL;
    }
};

tree h[1000001];
int cnt = 0;


void adjust(int cnt) {
    int idx_chk = cnt;
    int temp = -1;

    if (idx_chk > 0) {
        h[0].temp = h[idx_chk].temp;
        h[idx_chk].temp = -1;
        int zero = 0;
        while (true) {
            if (h[zero].left && !h[zero].right) {
                if (h[zero].temp < h[zero].left->temp) {
                    temp = h[zero].left->temp;
                    h[zero].left->temp = h[zero].temp;
                    h[zero].temp = temp;
                    zero = zero * 2 + 1;
                }
                else break;
            }
            else if (h[zero].right && !h[zero].left) {
                if (h[zero].temp < h[zero].right->temp) {
                    temp = h[zero].right->temp;
                    h[zero].right->temp = h[zero].temp;
                    h[zero].temp = temp;
                    zero = zero * 2 + 2;
                }
                else break;
            }
            else if (h[zero].left && h[zero].right) {
                if (h[zero].temp < h[zero].left->temp && h[zero].left->temp > h[zero].right->temp) {
                    temp = h[zero].left->temp;
                    h[zero].left->temp = h[zero].temp;
                    h[zero].temp = temp;
                    zero = zero * 2 + 1;
                }
                else if (h[zero].temp < h[zero].right->temp && h[zero].right->temp > h[zero].left->temp) {
                    temp = h[zero].right->temp;
                    h[zero].right->temp = h[zero].temp;
                    h[zero].temp = temp;
                    zero = zero * 2 + 2;
                }
                else {
                    break;
                }
            }
            else {
                break;
            }
            
        }
    }
    
}

void del_queue() {
    cnt--;
    h[0].temp = -1;
    adjust(cnt);
}

void print_heap2() {
    tree* temp = &h[0];
    while (true) {
        cout << temp->temp << " ";
        out << temp->temp << " ";
        if (!temp->left || temp->left->temp < 0) break;
        temp = (temp->left);

    }
    cout << "\n";
    out << "\n";
}

int main()
{ 

    string op;
    int temp;
    int idx_chk = 0;
    int idx_temp = -1;

    while (true) {
        inp >> op;
        temp = atoi(op.c_str());
        if (temp) {
            h[cnt++].temp = temp;

            idx_chk = cnt;

            if(idx_chk != 1) {
                idx_chk--;
                if (idx_chk == 1 || idx_chk == 2) {                    
                    if (idx_chk == 1) {
                        h[0].left = &h[idx_chk];
                        h[idx_chk].parent = &h[0];
                    }
                    else {
                        h[0].right = &h[idx_chk];
                        h[idx_chk].parent = &h[0];
                    }
                }
                else if (idx_chk % 2 == 0) {
                    idx_temp = (idx_chk - 2) / 2;
                    h[idx_temp].right = &h[idx_chk];
                    h[idx_chk].parent = &h[idx_temp];
                }
                else {
                    idx_temp = (idx_chk - 1) / 2;
                    h[idx_temp].left = &h[idx_chk];
                    h[idx_chk].parent = &h[idx_temp];
                }

                if (idx_chk > 0) {
                    while (true) {
                        if (h[idx_chk].parent->temp < h[idx_chk].temp) {
                            temp = h[idx_chk].parent->temp;
                            h[idx_chk].parent->temp = h[idx_chk].temp;
                            h[idx_chk].temp = temp;

                            if (idx_chk % 2 == 0 && idx_chk != 2) {
                                idx_chk = (idx_chk - 2) / 2;
                            }
                            else if (idx_chk % 2 == 1 && idx_chk != 1) {
                                idx_chk = (idx_chk - 1) / 2;
                            }
                            else {
                                break;
                            }
                        }
                        else {
                            break;
                        }
                    }
                }
            }
        }
        else if (op == "d") del_queue();
        else if (op == "r") print_heap2();
        else {
            break;
        }
    }
    
    inp.close();
    out.close();
    return 0;
}