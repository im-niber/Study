import Foundation

// MARK: 에러 처리 (Error Handling)
// 이는 애러조건에서 응답하고 복구하는 프로세스입니다.
// Swift에서는 런타임에 복구 가능한 에러를 던지고 포착하고 전파하고 조작하기 위한 지원을 제공합니다.

// Swift에서 에러는 Error 프로토콜을 준수하는 타입의 값으로 표현됩니다.
// 예시에서는 자동판매기에 대한 예를 들고 있슴니다.
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
// 자동판매기의 코인이 5개가 더 필요하다는 에러를 발생시키는 코드
func coinErrorThrow() throws {
    throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
}
do {
    print(try coinErrorThrow())
} catch {
    print(error)
}

// MARK: 에러 처리 Handling Errors
// 에러가 발생시 주변 코드에서 에러 처리를 담당해야 합니다.
// Swift에서는 에러를 처리하는 4가지 방법이 있습니다.

// Note: Swift에서 에러 처리는 Objetive-C와 같은 다른 언어들과는 달리
// 계산 비용이 많이 드는 호출 스택 해제가 포함되지 않아 return의 특성과 비슷합니다.

// 함수를 이용하는 방법
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    // 에러를 던지는 함수에는 throws 라는 키워드를 붙여줘야함니다.
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        // 특정 조건을 만족하면 에러를 던지는 코드 부분
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
// 위의 에러를 던지는 함수를 호출하는 함수.
// 에러를 던지는 함수는 에러를 전파만 하기 때문에 호출한 곳에서 처리를 해줘야한다.
// 아래 함수에서는 try를 사용해서 에러를 계속 전파하려고 하는 즁
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

// 아래는 최종적으로 에러를 처리하는 do-catch문

// Note: do-catch문에서 catch 절에서 패턴이 없다면 모든 에러를 받고, error라는 상수로 에러를 바인딩합니다.

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
}
// 아래 catch 절에서는 VendingMachineError의 패턴들을 작성함
// 에러가 발생하지 않는다면, do 문에 나머지 구문들이 실행됩니다.
catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

// MARK: 에러를 옵셔널 값으로 변환
// 에러를 옵셔널 값으로 변환하기 위해 try? 문을 사용합니다. 에러가 발생하면 nil을 반환합니다.
func someThrowingFunction() throws -> Int {
    return -1
}

let x = try? someThrowingFunction()
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
// 이 방식을 사용해서 에러가 발생하면 nil로 처리하는 간결한 에러 처리 코드도 작성이 가능함니다.
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

// MARK: 정리 작업 지정
// 아래와 같이 return, 에러를 만나서 함수가 종료되기 전에
// 나머지 작업 처리를 defer문을 사용해서 할 수 있습니다.
// defer문은 작성된 순서와 반대로 실행되는 점을 유의하세요
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
