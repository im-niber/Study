// boj_테트로미노
// 특정 패턴에 맞는 값들의 합의 최대를 구해야하는 문제
// 처음 접근은 dfs로 해야겠다 싶어서 코드를 작성하다가
// 되돌아가는 경우를 어떻게 할지 고민중에 시도한 방식은 방문횟수가 한 번이면 다시 되돌아
// 가도 되겠다 싶어서 구현했다가 시초나고 좀 고민하다가
// 결국 패턴의 모양들을 보면 2번째 경우에서 자기자리에 가만히 있으믄
// 되돌아가는 모양의 패턴들이 완성되므로 현재 몇칸을 갔는지로
// 분기를 나눠서 풀었다,, 몇번 수정하다보니 코드가 좀 중복이 많긴하드,,
func baek() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let N = input[0], M = input[1]
    var paper: [[Int]] = []
    for _ in 0..<N { paper.append(readLine()!.split(separator: " ").compactMap { Int($0) }) }
    
    var ans = 0
    var visited: [[Int]] = Array(repeating: Array(repeating: 0, count: M), count: N)
    
    func verify(_ i: Int, _ k:Int) -> Bool { 0 <= i && i < N && 0 <= k && k < M }
    
    func dfs(_ i: Int, _ k: Int, _ cnt: Int, _ now: Int) {
        if cnt == 3 {
            ans = max(now, ans)
            return
        }
        
        if verify(i + 1, k) && visited[i + 1][k] != 1 {
            if cnt == 1 {
                visited[i + 1][k] = 1
                dfs(i, k, cnt+1, now + paper[i + 1][k])
                visited[i + 1][k] = 0
            }
            visited[i + 1][k] = 1
            dfs(i + 1, k, cnt+1, now + paper[i + 1][k])
            visited[i + 1][k] = 0
        }
        if verify(i - 1, k) && visited[i - 1][k] != 1 {
            if cnt == 1 {
                visited[i - 1][k] = 1
                dfs(i, k, cnt+1, now + paper[i - 1][k])
                visited[i - 1][k] = 0
            }
            visited[i - 1][k] = 1
            dfs(i - 1, k, cnt+1, now + paper[i - 1][k])
            visited[i - 1][k] = 0
        }
        if verify(i, k + 1) && visited[i][k + 1] != 1 {
            if cnt == 1 {
                visited[i][k + 1] = 1
                dfs(i, k, cnt+1, now + paper[i][k + 1])
                visited[i][k + 1] = 0
            }
            visited[i][k + 1] = 1
            dfs(i, k + 1, cnt+1, now + paper[i][k + 1])
            visited[i][k + 1] = 0
        }
        if verify(i, k - 1) && visited[i][k - 1] != 1 {
            if cnt == 1 {
                visited[i][k - 1] = 1
                dfs(i, k, cnt+1, now + paper[i][k - 1])
                visited[i][k - 1] = 0
            }
            visited[i][k - 1] = 1
            dfs(i, k - 1, cnt+1, now + paper[i][k - 1])
            visited[i][k - 1] = 0
        }
    }
    
    for i in 0..<N {
        for k in 0..<M {
            visited[i][k] += 1
            dfs(i, k, 0, paper[i][k])
            visited[i][k] -= 1
        }
    }
    
    print(ans)
}

baek()
