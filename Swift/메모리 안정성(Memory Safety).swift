import Foundation

// MARK: 메모리 안전성 (Memory Safety)
// 메모리에 접근할 때 충돌을 피하기위해 코드를 구조화합니다

// Swift는 메모리의 위치를 수정하는 코드가 해당 메모리에 대한 독점 접근 권한을
// 갖도록 요구함으로써 동일 메모리 영역에 대한 다중 접근이 충돌나지 않도록함니다.
// 대부분 Swift가 자동으로 관리해서 접근에 대해 생각할 필요는 없지만
// 잠재적으로 충돌이 발생할수 있다는 것을 이해하는것은 중요함니다 !

// MARK: 메모리 충돌하는 접근 이해
// 메모리에 접근하는 것은 변수의 값을 설정하거나 함수에 인수를 전달하는 것과
// 같은 동작을 할 때 발생함니다.

// A write access to the memory where one is stored.
var one = 1

// A read access from the memory where one is stored.
print("We're number \(one)!")

// 메모리에 충돌하는 접근은 코드의 다른 부분이
// 같은 시간, 메모리의 같은 위치에 접근시 발생할 수 있습니다.

/// 아마 let은 다중 접근이 될 거 같고, var는 다중 접근을 막지 않을까 싶음
/// let은 결국 read-only라서 여러곳에서 접근을 해도 문제가 없..지않을까 싶은 생각이 들긴함 좀 더 알아봐야겠디만

// MARK: 메모리 접근의 특징
// 충돌 접근의 맥락에서 고려해야 할 메모리 접근의 3가지 특성이 있습니다.
// 접근하는 동안 읽기 또는 쓰기 접근인지 여부, 접근된 메모리의 위치 임니다.
// 아래의 조건을 모두 만족하는 2개의 접근이 있다면 충돌이 발생합니다.

// - 적어도 하나의 쓰기 접근 또는 nonatomic 접근
// - 메모리의 같은 위치에 접근
// - 접근 시간이 겹침

// 쓰기 접근은 메모리의 위치를 변경합니다 !
// 접근이 시작되고 종료되기 전에 다른 코드를 실행할 수 없는 경우
// 접근은 즉시 이루어집니당, 일반적으로 2개의 즉시 접근은 동시에 발생할 수 x
// 아래 코드의 접근들은 전부 즉각적임니다
func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// Prints "2"

// 그러나 다른 코드 실행에 걸쳐있는 장기(long-term)접근이라는 메모리 접근 방법은 여러가지임다
// 장기 접근이 시작되고 종료 전에 다른 코드가 실행될 수 있다는 점이 차이가 있슴니다.
// 이를 오버랩(overlap)이라 함니다.

// 겹치는 접근은 주로 함수와 메서드에서 in-out 파라미터를 사용하거나
// 구조체의 변경하는 메서드를 사용하는 코드에서 나타남니다.

// MARK: In-Out 파라미터에 충돌 접근
// 함수는 모든 in-out 파라미터에 장기 쓰기접근을 가지고 있슴니다.
// 이 파라미터에 대한 쓰기 접근은 모든 non-in-out 파라미터가 평가된 후에
// 시작되고 해당 함수를 호출하는 동안 지속됩니당
// 아래 예제는 충돌이 일어나서 런타임 에러가 발생함니다.
var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

increment(&stepSize)
// Error: conflicting accesses to stepSize

// stepSize에 읽기 접근은 number에 쓰기 접근과 오버랩됨니다.
// number, stepSize 모두 같은 메모리 위치를 참조하고, 읽기 쓰기 접근은 같은 메모리를
// 참조하고 오버랩되어 충돌이 발생함다

// 이를 해결하는 방식은 복사본을 사용하여 전달하면 해결가능함니다.

// 또 in-out 파라미터를 여러 개 사용시에
// 같은 변수를 전달하면 충돌이 일어남니다
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
balance(&playerOneScore, &playerOneScore) // 컴파일에러러
// Error: conflicting accesses to playerOneScore

// MARK: 메서드에서 self에 충돌 접근
// 구조체 변경 메서드는 호출 동안 self에 대한 쓰기 접근을 가짐니다.
// 아래와 같은 예제가 있다고 할 때
struct Player {
    var name: String
    var health: Int
    var energy: Int

    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

// 위 restoreHealth() 메서드에서 self 쓰기 접근은 메서드 처음에서 시작하고
// 반환될 때까지 유지됨니다. 이 경우 메서드 내부에 Player 인스턴스 프로퍼티에
// 중복 접근하는 다른 코드는 없슴니다.

// 아래 메서드 shareHealth(with:)은 in-out 파라미터로 다른 Player 인스턴스를
// 가지고 있으며 중복 접근에 대한 가능성을 만듬니다.
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
// 이 코드처럼 다른 인스턴스를 전달하는 것은
// 접근할 때 다른 메모리 위치를 접근한다는 뜻이므로
// 쓰기 접근이 동시에 오버랩되지만 충돌이 일어나지x

oscar.shareHealth(with: &oscar)
// Error: conflicting accesses to oscar
// 이 경우는 같은 위치에 접근하므로 errorrrrr!

// MARK: 프로퍼티에서 충돌 접근
// 구조체, 튜플, 열거형 같은 타입은 프로퍼티 또는 튜플의 요소와 같은
// 개별 구성값으로 구성됨니다. 이는 값 타입이기 때문에
// 값의 일부분을 변경하면 전체 값이 변경됩니다.
// 이는 프로퍼티 중 하나에 읽기 또는 쓰기 접근은 전체 값에 읽기 또는 쓰기 접근을 요구함니다 !

// 따라서 아래 코드는 에러를 발생시킴
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// Error: conflicting access to properties of playerInformation

// 또 아래 코드는 전역 변수에 저장된 구조체 프로퍼티에
// 쓰기 접근이 중복시 동일 에러가 발생하는 것을 보여줌니다
var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)  // Error

// 하지만 지역 변수로 변경된다면 컴파일러는
// 구조체의 저장된 프로퍼티에 중복 접근이 안전하다고 증명할 수 있슴니다.
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}
// 위 메서드는 health, energy가 어떤식으로도 상호작용하지 않으므로
// 컴파일러는 메모리 안전성이 안전하다고 증명할 수 있슴니다. 아래 내용 참조

// NOTE: 구조체 프로퍼티에 중복 접근에 대한 제한은 메모리 안정성을 위해 항상 필요한 것은 x
// 메모리 안정성은 보장되지만 배타적 접근(exclusive access)은 메모리 안정성보다 더 엄격한 요구사항임니다.
// 이것은 일부 코드는 메모리에서 배타적 접근을 위반하더라도 메모리 안정성을 유지한다는 의미임니다.
// Swift는 컴파일러가 메모리에 배타적이지 않은 접근(nonexclusive access)이
// 여전히 안전하다고 증명할 수 있다면 메모리 안전 코드를 허용합니다.
// 아래 조건이 적용되면 구조체의 프로퍼티에 중복 접근은 안전하다고 증명이 가능함니다.

// - 계산된 프로퍼티 또는 클래스 프로퍼티가 아닌 인스턴스의 저장된 프로퍼티만 접근
// - 구조체는 지역변수
// - 구조체는 클로저에 의해 캡처되지 않거나 nonescaping 클로저에 의해서만 캡처됩니당
