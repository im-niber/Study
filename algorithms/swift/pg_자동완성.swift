import Foundation

// pg_자동완성
// 플그가 lv4문제를 추천하길래 속는셈치고 풀어봤는데
// 문제 조건이 다행히 적당해서 풀렸다
// 문자들의 길이의 합이 100만이기 때문에
// 문자 하나하나 빼서 딕셔너리에 저장하고 중복이면 해당 카운트를 ans에 더해주는식으로
// 풀려고했고, 단순하게 딕셔너리의 key를 String으로 했을때는 케이스 4개정도가 시초가 나서
// 어디서 시초가 나는거지 여러 테스트 하다가, 아무래도 키에 상당히 긴 문자열이 저장되고 접근하는 부분이
// 시초인듯해서 문자열을 다른 타입의 형태로 바꿔줘야겠다라고 판단하고 간단하게 swift의 hash를 사용해서 풀었따
// 아마 다른언어였으면 문자열로만 해도 풀렸을거같기도하고? 다른 풀이를 보니
// 사전 순으로 정렬하면 인접한 문자열은 자신과 거의 동일한 친구들이 오기때문에 얘네만 보면 간단히 카운트 체크가
// 될듯함,, 생각지도못했음,, 또 트라이? 를 사용해서 푼게 있는데 문자열의 유사도를 빨리 알 수 있게 하는
// 자료구조라고 함 얘도 좀 알아둘 필요는 있을둣
func solution(_ words:[String]) -> Int {
    var dict: [Int: Int] = [:]
    
    for word in words {
        var tempWord = word
        
        while !tempWord.isEmpty {
            if (dict[tempWord.hash] ?? 0) > 1 { break }
            dict[tempWord.hash, default: 0] += 1
            tempWord.removeLast()
        }
    }
    
    var ans = 0
    for word in words {
        var tempWord = word
        ans += 1
        
        while !tempWord.isEmpty {
            if (dict[tempWord.hash] ?? 0) > 1 {
                ans += tempWord.count
                break
            }
            tempWord.removeLast()
        }
        
        if word == tempWord { ans -= 1 }
    }
    
    return ans
}
