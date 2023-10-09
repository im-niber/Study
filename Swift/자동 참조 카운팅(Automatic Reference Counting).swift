import Foundation

// MARK: 자동 참조 카운팅 Automatic Reference Counting
// 객체의 라이프타임과 관계를 모델링함니다.

// Swift는 앱의 메모리 사용량을 추적하고 관리를 위해 ARC를 사용합니다
// ARC는 인스턴스가 더 이상 필요하지 않을 때 자동으로 인스턴스에 사용하는 메모리를 할당 해제합니다
// 하지만 몇몇 경우에 코드에서 주의할 점이 있기 때문에 그런 점 위주로 살펴보겠슴니다.

// 추가로 참조 카운팅은 클래스의 인스턴스에만 적용됩니다. 구조체, 열거형은x.

// MARK: ARC의 작동 원리
// 클래스의 새 인스턴스가 생성될 때마다 ARC는 인스턴스에 대한 정보를 저장하기 위해 메모리 청크에 할당함니다
// 이 메모리는 해당 인스턴스와 관련된 저장 프로퍼티 값과 함께 타입에 대한 정보를 가집니다

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// 아래 처럼 생성하면 강한 참조 1개가 설정됨니다.
var reference1: Person? = Person(name: "John Appleseed")
// Prints "John Appleseed is being initialized"

var reference2: Person? = reference1
var reference3: Person? = reference1
// 같은 인스턴스를 다른 변수에 할당하여도 강한참조가 추가로 설정됨니다.

reference1 = nil; reference2 = nil; reference3 = nil
// // Prints "John Appleseed is being deinitialized"
// 위 처럼 모두 nil로 설정해야 강한참조카운트가 0이되어 Person 인스턴스를 할당 해제함니다.

// MARK: 강한 참조 사이클
// 메모리 leak이 발생하는 유명한 친구임니다.
// 얘는 클래스가 2개가 있고 서로서로를 강하게 참조하고 있다면 일어나는 문제임니다.
class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person2?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var john = Person2(name: "John Appleseed")
var unit4A = Apartment(unit: "4A")
john.apartment = unit4A
unit4A.tenant = john
// 얘네 둘을 nil 하여도 서로서로를 바라보는 부분은 끊기지가 않았기 때문에
// 강한참조는 0이 아니기 때문에 할당 해제 하지 않슴니다

// MARK: 강한 참조 사이클 해결
// 약한 참조와 미소유 참조로 해결을 주로 합니다.
// weak, unowned
// weak를 사용하는 경우는 다른 인스턴스가 먼저 할당 해제될 수 있을 때 사용한다고 함니다
// unowned는 다른 인스턴스의 수명이 동일하거나 더 긴 경우 얘를 사용함니다

/// 보통 weak를 주로 사용하는듯,, unowned 를 사용하는 경우는 거의 본 적이 업슴..

// MARK: 약한 참조 (Weak Reference)
// 얘는 참조하는 인스턴스를 강하게 유지하지 않기 때문에
// 참조하는 동안 해당 인스턴스가 할당 해제될 수 있습니다.
// 따라서 ARC는 참조하는 인스턴스가 할당 해제되면 nil로 약한 참조를 자동으로 설정함니다
// 그리고 얘는 런타임에 값을 nil로 변경하는 것을 허락해야 하므로 항상 옵셔널 타입의 변수로 선언됨니다

/// NOTE: 프로퍼티 관찰자는 ARC가 약한 참조를 nil로 설정할 때 호출되지 x

/// NOTE: 가비지 콜렉션을 사용하는 시스템에서는 얘를 트리거 할 때만 강한 참조가 없는 객체를 할당해제 하기 때문에
/// 간단한 캐싱 매커니즘에서 약한 포인터가 사용되는 경우가 있습니다
/// 하지만 ARC는 마지막 강한 참조가 제거되자마자 값이 할당해제 되기 때문에 약한 참조는 이러한 목적에 적합하지 x

// MARK: 미소유 참조 (Unowned Reference)
// 약한 참조와 차이점으로 다른 인스턴스의 수명이 같거나 더 긴 경우에 사용됨니다.
// 그리고 얘는 항상 값을 갖도록 예상됨니다. 따라서 옵셔널로 만들어 지지 않고
// ARC는 미소유 참조 값을 nil로 설정하지 x

