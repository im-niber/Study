#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>

int row, col;
char fmt[105], s[65536], g[256][256];
int idx = 0;

void color(int lx, int rx, int ly, int ry) {
    if (lx > rx || ly > ry)  return;
    int i, j;
    if (s[idx] == '0') {
        for (i = lx; i <= rx; i++)
            for (j = ly; j <= ry; j++)
                g[i][j] = '0';
        idx++;
        return;
    }
    if (s[idx] == '1') {
        for (i = lx; i <= rx; i++)
            for (j = ly; j <= ry; j++)
                g[i][j] = '1';
        idx++;
        return;
    }
    int mx = (lx + rx) / 2, my = (ly + ry) / 2;
    idx++;
    color(lx, mx, ly, my);
    color(lx, mx, my + 1, ry);
    color(mx + 1, rx, ly, my);
    color(mx + 1, rx, my + 1, ry);
}
void dfs(int lx, int rx, int ly, int ry) {
    if (lx > rx || ly > ry)  return;
    int i, j, v = g[lx][ly], same = 1;
    for (i = lx; i <= rx; i++) {
        for (j = ly; j <= ry; j++) {
            if (g[i][j] != v)
                same = 0, j = ry, i = rx;
        }
    }
    if (same == 1) {
        putchar(v);
        idx++;
        if (idx % 50 == 0) puts("");
        return;
    }
    int mx = (lx + rx) / 2, my = (ly + ry) / 2;
    putchar('D');
    idx++;
    if (idx % 50 == 0) puts("");
    dfs(lx, mx, ly, my);
    dfs(lx, mx, my + 1, ry);
    dfs(mx + 1, rx, ly, my);
    dfs(mx + 1, rx, my + 1, ry);
}
int main() {
    int i, j;
    char buf[65536];
    gets(buf);
    while (sscanf(buf, "%s %d %d", fmt, &row, &col) == 3) {
        if (!strcmp(fmt, "#"))
            break;
        buf[0] = '\0';
        if (fmt[0] == 'B') {
            char ch = -1;
            idx = 0;
            while (idx < row * col && (ch = getchar())) {
                if (ch != '\0' && ch != '\n')
                    s[idx++] = ch;
            }
            printf("D%4d%4d\n", row, col);
            idx = 0;
            for (i = 0; i < row; i++)
                for (j = 0; j < col; j++)
                    g[i][j] = s[idx++];
            idx = 0;
            dfs(0, row - 1, 0, col - 1);
            if (idx % 50)
                puts("");
            if (row * col)
                while (getchar() != '\n');
            gets(buf);
        }
        else {
            idx = 0;
            while (gets(buf)) {
                if (buf[1] == ' ')   break;
                for (i = 0; buf[i]; i++)
                    s[idx++] = buf[i];
            }
            printf("B%4d%4d\n", row, col);
            idx = 0;
            color(0, row - 1, 0, col - 1);
            idx = 0;
            for (i = 0; i < row; i++) {
                for (j = 0; j < col; j++) {
                    putchar(g[i][j]);
                    idx++;
                    if (idx % 50 == 0) puts("");
                }
            }
            if (idx % 50)
                puts("");
        }
    }
    return 0;
}
