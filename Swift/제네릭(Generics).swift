import Foundation

// MARK: 제네릭 (Generics)
// 이는 여러 타입에 대한 동작을 작성하고 해당 타입의 요구사항을 지정합니다.

// 제네릭은 정의한 요구사항에 따라 모든 타입에서 동작할 수 있는 유연하고 재사용 가능한 함수와 타입을 작성할 수 있습니다
// 중복을 피하고 명확하고 추상적인 방식으로 의도를 표현하는 코드를 작성할 수 있습니다

// 제네릭 예시, a,b가 모두 같은 타입이여야 한다고 말을 해주고 있슴니다 그리고
// 이 괄호안에 있는 T는 함수 정의 내에서 사용할 임의의 타입이라고 말을 하고 있슴니다.
// 임의 타입이므로 swift는 T의 실제 타입을 찾지 x
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 호출될 때 유추가댐니다.
var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

// MARK: 타입 파라미터
// 위 함수의 T는 타입 파라미터의 예시임니다. 타입파라미터는 임의의 타입을 지정하고
// 이름을 지정하며 꺽쇠 괄호 사이에 기록하고 함수 이름 뒤에 바로 작성됩니다.
// 함수가 호출될 때 실제 타입으로 유추댐니다. 그리고 여러개의 타입 파라미터도 작성이 가능함다

// MARK: 제네릭 타입
// 제네릭 함수 외에도 고유한 제네릭 타입을 만들 수 있슴니다.
// 스택을 만드는 예시 ~ Element라는 타입 파라미터를 사용함다
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// MARK: 제네릭 타입 확장
// 제네릭 타입을 확장할 때는 타입 파라미터를 적진 않슴니다.
// 대신 내부 본문에서 참조 가능함니다.
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// MARK: 타입 제약
// 제네릭에 제약을 걸어서 특정 타입에서만 사용이 가능하게
// 만드는 것이 더 유용할 수도 있습니다.
// 예로는, 딕셔너리의 Key는 Hashable을 만족하는 타입만 채택이 가능함다.

// 함수에서 사용하는 예시, T,U는 어떤 클래스, 프로토콜을 만족해야 한다
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}

// 타입 제약 동작
// 아래 함수를 제네릭하게 바꾸고,
// 제약을 걸어서 적절하게 동작을 하게끔 하는 예시
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// Equatable이 없다면, == 연산을 못하므로 제약을 걸어주는 모씁
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// MARK: 연관된 타입 (Associated Type)
// 프로토콜을 정의할 때 프로토콜의 정의 부분으로 하나 이상의 연관 타입을
// 사용하는게 유용할 때가 있습니다.
// 연관된 타입은 프로토콜에서 사용할 타입을 임의의 이름을 제공해줌니다
// 이 연관타입에 사용할 실제 타입은 프로토콜이 채택 되기 전까지 지정되지 않습니다.

// 사용예시
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 위 Container를 사용하고,
// 프로토콜 내부에서 추상적인 타입이었던 Item을
// Int의 구체적인 타입으로 변환시키는 모씁~
struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    
    typealias Item = Int // 얘를 지워도 프로토콜을 만족함

    // append에서 item에 Int를 주었기 때문에
    // Swift에서 타입추론이 되기 때문임
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// 연관된 타입에 제약 추가
// 위의 Container 프로토콜에서 제약을 추가한 ver
// Item은 이제 Equatable을 만족하는 타입만 올 수 이씀!
protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 연관된 타입에 제약으로 프로토콜 추가
// 아래 코드 이해가 조금 어려웠는데
// Suffix는 일단 자신의 프로토콜을 만족시켜야 하는 타입임 그리고 where절로
// 제약을 하나 더 추가해서 Container 프로토콜의 Item과 같은지를 봄
// 그래서 자기 자신한테 얘를 채택시키고 써도 대고 다른 애한테 이걸 만족시킨 후에
// 여기서 써도 댐다
// 상속 같기도하고~?
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}
// Swift language guide 에서는 얘를 Suffix 메소드를 추가하여
// Container 프로토콜을 좀 더 구체화 하는 프로토콜이라고 명시하여씀

// MARK: 제네릭 Where 절
// 아래와 같이 함수 중괄호 전에 where을 적고 콤마로 몇가지 제약을 더 거는것도 가능함다
// 아래의 C1,C2는 같은 컨테이너일 필요는 없지만,
// 내부 Item이 같아야 함을 where절로 나타내고 있고, 비교를 위해 Equatable도 채택하고 있슴니다.
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {

        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        // All items match, so return true.
        return true
}

// 프로토콜 확장에 제네릭 where절을 사용하는 코드
// Container 프로토콜에서 Item을 Equatable로 조건을 주고
// 내부 구현하는 함수에서 프로토콜에서 선언한 subscript문법을 사용하여 결과를 반환함
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

// MARK: 제네릭 서브스크립트
// 아래는 Container 프로토콜의 서브스크립트로
// Sequence를 만족하는 타입 파라미터를 받고 있다
// indices라는 Indices 타입의 인스턴스를 하나 받고 있고, 얘는
// where절 조건에 의해 Int 시퀀스 임을 알 수 이씀.
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result: [Item] = []
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
