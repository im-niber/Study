import Foundation

// pg_오픈채팅방
// 예전엔 파이썬으로 풀었었는데 Swift로 다시 풀어봄
// 최종적으로 id의 닉네임을 저장하기 위해 반복을 먼저하고
// 들어왔고 나간 부분을 정답 배열에 넣기 위해 다시 반복을 하면 된다
func solution(_ record:[String]) -> [String] {
    var id: [String: String] = [:]
    var answer: [String] = []
    
    for item in record {
        var splits = item.split(separator: " ")
        if splits[0] == "Enter" {
            id[String(splits[1]), default: ""] = String(splits[2])
        }
        else if splits[0] == "Change" {
            id[String(splits[1]), default: ""] = String(splits[2])
        }
    }
    
    for item in record {
        var splits = item.split(separator: " ")
        if splits[0] == "Enter" {
            answer.append("\(id[String(splits[1])]!)님이 들어왔습니다.")
        }
        else if splits[0] == "Leave" {
            answer.append("\(id[String(splits[1])]!)님이 나갔습니다.")
        }
    }
    
    return answer
}
