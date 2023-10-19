import Foundation

// pg_스킬트리
// skill에 있는 문자열의 순서대로 있는지 보는 문제
// 간단한문제였고, skill을 전부 배우지 않아도 괜찮은 조건도 빨리 확인했으면
// 더 빨리풀었을둣
func solution(_ skill:String, _ skill_trees:[String]) -> Int {
    var ans = 0
    let skill_trees = skill_trees.map { Array($0) }
    
    for item in skill_trees {
        var stack: [String] = []
        var skill = Array(skill.reversed())
        var flag = true
        
        for s in item {
            if s == skill.last { stack.append(String(skill.removeLast())) }
            else if skill.contains(s) { flag = false; break; }
        }
        
        flag ? ans += 1 : ()
    }

    return ans
}
