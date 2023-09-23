// template 배열 합 문제.
#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <string>
using namespace std;

template <typename T>
T arr_plus(T arr[], int n) {
    T temp[n-1];
    copy(arr, arr + n, temp);
    // T sum = arr[0];
    // T chk = arr[0];
    for (int i = 1; i < n; i++) {
        temp[0] += arr[i];
    }
    return temp[0];
}

/*
template <typename T>
T arr_plus(T arr[], int n) {
    T sum = 0;
    for (int i = 0; i < n; i++)sum += arr[i];
    return sum;
}

string arr_plus(string arr[], int n) {
    string sum;
    for (int i = 0; i < n; i++)sum += arr[i];
    return sum;
}
*/

int main()
{
    int iarr[] = { 1,2,3,4,5 };
    double darr[] = { 1.1,2.2,3.3 };
    string sarr[] = { "딸기", "바나나", "우유"};


    cout << "정수배열  합은 " << arr_plus(iarr, 5) << endl;
    //cout << "실수배열 합은 " << arr_plus(darr, 3) << endl;
    cout << "string배열 경우는" << arr_plus(sarr, 3)  << endl;

    return 0;
}