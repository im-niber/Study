import Foundation

// pg_성격 유형 검사하기
// 간단한 구현인데 상당히 오래걸림 아래 주석 코드로 value를 5,6,7로 통일해서 했더니 정확도 65로 틀렸다
// 어디서 틀린건지 거의 하루 생각하다가 value값을 문제대로 1,2,3 으로 맞춰서 하니 맞았다
// 아직도 이유를 모르겠다 후우.. 음수 계산이 조금 꼬여서 그런가 싶기도하고...?
func solution(_ survey:[String], _ choices:[Int]) -> String {
    var res = ""
    var personallty: [String: Int] = ["RT": 0, "CF": 0, "JM": 0, "AN": 0]
    
    let idx = ["RT", "CF", "JM", "AN"]
    let surveyScore = zip(survey, choices)
    
    for (key, value) in surveyScore {
        if value == 4 { continue }

        if personallty[key] != nil {
            if value > 4 { personallty[key]! += value - 4 }
            else { personallty[key]! -= (4 - value) }
            
            // value가 1 -> 7,  2 -> 6, 3 -> 5
            // if value > 4 { personallty[key]! += value }
            // else { personallty[key]! -= (8 - value) }
        }
    
        else {
            let key = String(key.reversed())
            if value > 4 { personallty[key]! -= value - 4 }
            else { personallty[key]! += (4 - value) }
        }
    }
    
    for item in idx {
        if personallty[item]! > 0 { res += String(item.last!) }
        else { res += String(item.first!) }
    }
    
    print(personallty)

    return res
}
