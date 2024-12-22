def fibo(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibo(n-1) + fibo(n-2)

print(fibo(10))

def fact(n):
    if n == 1:
        return 1
    return n * fact(n-1)


def fact_no_recur(n):
    ans = 1
    for i in range(1, n+1):
        ans *= i
    return ans

print(fact_no_recur(5))

def fibo_no_recur(n):
    ans = 1
    before = 0

    if n == 0:
        return 0

    for _ in range(1, n):
        tmp = ans
        ans = before + ans
        before = tmp

    return ans

print(fibo_no_recur(10))