import Foundation

// MARK: 프로토콜 (Protocols)
// 이는 준수하는 타입이 구현해야 하는 요구사항을 정의합니다.

// 이는 메서드, 프로퍼티, 특정 작업이나 기능의 요구사항의 청사진을 정의합니다.
// 또 요구사항의 구현을 제공하기 위해 클래스, 구조체, 또는 열거형에 의해 채택될 수 있습니다.
// 프로토콜의 요구사항에 충족하는 모든 타입은 프로토콜에 준수 한다고 합니다.


// MARK: 프로토콜 구문
protocol SomeProtocol {
    // protocol definition goes here
}

// 프로토콜을 채택하기 전에 클래스가 상위 클래스를 상속하고 있다면
// 프로토콜을 작성하기 전에 상위 클래스를 적도록 합시당

// MARK: 프로퍼티 요구사항
// 프로토콜은 특정이름과 타입을 가진 인스턴스 프로퍼티, 타입 프로퍼티를 제공하기 위해
// 아래와 같이 요구할 수 있슴니다.
// 이름과 타입, get set 여부만 정의하고 구현은 여기서는 하지 않슴니다.
// 만약 get, set을 가진 프로퍼티를 요구할 경우, 프로퍼티 요구사항으로
// 저장된 상수, 읽기전용 계산 프로퍼티로는 만족할 수 없습니다.
// 프로퍼티는 항상 var로 나타내야합니다.

protocol SomeProtocol2 {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    static var someTypeProperty: Int { get set }
}

// 아래 예시 코드는 단일 인스턴스 프로퍼티를 요구하는 프로토콜임니다
// 얘를 채택한 친구는 fullName 프로퍼티를 들고있어야 함니다.
protocol FullyNamed {
    var fullName: String { get }
}

// 위 FullyName를 채택하고 요구사항을 준수하는 예시.
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"


// 좀 더 복잡한 예시
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"

// MARK: 메서드 요구사항
// 프로토콜의 선언부에서는 중괄호를 포함하지 않습니다 -> 구현을 하지 않슴니다.
// 이 친구는 랜덤수가 생성되는 방법에 대해 어떠한 것도 가정하지 않슴니다.
// 단순히 새로운 난수를 생성하는 표준 방법을 제공만 하면 됨니다.
protocol RandomNumberGenerator {
    func random(value: Int) -> Double
}

// 난수 생성 구현은 채택한 클래스에서 진행하는 모 씁
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

// MARK: 변경 메서드 요구사항
// 인스턴스를 수정하는 메서드를 요구한다면 앞에 키워드로
// 무테이팅을 넣어야함니다. 그리고 클래스 타입에서는
// 무테이팅을 명시적으로 표현하지 않아도 댐니다. 구조체 열거형은 적어주십셔
protocol Togglable {
    mutating func toggle()
}

// 열거형에서 채택하는 모 씁
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on

// MARK: 초기화 구문 요구사항
// 초기화 구문도 메서드와 같이 선언만 하면 댐니다.
protocol SomeProtocol3 {
    init(someParameter: Int)
}


