import Foundation

// pg_영어 끝말잇기
// 구현문제. 집합에 단어를 넣고, 순서를 세면서 index를 초기화 하는 방식으로 구현하였다
// 다른 풀이를 보니, 단어들의 배열을 만들어서 조건에 안맞다면 현재까지 나온
// 단어를 사람수로 나머지 연산과 나눗셈 연산으로 간단히 구할 수 있었다,,
func solution(_ n:Int, _ words:[String]) -> [Int] {
    var words = words
    
    var beforeWord = words.removeFirst()
    var stringSet: Set<String> = [beforeWord]
    
    var person = 1
    var order = 1
    
    for item in words {
        if person == n {
            person = 1
            order += 1
        }
        else { person += 1 }
        
        if beforeWord.last! != item.first! || stringSet.contains(item) {
            return [person, order]
        }
        stringSet.insert(item)
        beforeWord = item
    }
    
    return [0, 0]
}
