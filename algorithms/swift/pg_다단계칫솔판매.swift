import Foundation

// pg_다단계 칫솔 판매
// 자신의 수익을 위(부모노드)로 일정 비율 전달하는 문제
// 문제에서 주어진 조건대로 차례대로 풀었으면 간단히 풀리는 문제
// 였는데,, 종료 조건을 위에 부모가 "-" 인 경우에 종료하게 처음에 설정했는데
// 이 부분이 시간초과가 나서 seller를 합쳐서 줄여야겠다 라고 생각하고 접근했다가
// 오래 걸린문제,, 사실 seller에 중복된 경우도 있지만 합칠 필요가 없는게
// 부모노드로 계속 10 나누면서 가기때문에 아무리 가도 이번 문제에서는 위로 4~5개? 정도 밖에 탐색 안하므로
// 10만 * 5 정도이다.. 그래서 종료 조건을 바뀐 돈이 0 보다 클 때만 하믄 간단히 풀린다
func solution(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {
    var childs: [String : String] = [:]
    var moneys: [String: Int] = [:]

    enroll.forEach { people in
        moneys[people] = 0
    }

    for i in 0..<referral.count {
        childs[enroll[i]] = referral[i]
    }

    for (seller, value) in zip(seller, amount) {
        var money = value * 100

        var child = seller
        var parent = childs[child]!

        while child != "-" && money > 0 {
            var parentMoney = Int(Double(money) * 0.1)
            var myMoney = money - parentMoney

            if parentMoney > 0  {
                moneys[child]! += myMoney
            }
            else {
                moneys[child]! += money
            }

            child = parent
            parent = childs[child] ?? "-"
            money = parentMoney
        }
    }

    var result: [Int] = []
    for name in enroll {
        result.append(moneys[name]!)
    }

    return result
}
class Node {
    let name: String
    var amount = 0
    var referral: Node?

    init(_ name: String) {
        self.name = name
    }

    func add(_ amount: Int) {
        guard amount > 1 else { self.amount += amount; return }
        self.amount += amount - amount/10
        referral?.add(amount/10)
    }
}

func solution2(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {

    var tree = [String: Node]()

    enroll.forEach { tree[$0] = Node($0) }
    for i in 0..<enroll.count {
        guard referral[i] != "-" else { continue }
        tree[enroll[i]]!.referral = tree[referral[i]]!
    }

    for i in 0..<seller.count {
        tree[seller[i]]!.add(amount[i] * 100)
    }

    return enroll.map { tree[$0]!.amount }
}


