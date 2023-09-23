#define _CRT_SECURE_NO_WARNINGS

#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int chke[12] = { 3,0,3,2,3,2,3,3,2,3,2,3 };
int days[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
char dayss[7][4] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat" };

int yeun(int year) {
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return true;
    }
    else return false;
}

int check(int year, int month, int* idx) {
    int first_idx = 1; // Mon 0001-01-01
    int chk = 0;
    for (int i = 1; i < year; i++) {
        if ((i % 4 == 0 && i % 100 != 0) || (i % 400 == 0)) {
            chk += 366;
            first_idx += 2;

        }
        else {
            chk += 365;
            first_idx++;
        }
    }

    for (int i = 0; i < month - 1; i++) {
        if (i == 1) {
            if (yeun(year)) {
                first_idx++;
                chk += 29;
                continue;
            }
        }
        chk += days[i];
        first_idx += chke[i];
    }

    *idx = first_idx % 7;

    return chk;
}


FILE* fin = fopen("calendar.inp", "r");
FILE* fout = fopen("calendar.out", "w");

int n;

int main()
{
    while (true) {
        int count = -1;
        char a[20];
        char b[20];

        char* temp_a[4];
        char* temp_b[4];

        fscanf(fin, "%d", &n);

        if (n == -1) break;

        fscanf(fin, "%s", &a);
        fscanf(fin, "%s", &b);

        int x = 0;

        char* temp1 = strtok(a, "-");
        x = 0;
        while (temp1 != NULL) {
            temp_a[x] = temp1;
            x++;
            temp1 = strtok(NULL, "-");

        }

        char* temp2 = strtok(b, "-");
        x = 0;
        while (temp2 != NULL) {
            temp_b[x] = temp2;
            x++;
            temp2 = strtok(NULL, "-");

        }


        int day1_count = 0;
        int day2_count = 0;

        int day1_idx = 0;
        int day2_idx = 0;

        int day1_year = atoi(temp_a[0]);
        int day2_year = atoi(temp_b[0]);

        int day1_month = atoi(temp_a[1]);
        int day2_month = atoi(temp_b[1]);


        day1_count += check(day1_year, day1_month, &day1_idx);
        day2_count += check(day2_year, day2_month, &day2_idx);

        if (n == 0) {
            int day1_day = atoi(temp_a[2]);
            int day2_day = atoi(temp_b[2]);

            if (day1_day == 29 && day1_month == 2) {
                if (!yeun(day1_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }
            if (day2_day == 29 && day2_month == 2) {
                if (!yeun(day2_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day1_month - 1] < day1_day && day1_day != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            if (days[day2_month - 1] < day2_day && day2_day != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            count = (day2_count - day1_count) + (day2_day - day1_day);
        }
        else if (n == 1) {
            int p = -1;
            int day1_day = atoi(temp_a[2]);
            int day2_cnt = atoi(temp_b[2]);

            if (day1_day == 29 && day1_month == 2) {
                if (!yeun(day1_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day1_month - 1] < day1_day && day1_day != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            for (int i = 0; i < 7; i++) {
                if (strcmp(temp_b[3], dayss[i]) == 0) {
                    p = i;
                    break;
                }
            }
            int curday = 0;

            if (p > day2_idx) {
                curday = 1 + p - day2_idx;
            }
            else if (p < day2_idx) {
                curday = 7 - day2_idx + 1 + p;
            }
            else curday = 1;

            curday = curday + ((day2_cnt - 1) * 7);

            if (curday == 29 && day2_month == 2) {
                if (!yeun(day2_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day2_month - 1] < curday && curday != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            count = (day2_count - day1_count) + (curday - day1_day);

        }
        else if (n == 2) {
            int p = -1;
            int day1_cnt = atoi(temp_a[2]);
            int day2_day = atoi(temp_b[2]);

            if (day2_day == 29 && day2_month == 2) {
                if (!yeun(day2_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day2_month - 1] < day2_day && day2_day != 29) {
                fprintf(fout, "-1\n");
                continue;
            }
            for (int i = 0; i < 7; i++) {
                if (strcmp(temp_a[3], dayss[i]) == 0) {
                    p = i;
                    break;
                }
            }
            int curday = 0;

            if (p > day1_idx) {
                curday = 1 + p - day1_idx;
            }
            else if (p < day1_idx) {
                curday = 7 - day1_idx + 1 + p;
            }

            else curday = 1;

            curday = curday + ((day1_cnt - 1) * 7);

            if (curday == 29 && day1_month == 2) {
                if (!yeun(day1_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day1_month - 1] < curday && curday != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            count = (day2_count - day1_count) + (day2_day - curday);

        }
        else {
            int p = -1;
            int p1 = -1;

            int day1_cnt = atoi(temp_a[2]);
            int day2_cnt = atoi(temp_b[2]);

            for (int i = 0; i < 7; i++) {
                if (strcmp(temp_a[3], dayss[i]) == 0) {
                    p = i;
                    break;
                }
            }
            int curday_a = 0;

            if (p > day1_idx) {
                curday_a = 1 + p - day1_idx;
            }
            else if (p < day1_idx) {
                curday_a = 7 - day1_idx + 1 + p;
            }
            else curday_a = 1;

            curday_a = curday_a + ((day1_cnt - 1) * 7);

            if (curday_a == 29 && day1_month == 2) {
                if (!yeun(day1_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day1_month - 1] < curday_a && curday_a != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            for (int i = 0; i < 7; i++) {
                if (strcmp(temp_b[3], dayss[i]) == 0) {
                    p1 = i;
                    break;
                }
            }

            int curday_b = 0;

            if (p1 > day2_idx) {
                curday_b = 1 + p1 - day2_idx;
            }
            else if (p1 < day2_idx) {
                curday_b = 7 - day2_idx + 1 + p1;
            }
            else curday_b = 1;

            curday_b = curday_b + ((day2_cnt - 1) * 7);

            if (curday_b == 29 && day2_month == 2) {
                if (!yeun(day2_year)) {
                    fprintf(fout, "%d\n", count);
                    continue;
                }
            }

            if (days[day2_month - 1] < curday_b && curday_b != 29) {
                fprintf(fout, "-1\n");
                continue;
            }

            count = (day2_count - day1_count) + (curday_b - curday_a);

        }

        fprintf(fout, "%d\n", abs(count));
    }

    fclose(fin);
    fclose(fout);
    return 0;
}