import Foundation

// pg_디펜스게임
// 힙을 사용하지 않고 해보려다가 힘든것같아서 결국 힙을 사용해서 풀었다
// 힙 코드는 아래 유명하신블로거분의 코드를 참고하였다. (담에 함 구현해봐야게씀)
// k를 전부 사용하고 제일 작은 k를 바꿔치기 하면서 비교를하면 몇 라운드가 나온다
func solution(_ n:Int, _ k:Int, _ enemy:[Int]) -> Int {
    var minheap = Heap<Int>(sortFunction: <)
    var n = n, k = k
    
    for i in 0..<enemy.count {
        if k > 0 {
            minheap.insert(node: enemy[i])
            k -= 1
        }
        else {
            if enemy[i] > minheap.root! && n >= minheap.root! {
                n -= minheap.remove()!
                minheap.insert(node: enemy[i])
            }
            else {
                if n >= enemy[i] {
                    n -= enemy[i]
                }
                else { return i }
            }
        }
    }
    
    return enemy.count
}

// 코드참고 : https://jeonyeohun.tistory.com/325
struct Heap<T: Comparable> {
    private var elements: [T] = []
    private let sortFunction: (T, T) -> Bool
    
    var isEmpty: Bool {
        return self.elements.count == 1
    }
    var peek: T? {
        if self.isEmpty { return nil }
        return self.elements.last!
    }
    var count: Int {
        return self.elements.count - 1
    }
    var root: T? {
        if self.isEmpty { return nil }
        return self.elements[1]
    }
    
    init(elements: [T] = [], sortFunction: @escaping (T, T) -> Bool) {
        if !elements.isEmpty {
            self.elements = [elements.first!] + elements
        } else {
            self.elements = elements
        }
        self.sortFunction = sortFunction
        if elements.count > 1 {
            self.buildHeap()
        }
    }
    
    func leftChild(of index: Int) -> Int {
        return index * 2
    }
    func rightChild(of index: Int) -> Int {
        return index * 2 + 1
    }
    func parent(of index: Int) -> Int {
        return (index) / 2
    }
    mutating func add(element: T) {
        self.elements.append(element)
    }
    mutating func diveDown(from index: Int) {
        var higherPriority = index
        let leftIndex = self.leftChild(of: index)
        let rightIndex = self.rightChild(of: index)
        
        if leftIndex < self.elements.endIndex && self.sortFunction(self.elements[leftIndex], self.elements[higherPriority]) {
            higherPriority = leftIndex
        }
        if rightIndex < self.elements.endIndex && self.sortFunction(self.elements[rightIndex], self.elements[higherPriority]) {
            higherPriority = rightIndex
        }
        if higherPriority != index {
            self.elements.swapAt(higherPriority, index)
            self.diveDown(from: higherPriority)
        }
    }
    mutating func swimUp(from index: Int) {
        var index = index
        while index != 1 && self.sortFunction(self.elements[index], self.elements[self.parent(of: index)]) {
            self.elements.swapAt(index, self.parent(of: index))
            index = self.parent(of: index)
        }
    }
    mutating func buildHeap() {
        for index in (1...(self.elements.count / 2)).reversed() {
            self.diveDown(from: index)
        }
    }
    mutating func insert(node: T) {
        if self.elements.isEmpty {
            self.elements.append(node)
        }
        self.elements.append(node)
        self.swimUp(from: self.elements.endIndex - 1)
    }
    mutating func remove() -> T? {
        if self.isEmpty { return nil }
        self.elements.swapAt(1, elements.endIndex - 1)
        let deleted = elements.removeLast()
        self.diveDown(from: 1)
        
        return deleted
    }
}
