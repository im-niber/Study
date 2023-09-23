import Foundation

// pg_하노이의 탑
// 처음엔 이전값들을 사용해서 그냥 무쉭하게 풀었당 n = 3 이란거는
// n = 2일 때 애들을 2번째 기둥으로 보내고, 남은 젤큰 원판을 3으로 옮기고 2번기둥에 있던애들도
// 3번기둥으로 옮기는거라 그 부분을 생각해서 규칙을 적어서 품
// 함수로 했으면 더 깔끔했는디,, ㅜㅡㅜ
func solution(_ n:Int) -> [[Int]] {
    // 함수로 하는풀이
    var array: [[Int]] = []
    func hanoi(_ from: Int, _ by: Int, _ to: Int, _ n: Int) {
        if n == 1 {
            array.append([from, to])
            return
        }
        
        hanoi(from, to, by, n - 1) // 이전에 애들 다 by로 보냄
        hanoi(from, by, to, 1) // 마지막 남은 애를 목적지인 to로 보냄
        hanoi(by, from, to, n - 1) // by로 보낸 애들도 목적지로 보냄
    }
    
    // [0][0] : 1->3, [0][1]: 1->2, [0][2]: 2->3, [0][3]: 3->2, [0][4]: 2->1, [0][5]: 3->1
    var cases: [[[[Int]]]] = [
        [[[1,3]]],
        [
            [[1,2],[1,3],[2,3]],
            [[1,3],[1,2],[3,2]],
            [[2,1],[2,3],[1,3]],
            [[3,1],[3,2],[1,2]],
            [[2,3],[2,1],[3,1]],
            [[3,2],[3,1],[2,1]]
        ]
    ]
    
    for i in 1..<n - 1 {
        cases.append([])
        cases[i + 1].append(cases[i][1] + [[1,3]] + cases[i][2])
        cases[i + 1].append(cases[i][0] + [[1,2]] + cases[i][3])
        cases[i + 1].append(cases[i][4] + [[2,3]] + cases[i][0])
        cases[i + 1].append(cases[i][5] + [[3,2]] + cases[i][1])
        cases[i + 1].append(cases[i][2] + [[2,1]] + cases[i][5])
        cases[i + 1].append(cases[i][3] + [[3,1]] + cases[i][4])
    }

    return cases[n - 1][0]
}


print(solution(3))
print(solution(4))
print(solution(10))
