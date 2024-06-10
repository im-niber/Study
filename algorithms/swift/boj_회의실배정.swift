// boj 회의실배정
// 그리디의 대표문제라고 알고있다
// 좀 고민하다가 정렬을 해야하지싶어서
// 처음엔 시작시간으로 정렬했지만 많이 비교해야해서
// 끝나는 시간으로 정렬해서 풀었다
// 주의점은 끝나는 시간에서도 시작시간을 빠른쪽을 먼저 써야한다
// 안 그러면 (2, 4) (3,4) (4,4) 같은 회의들의경우에
// 4,4를 먼저쓰게 되는 경우가 생기고 이는 1개로실패하게됨
func baek() {
    let N = Int(readLine()!)!
    
    var info: [(s:Int, e:Int)] = []
    for _ in 0..<N {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        info.append((input[0], input[1]))
    }
    
    info = info.sorted(by: { lhs, rhs in
        if lhs.e == rhs.e {
            return lhs.s < rhs.s
        }
        return lhs.e < rhs.e
    })
    
    var cnt = 1
    
    var nowEnd = info[0].e
    
    for i in 1..<info.count {
        if nowEnd <= info[i].s {
            cnt += 1
            nowEnd = info[i].e
        }
    }

    print(cnt)
}

baek()
