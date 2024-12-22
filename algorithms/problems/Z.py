def solve(n, r, c):
    global result

    if n == 2:
        if r == R and c == C:
            print(result)
            return
        result += 1
        
        if r == R and c+1 == C:
            print(result)
            return
        result += 1
        
        if r+1 == R and c == C:
            print(result)
            return
        result += 1
        
        if r+1 == R and c+1 == C:
            print(result)
            return
        result += 1
        return
    
    if r <= R and R <= r + n // 2 and c <= C and C <= c + n // 2:
        solve(n // 2, r, c)
    else: result += (n // 2) ** 2

    if r <= R and R <= r + n // 2 and c + n // 2 <= C and C <= (c + n // 2) * 2:
        solve(n // 2, r, c + n // 2)
    else: result += (n // 2) ** 2

    if r + n // 2 <= R and R <= (r + n // 2) * 2 and c <= C and C <= c + n // 2:
        solve(n // 2, r + n // 2, c)
    else: result += (n // 2) ** 2

    if r + n // 2 <= R and R <= (r + n // 2) * 2 and c + n // 2 <= C and C <= (c + n // 2) * 2:
        solve(n // 2, r + n // 2, c + n // 2)
    else: result += (n // 2) ** 2


result = 0
N, R, C = map(int, input().split(' '))
solve(2 ** N, 0, 0)
