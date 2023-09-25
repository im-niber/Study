import Foundation

// MARK: 매크로 Macros
// 이는 컴파일 타임에 코드를 생성하기 위해서 사용합니다.
// 매크로는 컴파일 타임에 코드를 변환하므로, 반복적인 코드를 직접 작성하지 않아도 됨니당.

// Swift에서는 두 종류의 매크로를 제공합니다.
// - 독립 매크로 (Freestanding macro)는 선언에 첨부되지 않고 자체적으로 나타납니다.
// - 첨부 매크로 (Attached macro)는 매크로가 첨부된 선언을 수정합니다.

// MARK: 독립 매크로, 매크로 이름앞에 #을 붙이고, 소괄호안에 매크로의 인수를 입력합니다.
func myFunction() {
    print("Currently running \(#function)") // #function은 함수 이름으로 대체하는 매크로
    #warning("Something's wrong22") // 얘는 사용자 지정 컴파일 경고를 띄워줌
}
myFunction()

// MARK: 첨부 매크로, 매크로 이름 앞에 @를 붙이고, 이름 뒤 소괄호에 인수를 작성합니다.
// 얘는, 첨부된 선언을 수정합니다. 새로운 메서드를 정의하거나
// 프로토콜의 준수성을 추가하는 것과 같이 코드를 추가합니다.

// 먼저 매크로를 사용하지 않는 코드를 보겠슴미다.
struct SundaeToppings: OptionSet {
    let rawValue: Int
    static let nuts = SundaeToppings(rawValue: 1 << 0)
    static let cherry = SundaeToppings(rawValue: 1 << 1)
    static let fudge = SundaeToppings(rawValue: 1 << 2)
}

// OptionSet매크로를 사용하면 private enum Options의 목록들을 읽고,
// 각 케이스에 대해 static let으로 만들어주고, OptionSet 프로토콜을 채택시켜줌미다.

@OptionSet<Int>
struct SundaeToppings2 {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }
}

// MARK: 매크로 선언
// macro를 쓰고, 매크로 이름, 매크로의 인수를 작성합니다.
// 두 번째 줄에서 매크로의 구현위치를 알려줍니다.
// 이 매크로는 첨부매크로이므로, 대문자 카멜 케이스를 준수해야합니다.
public macro OptionSet<RawType>() =
        #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")


// 그리고 매크로에서는 역할을 정의해줘야합니다. 위 OptionSet 매크로는
// 적용된 타입에 멤버를 추가하는 역할, 프로토콜을 채택하는 역할이 있으므로
// 아래와 같이 작성해줍니다.

@attached(member, names: named(RawValue), named(rawValue),
        named(`init`), arbitrary)
// 매크로가 생성하는 기호에 대해 namse(인수)로 표현합니다.
// 이름을 아는 것들은 위처럼하고, 이름을 모르는 선언을 위해 arbitrary도 적어줍니다.
// 위의 경우엔 RawValue, rawValue, init에 관해 생성하겠다는 뜻이댐니드~

@attached(conformance)
public macro OptionSet<RawType>() =
        #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")


// 독립 매크로를 선언하기위해 아래와 같이 freestanding을 해줘야함니다.
@freestanding(expression)
public macro line<T: ExpressibleByIntegerLiteral>() -> T =
        /* ... location of the macro implementation... */

// #line 매크로는 expression 역할을 가집니다. 매크로 표현식은 값을 생성하거나 컴파일 때 경고를 생성하듯이 어떠한 동작을 수행합니다.

// MARK: 매크로 확장

// Swift 컴파일러는 다음과 같은 단계를 통해 매크로를 확장함니다.
// 컴파일러는 코드를 읽고 구문의 메모리 표현을 생성합니다.
// 컴파일러는 메모리 표현의 일부분을 매크로 구현에 전송하여 매크로를 확장합니다.
// 컴파일러는 확장된 형태로 매크로 호출을 대체합니다.
// 컴파일러는 확장된 소스 코드를 사용하여 완료될 때까지 계속 진행합니다.

let magicNumber = #fourCharacterCode("ABCD")
// 4글자 문자열을, ASCII 값에 해당하는
// 부호없는 32비트 정수를 반환하는 매크로

// MARK: AST
// 위 코드에서 매크로를 확장하기 위해 컴파일러는 Swift 파일을 읽고
// AST(추상 구문 트리) 라고 알려진 해당 코드의 메모리 표현을 생성합니다.
// AST는 컴파일러나 매크로 구현 같이 해당 구조와 상호작용하는 코드를
// 더 쉽게 작성하기 위해 코드의 구조를 명시적으로 나타냅니다.

// AST
// Constant declaration
//  - Constant name: magicNumber
//  - Constant value
//       - Macro call
//            - Macro name: fourCharacterCode
//            - Macro arguments:
//                   - String literal: "ABCD"

// 위 AST의 구성으로, 컴파일러는 소스코드가 Swift에 유효한지 물어봄니다
// 예를 들어 문자열을 받기로 했는데 문자열 리터럴에 정수가 들어가거나," 하나가 빠지면 에러를 발생시킴다

// 컴파일러는 매크로를 호출하는 부분을 코드에서 찾고, 해당 매크로를 구현한 외부 바이너리를 로드합니다.
// 각 매크로 호출에 대해 컴파일러는 AST의 부분을 매크로 구현에 전달합니다.

// #faourCharacterCode 매크로의 구현은 매크로를 확장할 때 입력으로 이 부분의 AST를 읽습니다.
// 매크로의 구현은 입력으로 받은 AST에서만 동작합니다.
// 매크로의 구현은 파일 시스템 또는 네트워크 접근을 방지하는 샌드박스 환경에서 실행됨니다.

// 매크로의 구현이 새로운 AST를 생성해서 컴파일러가 아래 AST를 반환하여
// 매크로 호출 AST에 아래 값을 최종적으로 받고 최종 AST가 생성됨니다.

// Constant declaration
//  - Constant name: magicNumber
//  - Constant value
//         - Integer literal: 1145258561

// 이 AST의 코드는 다음과 같습니다.
let magicNumber = 1145258561

// 이번 예제에서는 하나의 매크로만 사용하였는데 만약 여러개의 매크로를 사용하는 경우에는
// 외부 매크로가 먼저 확장됩니다. 이렇게 되면 확장되기 전에 외부 매크로가 내부 매크로를 수정할 수 있습니다.

// MARK: 매크로 구현
// 매크로는 라이브러리를 만드는 것처럼 아래와 같이 작성합니다.
// 기존 프로젝트의 매크로를 추가하기 위한 타겟 작성

targets: [
    // Macro implementation that performs the source transformations.
    .macro(
        name: "MyProjectMacros",
        dependencies: [
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
        ]
    ),

    // Library that exposes a macro as part of its API.
    .target(name: "MyProject", dependencies: ["MyProjectMacros"]),
]

// 위 코드는 두 개의 타겟을 정의합니다: MyProjectMacros 는 매크로의 구현을 포함하고,
// MyProject 는 해당 매크로를 사용가능하도록 만듭니다.

// 위 fourCharacterCode 의 구현 부
public struct FourCharacterCode: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first
        else {
            throw CustomError.message("Need a static string")
        }

        let string = literalSegment.content.text
        guard let result = fourCharacterCode(for: string) else {
            throw CustomError.message("Invalid four-character code")
        }

        return "\(raw: result)"
    }
}

private func fourCharacterCode(for characters: String) -> UInt32? {
    guard characters.count == 4 else { return nil }

    var result: UInt32 = 0
    for character in characters {
        result = result << 8
        guard let asciiValue = character.asciiValue else { return nil }
        result += UInt32(asciiValue)
    }
    return result.bigEndian
}
enum CustomError: Error { case message(String) }
