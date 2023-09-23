import Foundation

// 대부분은 아는 내용이였지만, 복습하는생각으로 읽어보았슴니다~

// 옵셔널 체이닝 Optional Chaining
// 언래핑 없이 옵셔널 값에 접근이 가능합니다.
// 옵셔널에 값이 있다면 호출이 성공하고 하나라도 nil이라면 체이닝은 실패하고 nil이 반환됩니다.
// 옵셔널에 값이 있어도 체이닝은 nil의 여부를 판단하기 위해 옵셔널로 감싸서 반환합니다.

class Person {
    var residence: Residence?
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

// MARK: 옵셔널 체이닝을 통한 프로퍼티 접근
let john = Person()
print(john.residence?.address) // nil, residence가 nil이기 때문

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}
john.residence?.address = createAddress() // createAddress는 호출되지 않는다.

// MARK: 여러 수준의 체인연결

// 아래는 address가 없어서 nil이 반환됩니다.
// 주의할 점은 street를 보려고 했기 때문에 johnsStreet의 타입은 String? 이라는 점입니다.
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."

// MARK: 사용된 체이닝의 수준과는 상관없이 접근하는 값의 옵셔널로 타입이 정해짐니다.

// address를 정해주면, 아래와 같이 접근이 가능한 모습
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "John's street name is Laurel Street."

// MARK: 옵셔널 반환값으로 메서드 체이닝
// 메소드도 호출이 가능하며, 소괄호 뒤에 물음표를 붙여서 하면 된다 ~
if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// Prints "John's building identifier begins with "The"."
