import Foundation

// pg_행렬 테두리 회전하기
// 구현문제라고 생각하고 풀었슴니다
// 규칙을 좀 찾다가 맨위 맨아래 행의 처리만 따로해주고
// 나머지 행은 맨앞,뒤만 처리하면 되겠다 싶어서 그렇게 구현하였슴니다
// 더 깔끔한 규칙이 있는지는 잘 모르겠슴니다만 간단하게 풀었슴니다.
func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
    var answer: [Int] = []
    
    var answerArr: [[Int]] = []
    var tempArr: [[Int]] = []
    
    for i in 0..<rows {
        answerArr.append([])
        tempArr.append([])
        for j in 0..<columns {
            answerArr[i].append((i * columns + j + 1))
            tempArr[i].append((i * columns + j + 1))
        }
    }
    
    for item in queries {
        let (startR, startC) = (item[0] - 1, item[1] - 1)
        let (endR, endC) = (item[2] - 1, item[3] - 1)
        
        var minValue = Int.max
        for i in startR...endR {
            if i == startR {
                for k in startC..<endC {
                    tempArr[i][k + 1] = answerArr[i][k]
                    minValue = min(minValue, answerArr[i][k])
                }
                tempArr[i + 1][endC] = answerArr[i][endC]
                minValue = min(minValue, answerArr[i][endC])
            }
            
            else if i == endR {
                for k in stride(from: endC, to: startC, by: -1) {
                    tempArr[i][k - 1] = answerArr[i][k]
                    minValue = min(minValue, answerArr[i][k])
                }
                tempArr[i - 1][startC] = answerArr[i][startC]
                minValue = min(minValue, answerArr[i][startC])
            }
            
            else {
                tempArr[i - 1][startC] = answerArr[i][startC]
                tempArr[i + 1][endC] = answerArr[i][endC]
                
                minValue = min(minValue, answerArr[i][startC], answerArr[i][endC])
            }
            
        }
        
        answerArr = tempArr
        answer.append(minValue)
    }
    
    
    return answer
}
