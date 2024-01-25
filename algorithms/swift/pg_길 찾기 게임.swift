import Foundation

// pg_길 찾기 게임
// 트리를 만들고 전위, 후위 순회한 값을 리턴하면 되는 문제인데
// 트리를 만드는 과정에서 반복문을 좀 더 써서 16,18 케이스가 시간초과가 나버린 코드....
// 이래저래 반복횟수를 줄여보았지만 x..
// 다른 분의 풀이와 비교했을때 내 풀이는 높이를 내림차순으로 해서
// 다음 높이를 비교하는식으로 했는데 이러지 말고
// 노드의 x 값으로 정렬을 한 후에 루트노드로부터 탐색을 시작해도
// 값은 알맞게 들어가기 때문에 반복을 더 줄여서 풀수가 있다,, 요렇게했어야함..
func solution(_ nodeinfo:[[Int]]) -> [[Int]] {
    
    class Node {
        let idx: Int
        let x: Int
        let y: Int
        
        var parentIdx: Node?
        var leftIdx: Node?
        var rightIdx: Node?
        
        init(idx: Int, x: Int, y: Int) {
            self.idx = idx
            self.x = x
            self.y = y
        }
    }
    
    var heights: [Int: [Node]] = [:]
    var answer: [[Int]] = []
    var rootNode: Node = Node(idx: -1, x: -1, y: -1)
    var heightIdx: Set<Int> = []
    
    for i in 0..<nodeinfo.count {
        let node = Node(idx: i + 1, x: nodeinfo[i][0], y: nodeinfo[i][1])
        heights[node.y, default: []].append(node)
        if rootNode.y < node.y { rootNode = node }
        heightIdx.insert(node.y)
    }
    
    let valueY: [Int] = Array(heightIdx).sorted(by: >)

    func search(_ target: Node, _ newNode: Node, _ start: Node = rootNode) {
        if start.x < newNode.x {
            if start.rightIdx == nil {
                if start.idx == target.idx {
                    start.rightIdx = newNode
                    newNode.parentIdx = target
                    return
                }
                else { return }
            }
            else { search(target, newNode, start.rightIdx!) }
        }
        
        else {
            
            if start.leftIdx == nil {
                if start.idx == target.idx {
                    target.leftIdx = newNode
                    newNode.parentIdx = target
                    return
                }
                else { return }
            }
            
            else { search(target, newNode, start.leftIdx!) }
        }
    }
    
    for item in heights[valueY[1]] ?? [] {
        if item.x > rootNode.x { rootNode.rightIdx = item }
        else { rootNode.leftIdx = item }
        
        item.parentIdx = rootNode
    }
    
    for i in 1..<valueY.count - 1 {
        for item in heights[valueY[i]]! {
            for newNode in heights[valueY[i + 1]]! {
                search(item, newNode)
            }
        }
    }
    
    var array: [Int] = []
    
    func preorder(node: Node?) {
        if node == nil { return }
        array.append(node!.idx ?? -1)
        preorder(node: node!.leftIdx)
        preorder(node: node!.rightIdx)
    }
    
    func postorder(node: Node?) {
        if node == nil { return }
        postorder(node: node!.leftIdx)
        postorder(node: node!.rightIdx)
        array.append(node!.idx ?? -1)
    }
    
    preorder(node: rootNode)
    answer.append(array)
    
    array.removeAll()
    
    postorder(node: rootNode)
    answer.append(array)
    
    return answer
}

// 다른 분의 풀이
// https://jeong9216.tistory.com/377
class Tree {
    var value: Int
    var x: Int
    var y: Int
    var leftChild: Tree?
    var rightChild: Tree?
    var parent: Tree?

    init(x: Int, y: Int, value: Int) {
        self.x = x
        self.y = y
        self.value = value
    }

    func addChild(_ node: Tree) {
        if node.x < self.x {
            if leftChild != nil {
                leftChild?.addChild(node)
            } else {
                leftChild = Tree(x: node.x, y: node.y, value: node.value)
                leftChild?.parent = self
            }
        } else {
            if rightChild != nil {
                rightChild?.addChild(node)
            } else {
                rightChild = Tree(x: node.x, y: node.y, value: node.value)
                rightChild?.parent = self
            }
        }
    }
}

func preOrder(_ tree: Tree) -> [Int] {
    var values: [Int] = []

    values.append(tree.value)
    if let leftChild = tree.leftChild {
        let leftOrder = preOrder(leftChild)
        values.append(contentsOf: leftOrder)
    }

    if let rightChild = tree.rightChild {
        let rightOrder = preOrder(rightChild)
        values.append(contentsOf: rightOrder)
    }

    return values
}

func postOrder(_ tree: Tree) -> [Int] {
    var values: [Int] = []

    if let leftChild = tree.leftChild {
        let leftOrder = postOrder(leftChild)
        values.append(contentsOf: leftOrder)
    }

    if let rightChild = tree.rightChild {
        let rightOrder = postOrder(rightChild)
        values.append(contentsOf: rightOrder)
    }
    values.append(tree.value)

    return values
}

func solution(_ nodeinfo:[[Int]]) -> [[Int]] {
    var nodes: [Tree] = []
    for node in nodeinfo {
        let treeNode = Tree(x: node[0], y: node[1], value: nodes.count+1)
        nodes.append(treeNode)
    }
    nodes.sort { $0.y > $1.y }

    let tree: Tree = nodes.first!
    for i in 1..<nodes.count {
        let node = nodes[i]
        tree.addChild(node)
    }

    let pre = preOrder(tree)

    let post = postOrder(tree)

    return [pre, post]
}
