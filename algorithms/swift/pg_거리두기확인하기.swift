import Foundation

// pg_거리두기 확인하기
// 배열의 원소끼리 거리를 비교해서 특정 조건에 맞는지 체크하는 문제
// 문제에서 설명한 조건대로 풀었다
func solution(_ places:[[String]]) -> [Int] {
    var res: [Int] = []
    var flag = false // 거리두기를 지키는지 체크하는 값
    
    // 맨해튼 거리 계산 함수
    func calDistance(ny: Int, nx: Int, y: Int, x: Int) -> Int {
        abs(y - ny) + abs(x - nx)
    }
    
    func bfs(array: [[String.Element]], y: Int, x: Int) {
        // 배열의 맨 윗줄에서 오른쪽으로 순회하므로,
        // 체크할 부분은 왼쪽 대각선, 아래 1칸 아래 2칸, 오른쪽 대각선, 오른쪽 1칸 오른쪽 2칸 6가지이다.
        let dx = [-1, 0, 0, 1, 1, 2]
        let dy = [1, 1, 2, 1, 0, 0]
        
        for i in 0..<6 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            // 배열의 범위 안인지 체크
            if 0 <= ny && ny < 5 && 0 <= nx && nx < 5 {
             
                // 만약 거리가 1이면서 P라면 거리두기를 지키지 않으므로 flag = true, return
                if array[ny][nx] == "P" && calDistance(ny: ny, nx: nx, y: y, x: x) == 1 {
                    flag = true
                    return
                }
                // 거리가 2인 case
                else if array[ny][nx] == "P" && calDistance(ny: ny, nx: nx, y: y, x: x) == 2 {
                    
                    // 오른쪽으로 2칸인 경우, 중간에 파티션이 아니라면 x
                    if dy[i] == 0 {
                        if array[ny][nx - 1] != "X" {
                            flag = true
                            return
                        }
                    }
                    
                    // 아래쪽으로 2칸인 경우, 중간에 파티션이 아니라면 x
                    else if dx[i] == 0 {
                        if array[ny - 1][nx] != "X" {
                            flag = true
                            return
                        }
                    }
                        
                    // 대각선
                    else {
                        // 문제에 설명대로 대각선과 현재 위치 사이사이에 파티션이 두 개있는지 체크
                        if dx[i] > 0 {
                            if array[ny][nx - 1] != "X" || array[ny - 1][nx] != "X" {
                                flag = true
                                return
                            }
                        }
                        
                        else {
                            if array[ny][nx + 1] != "X" || array[ny - 1][nx] != "X" {
                                flag = true
                                return
                            }
                        }
                    }
                }
            }
        }
    }
    
    for item in places {
        let arrayString = item.map { Array($0) }
        flag = false
        
        // 원소가 P라면 BFS를 실행하도록 함, flag가 false라면 종료
        for i in 0..<item.count where flag == false {
            for k in 0..<item.count where arrayString[i][k] == "P" {
                bfs(array: arrayString, y: i, x: k)
            }
        }
        
        if !flag { res.append(1) }
        else { res.append(0) }
    }
    
    return res
}

print(solution([["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"], ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"], ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"], ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"], ["OOPOO", "OPOOO", "OOOOO", "OOOOO", "OOOOO"]]))