/// IMPORTANT: 얘는 항상 할당 해제되지 않을 인스턴스를 참조한다고 확신하는 경우에만 사용합니다.

// unowned를 사용할 수 있는 카드, 고객 예제
// 카드쪽에서는 항상 고객과 연관이 되어 있기 때문에 unowned 예제에 적합한둣
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}
// 카드 인스턴스는 참조하는 고객보다 오래 지속되지 않기 때문에 여기서 사용함
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var john2: Customer? = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)
john2 = nil
// Prints "John Appleseed is being deinitialized"
// Prints "Card #1234567890123456 is being deinitialized"

// MARK: 미소유 옵셔널 참조(Unowned Optional References)
// 옵셔널로도 만들 수 있슴니다. 약한 참조와 크게 사용법은 다르지 않슴니다
// 값이 nil이 아닌지, 유효한 객체를 참조하는지 확인해야함니다
// 얘는 래핑하는 클래스의 인스턴스에 강하게 유지하지 않으므로
// ARC가 인스턴스를 할당 해제하는 것을 방지하지 x

// MARK: 미소유참조와 암묵적 언래핑된 옵셔널 프로퍼티
// 위에서 본 상황들과 달리, 두 프로퍼티 모두 항상 값이 있고
// 초기화가 완료되면 nil이 되어서는 안되는 세번째 시나리오가 있습니다.
// 이런 경우, 한 크래스의 미소유 프로퍼티를 다른 클래스에 암시적으로 언래핑된 옵셔널 프로퍼티와
// 결합하는 것이 유용합니다.

class Country {
    let name: String
    var capitalCity: City! // 암시적 언래핑
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
// 위에 초기화 구문에서는 captialCity가 초기화 되기 전에는
// self를 사용 못함니다 하지만 암시적 언래핑을 하였기 때문에
// capitalCity는 nil의 기본값을 가지고,
// 언래핑 할 필요없이 값에 접근 가능하기 때문에 사용 가능한 모씁..!

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

// MARK: 클로저에 대한 강한 참조 사이클
// 강한참조 사이클은 클래스 인스턴스의 프로퍼티에
// 클로저를 할당하고 해당 클로저 본문에 인스턴스를 캡처(capture)하는
// 경우에도 발생할 수 있습니다. self를 캡처 하는 경우에 주로 발생함니다.

// HTML 클래스 예제
class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// asHTML 얘는 인스턴스 메서드가 아니라 클로저이기 때문에
// 특정 html 요소에 관해 처리를 변경할 수도 있슴니다
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// Prints "<h1>some default text</h1>"

// HTMLElement 인스턴스와 기본 asHTML 값으로 사용된 클로저 간에 강한 참조사이클이 있슴니다.
// asHTML 프로퍼티는 클로저에 대한 강한 참조를 유지합니다.
// 클로저는 본문 내에서 self.name, self.text를 참조하는것 처럼 self를 참조하기 때문에 생김니다
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

// NOTE: 클로저는 여러번 self를 참조하지만 HTMLElement 인스턴스에 대해 하나의 강한 참조만 캡처합니다

// MARK: 클로저에 대한 강한참조사이클 해결
// 해결방법은, 클로저의 정의 부분으로 캡처 리스트(capture list)를 정의하여
// 클로저와 클래스 인스턴스 간의 강한 참조 사이클을 해결합니다.
// 캡처리스트는 클로저 본문 내에서 하나 이상의 참조 타입을 캡처할 때 사용할 규칙을 정의합니다.

// NOTE: Swift는 클로저 내에서 self의 멤버를 참조할 때마다 self. 을 붙여서 작성함니다.
// 이는 실수로 self를 캡처할수 있는 것을 기억하는데 도움이 된다고 하네요

// MARK: 캡처 리스트 정의
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate]
    (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}

// 클로저는 컨텍스트로부터 타입을 유추할 수 있기 때문에 생략해도 됨니다
lazy var someClosure2 = {
    [unowned self, weak delegate = self.delegate] in
    // closure body goes here
}

// 미소유 참조를 사용하여 사이클을 해결하는 HTMLElement 클래스
class HTMLElement2 {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// 위 클래스에서는 이제 asHTML이 self를 미소유참조로 참조하기 때문에
// 강한 참조 사이클이 일어나지 않습니다.
