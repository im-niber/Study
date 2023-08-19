import Foundation

// pg_예상 대진표
// b를 큰 수로 두어서 계속 2로 나눠주면서 1 차이 나면서 b가 짝수면 정답을 리턴했슴니다
// 다른 풀이를 보니 두 값이 결국 같아지는 부분을 체크하는 방법도 있어서 한 수 배웠슴니다,,
// 그리고 똑같은 코드로 시간초과가 또 떠서 억울하네여 ㅜ ㅡ ㅜ 네트워크문젠가; 제출 두번씩해봐야겠슴니다,,
func solution(_ n:Int, _ a:Int, _ b:Int) -> Int {
    var answer = 1
    var a: Double = Double(a), b: Double = Double(b)
    
    if a > b { swap(&a, &b) }
    
    while((b - a) != 1 || Int(b) % 2 != 0) {
        answer += 1
        a = ceil(a / 2); b = ceil(b / 2);
    }
    
    return answer
}

print(solution(4, 1, 3))
print(solution(8, 4, 7))
print(solution(8, 5, 1))
