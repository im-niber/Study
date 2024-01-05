// pg_징검다리 건너기

// 좀 어려워서 질문게시판을 보고 키워드를 얻고 푼 문제
// 구간을 나누는 처음 발상대로 계속 했으면 풀었을거 같기는한데
// 조금 디테일이 부족해서 며칠걸렸을듯
// 슬라이딩 윈도우 개념으로 매 구간의 최댓값을 배열에 넣어주고
// 최댓값의 배열에서 최소를 구하면 정답이 나온다.

// 여기서 문제는 구간마다 최댓값을 어떻게 빠르게 구하냐 인데
// 이 부분은 자료구조인 데크(deque, 여기선 일반 array 사용했슴니다)
// 를 사용하여 해결할 수 있다. 최대 힙도 사용하는 풀이도
// 있었던거가틈. 먼저 현재까지의 최댓값의 인덱스를 저장하는 데크를 만든다.
// 그러고, 다음 원소를 확인할 때 데크의 맨 오른쪽의 원소가 현재 확인할 원소보다
// 작으면 removeLast 해주면서 왼쪽으로 넣어준다. 그러면 최댓값이 맨 왼쪽으로 가겠져?
// 다음 확인하는 사항은, 원소가 구간을 벗어나는지 이다. 구간을 벗어난 원소는 체크할 필요가 없으므로
// removeFirst() 해줌니다. <- 여기서 Swift는 O(n)이 걸리기 때문에
// 맨 왼쪽 인덱스(left)를 하나씩 늘려주면서 deque의 popLeft와 동일한 기능을 하도록  구현하였다.
// 대신 공간 복잡도가 조금 올라간다

func solutionn(_ stones:[Int], _ k:Int) -> Int {
    var idxs: [Int] = []
    var values: [Int] = []
    
    var left = 0
    
    for i in 0..<k {
        
        while !idxs.isEmpty && stones[idxs[idxs.count - 1]] <= stones[i]  {
            idxs.removeLast()
        }
        
        idxs.append(i)

    }

    for i in k..<stones.count {
        values.append(stones[idxs[0]]);
        
        while idxs.count > left && idxs[left] <= i - k { left += 1 }
        
        // while 풀이 평균 50~60ms
        while idxs.count >= left && stones[i] >= stones[idxs[idxs.count - 1]] {
            idxs.removeLast()
        }
        
        // for문 풀이, 평균 300ms
        // 6배 차이나고 13번 케이스에서 시초가난다... -1 연산이 문제인지
        // idxs count가 줄어드는 while문이 좀 더 효율적인게 이런 차이를 만드는지 잘..은 모르게쓰
        for j in stride(from: idxs.count - 1, through: left, by: -1) {
            if stones[idxs[j]] <= stones[i] {
                idxs.removeLast()
            }
        }
        
        idxs.append(i)
    }
    
    values.append(stones[idxs[0]]);
    return values.min()!
}
