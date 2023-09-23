import Foundation

Swift.org에 초기화 부분 보고 공부한 코드
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    // 1개인 경우면 name 만 적도록 해서 편의성을 높임
    // 그리고 init(name: String)은 상위 클래스의 지정 초기화 구문이므로 override 해야함
    // 그 다음 convenience로 자신(하위)의 지정초기화구문을 불러주면서 매무리 .
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
    /// 이건 위와 같은 동작을 하도록 만들어 봄 두 개의 장단이 뭘가
    /// convenience가 더 깔끔한거 같긴 하네
//    override init(name: String) {
//        self.quantity = 1
//        super.init(name: name)
//    }
}


let ingred = RecipeIngredient(name: "Hihihihi")
print(ingred.quantity)
print(ingred.name)

/// 하위클래스에서 모든 초기화 구문을 구현했기 때문에 상위의 초기화 구문을 다 상속받음
/// 따라서 파라미터 전달 안 하고 초기화 가능. 그리고 이 초기화구문은 하위 클래스의 self.init(name:"[Unnamed")임.
/// 그러면 하위 클래스의 override convenience init(name: String)으로 들어가서 마무리가 되어 quantity도 1을 받음
let ingred2 = RecipeIngredient()
print(ingred2.quantity)
print(ingred2.name)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

let item1 = ShoppingListItem(name: "note")
print(item1.description)
item1.purchased = true
print(item1.description)

/// Failable Initializers 실패 가능한 초기화 구문
/// Int에서 exactly가 하나의 예시
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"

let valueChanged = Int(exactly: pi)
let value2 = Int(exactly: 23.0)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}
// Prints "3.14159 conversion to Int does not maintain value"

/// enum에 init? 추가하여 어떤 case를 고를지 할 수 이씀
/// 실패한 경우에는 return nil로 나타냄
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let temperaCase = TemperatureUnit(symbol: "T")
//print(temperaCase)

/// 만약 원시값을 가지고 있다면 자동으로 실패 가능한 초기화 구문을 받습니다.
enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

// 얜 자동으로 nil.
let unknownUnit = TemperatureUnit2(rawValue: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// Prints "This is not a defined temperature unit, so initialization failed."

/// 실패를 상위 클래스로 전파 가능함 만약 양이 1 이상이면서 이름이 nil이면 상위 초기화 구문에서 실패함다
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

/// 실패 가능한 초기화 구문의 오버라이딩도 가능함니다
/// 얘를 실패 불가한 초기화 구문으로 오버라이딩은 가능하지만 반대는 x.
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

/// 필수 초기화 구문. required 키워드를 붙여서 나타냄니다
/// 클래스의 하위클래스가 필수로 구현해야 하는 것을 나타냄니다
/// 하위클래스가 이를 재정의 할 때는 override 작성하지 x
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}
// MARK: 추가로, 다른 초기화 구문으로 이 필수 초기화 구문을 만족하면 얘를 명시적으로 또 작성하지 않아도 댐다

/// 클로저 또는 함수를 사용하여 기본 프로퍼티 값 설정
/// 프로퍼티에 좀 복잡한 경우가 있다면 아래와 같이 클로저나 함수를 통해 설정이 가능합니다.
/// 프로퍼티가 속한 타입의 새로운 인스턴스가 초기화 될 때마다 클로저나 함수는 호출되고 반환됩니다.
class SomeClassClosure {
    let someProperty: SomeType = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
    }() // 여기 괄호가 없다면 클로저 자체를 할당하고, 괄호가 있다면 swift가 바로 실행하여 반환 값을 할당합니다.
}

// MARK: 프로퍼티를 초기화하기 위해 클로저를 사용하면, 클로저가 실행될 때는 인스턴스가 초기화 되지 않았다는 것을 명심해야합니다. 이는 다른 프로퍼티에 접근이 불가함을 의미합니다. 해당 클래스의 메소드도 x.