// 채택하는 곳에서는 required 를 명시적으로 적어줘야합니다.
// 이를 적어주면 하위 클래스에서도 명시적 또는 상속적 구현을 제공해주어서
// 프로토콜을 준수할 수 있슴니다.
class SomeClass: SomeProtocol3 {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

// NOTE: 만약 final 키워드가 붙은 클래스라면 더 이상 상속하지 않겠다는 의미이므로
// required를 붙이지 않아도 괜춘함다


// 만약 하위 클래스가 상위 클래스의 초기화 구문을 override하고
// 프로토콜로 해당 초기화 구문의 요구사항이 일치하면 required도 붙여줌니다
protocol SomeProtocol4 {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

// NOTE: 실패 가능한 초기화 구문도 당연히 정의 할 수 있슴니다.
// 얘는 실패 가능하거나 불가능한 초기화 구문으로 조건을 만족할 수 있슴니다
// 실패 불가능한 초기화 구문 요구사항은 실패 불가능 초기화 구문이나
// 암시적 언래핑된 초기화 구문으로 만족 할 수 있습니다.
protocol SomeProtocol5 {
    init?(value: Int)
}

class BBB: SomeProtocol5 {
    required init(value: Int) {
        print("hi")
    }
}

// MARK: 프로토콜을 타입으로 사용하는 경우

// 프로토콜 자체는 어떤 기능도 구현하지 않습니다.
// 타입으로 사용하는 경우에는, 일반 제약조건(Generic constraint)으로 사용하는 경우입니다.

// 불투명한 타입을 가지는 코드는 프로토콜을 준수하는 타입에서 동작합니다.
// 기본 타입은 컴파일타임에 알 수 있슴니다. API 구현은 해당 타입을 선택하지만
// 해당 타입의 식별자는 클라이언트에게 숨깁니다.

// 불투명한 타입을 사용하면 추상레이어를 통해 API의 자세한 구현이 노출되는 것을 방지할 수 있슴다

// 박스형 프로토콜 타입을 가지는 코드는 런타임 때 선택된 프로토콜을 준수하는 모든 타입에서 동작합니다.
// 런타임 유연성을 지원하기 위해 Swift는 필요할 때 성능 비용을 가지는 박스 (box) 라고 알려진 간접 참조 수준을 추가합니다.
// 유연성 때문에 Swift 는 컴파일 시에 기본 타입을 알 수 없습니다.
// 이것은 프로토콜에 의해 요구되는 멤버만 접근할 수 있다는 의미입니다.
// 기본 타입의 다른 API 에 접근하려면 런타임 시 캐스팅이 필요합니다.

// MARK: 위임 (delegation)
// 이는 클래스 또는 구조체가 책임의 일부를 다른 타입의 인스턴스에게 넘겨주거나
// 위임할 수 있도록 하는 디자인패턴입니다
// 이 디자인패턴은 위임된 기능을 제공하기 위해 대리가(준수하는타입)가 보장되도록
// 위임된 책임을 캡슐화하는 프로토콜을 정의하여 구현합니다.

// 위임은 특정 작업에 응답하거나 해당 소스의 기본 타입을 알 필요 없이
// 외부 소스에서 데이터를 검색하는데 사용할 수 있슴니당

// 주사위 게임 예제
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()

// 대리자를 설정해주는 모씁
game.delegate = tracker
game.play()

// MARK: 조건적으로 프로토콜 준수
// where 을 사용하여 배열의 원소가 TextRepresentable 인 경우에만
// 아래 내용을 구현하겠다는 의미임니다.
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)
// Prints "[A 6-sided dice, A 12-sided dice]"


// MARK: 합성된 구현을 사용하여 프로토콜 채택
// Swift에서는 다음 요구사항을 만족하면 Equatable의 구현을 합성하여 제공해줌니다.
// - Equatable 프로토콜을 준수하는 저장된 프로토콜만 있는 구조체
// - Equatable 프로토콜을 준수하는 연관된 타입만 있는 열거형
// - 연관된 타입이 없는 열거형
// 이런 케이스가 아니라면 == 연산자를 따로 구현해줘야함니다.

// 아래 처럼 명시적으로 선언해줌니다.
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}
// Prints "These two vectors are also equivalent."

// NOTE: Hashable도 위랑 같슴니다.

// MARK: 프로토콜 상속
// 프로토콜은 클래스와 같이 다른 프로토콜을 상속받을 수 있고
// 여러개를 콤마로 구분하여 받을 수도 있슴니다.

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

// MARK: 클래스 전용 프로토콜
// 프로토콜을 클래스에서만 채택할 수 있게 해줌니다. AnyObject !

protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // class-only protocol definition goes here
}

// MARK: 프로토콜 혼합
// 동시에 여러개의 프로토콜을 준수하는 타입을 요구하는 경우가 있을 수 있슴니다.
// & 기호를 사용하여 이럴 때 씀니다.

// 이는 프로토콜들의 요구사항을 결합하여 가진 임시 로컬 프로토콜로 정의된 것처럼 동작합니다.

// 이름과 나이를 혼합하여 쓰는 예제
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"

// 이번에는 상위 클래스를 상속받고 프로토콜도 채택하여 쓰는 예제
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// Prints "Hello, Seattle!"

// MARK: 옵셔널 요구사항
// 이는 구현을 안해도 괜찮은 요구사항임니다.
// 앞의 optional을 붙여줌니다. 그리고 이는 옵젝씨와 상호작용하는 코드도 작성이 가능합니다.
// 이 때는 앞의 @objc를 붙여줌니다. 프로토콜에도 해주어야함니다 !
// @objc는 클래스에서만 사용가능함니다~
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

// NOTE: optional을 붙인 요구사항은 타입이 전부 옵셔널로 변환됩니다.
