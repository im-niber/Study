// boj_30877
// 소프티어 문제풀어볼겸 풀어봐씀
let N = Int(readLine()!)!
var ans = ""
for _ in 0..<N {
    let arr = Array(readLine()!)
    
    for i in 0..<arr.count {
        if arr[i] == "x" || arr[i] == "X" {
            let char = arr[i + (arr.count / 2) + 1].uppercased()
            ans += char
            break
        }
    }
}
print(ans)
