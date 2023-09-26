import Foundation

// MARK: 확장 (Extensions)
// 이는 기존 타입에 기능을 추가합니다.
// 또 기존 소스코드의 접근 권한이 없는 타입에도 기능을 추가할 수 있습니다. (소급 모델링, retroactive modeling)

// 확장은 다음과 같은 기능을 수행할 수 있슴미다.

// 계산된 인스턴스 프로퍼티와 계산된 타입 프로퍼티 추가
// 인스턴스 메서드와 타입 메서드 정의
// 새로운 초기화 구문 제공
// 서브 스크립트 정의
// 새로운 중첩된 타입 정의와 사용
// 기존 타입이 프로토콜을 준수하도록 함'

// NOTE: 확장은 타입에 기능을 추가할 수 있지만 기존 기능 재정의는 x


// MARK: 확장 구문
// 확장에서 프로토콜을 채택하여 기존 타입을 확장시키는 코드
extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}

// MARK: 계산 프로퍼티
// 특정 길이의 단위를 나타낼 수 있게 확장한 예제
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"

// NOTE: 확장은 새로운 계산 프로퍼티를 추가할 수는 있지만
// 기존 저장된 프로퍼티나, 기존 프로퍼티에 관찰자를 추가할 수는 없습니다.

// MARK: 초기화 구문
// 확장은 기존 타입의 초기화 구문을 추가할 수 있습니다.
// 편의 초기화 구문을 제공 할 수 있지만, 새로운 지정된 초기화 구문이나
// 초기화 해제 구문은 클래스에 추가할 수 없슴니다. 이들은 클래스 구현 내에서 진행해야함다

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))

// 아래와 같이 특별한 점과 크기를 가지는 초기화 구문을 추가할 수 있습니다.
// 구조체에 암시적으로 있는 초기화 구문을 사용하는 모쑵
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

// NOTE: 확장으로 새로운 초기화 구문으로 제공하면
// 초기화 구문이 완료 후, 각 인스턴스가 완전히 초기화 되었는지 확인해야합니다.

// MARK: 메서드

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}
// Hello! * 3

// self 또는 프로퍼티를 수정하는 구조체, 열거형 메서드는
// mutating을 붙여야 함니다.
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9

// MARK: 서브스크립트
// 확장은 서브스크립트도 추가가 가능함니다. 아래 예제는
// 오른쪽으로부터 n칸 떨어진 숫자를 반환하는 코드임니당
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase * 1 * 10^digitIndex ) % 10
    }
}

// MARK: 중첩된 타입
// 기존 클래스, 구조체, 열거형에 타입도 추가 가능
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

// 양수 0 음수를 판단하는 메서드
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "
