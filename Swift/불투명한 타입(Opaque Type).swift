import Foundation

// MARK: 불투명한 타입 Opaque Types
// 값의 타입에 대한 자세한 정보를 숨깁니다
// Swift는 타입을 숨기기 위한 두 가지 방법을 제공함니다.
// 불투명한 타입과 박스형 프로토콜 타입 임니다.
// 반환값의 기본 타입이 비공개로 유지될 수 있으므로 모듈간의 호출하는 코드는
// 타입을 숨기는것이 유용함니다

// 불투명한 타입은 타입식별을 유지함니다. ->
// 컴파일러는 구체적인 타입으로 접근이 가능하지만, 모듈의 클라이언트는 불가함니다.

// 박스형 프로토콜 타입은 주어진 프로토콜을 만족하는 인스턴스를 저장할 수 있습니다.
// 얘는 타입식별을 유지하지 않슴니다 ->
// 값의 타입은 런타임까지 알 수 없으며 다른 값이 저장됨에 따라 변경될 수 있습니다.

// 불투명한 타입이 해결하는 문제
// ASCII 그림 모양을 그리는 모듈예제
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)

// 아래 코드처럼 제네릭을 사용하여 뒤집는것도 가능합니다.
// 하지만 이 방식에는 문제점이 있는데, 이를 생성하는데
// 구체적인 타입을 노출하는 점입니다.
struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

// Tip.?
// 이 생성에 대해 자세한 내용을 표출하면 반환 타입을 명시해야 함니다.
// 이는 공개 인터페이스에 포함되지 않은 타입이 유출될 가능성이 있슴니다.
// 모듈내에 코드는 다양한 방법으로 같은 모양을 구축할수 있고, 이를 사용하는 모듈 바깥에서는
// 얘를 변환하는거에 대한 세부 구현을 몰라야합니다. 고려할 필요가 x
// 따라서 위의 FlippedShape 같은 래퍼 타입은 사용자에게 표시되지 않아야 함니다.
// 모듈의 공개 인터페이스를 이러한 작업들로 구성되고 얘는 shape를 반환하게 만들면 되겠슴다

// MARK: 불투명한 타입 반환
// 불투명한 타입은 제네릭과 반대라고 생각할 수 있슴니다.
// 제네릭 코드는 호출시에 타입을 호출자가 정하기 때문임니다
func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... }

// 만약 불투명한 타입을 사용한다면 위 상황은 역전됩니다.
// 함수 구현부에서 추상화 된 방식으로
// 반환되는 값의 타입을 선택할 수 있습니다 아래 trapezoid라는 사다리꼴을 반환하는 함수
// some Shape로 구체적인 타입은 호출자가 모른다~
struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}
// 이런 방식으로 구현을 한다면, Shape 프로토콜을 준수하는
// 특정 타입의 값을 반환합니다.
// 위 예제 코드는 제네릭 타입과 반대되는 방식임을 강조합니다.
// 내부 코드는 호출하는 코드가 제네릭 함수처럼
// 해당 타입이 Shape를 준수하기만 하면 필요한 모든 타입을 반환할 수 있습니다.

// 또 불투명한 타입은 제네릭과 같이 사용할수도 있슴니다.
// 아래 flip, join 함수는 불투명한 타입을 반환하여 해당 타입이 표시되지 않게 합니다.
// 두 함수는 의존하는 타입이 제네릭이고, 함수에 대한 타입파라미터가 필요한 타입정보를 전달하기 때문에
// 모두 제네릭입니다.
func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape2(shape: shape)
}
// T 하나로 다 될 줄 알았는데 호출시에 T에는 triangle이 들어간다면 bottom도 같은
// triangle이 들어가야 하기 때무네 U도 써야한다~ 컴파일러가 분석할때 에러를 뱉음
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}
let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))

// 불투명한 타입을 반환하는 함수의 경우, 가능한 모든 반환 값은 동일한 타입을 가져야합니다.
// 아래 함수는 사각형이 들어온 경우 다른 타입을 반환하기 때문에 오류를 뱉고 있슴니다
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
    if shape is Square {
        return shape // Error: return types don't match
    }
    return FlippedShape(shape: shape) // Error: return types don't match
}

// 이를 고치기 위한 한 가지 방법은 사각형의 특수 경우를
// FlippedShape 내부로 옮기는 것입니다.
struct FlippedShape2<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        if shape is Square {
            return shape.draw()
        }
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

// 항상 단일 타입을 반환해야 한다고 해서 제네릭을 막지는 않습니당
// 다음은 반환하는 값의 기본 타입에 타입 파라미터를 쓰는 함수임니다.
// 아래 경우는 T에 따라 타입이 달라지지만, 어찌되었건 [T] 라는 타입을
// 항상 반환하기 때문에 문제 없슴니다.
func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
    return Array<T>(repeating: shape, count: count)
}

// MARK: 박스형 프로토콜 타입
// 얘는 프로토콜을 준수하는 T 타입이 존재합니다. 라는 문구와 같이
// 존재 타입(existential type)이라고도 불립니다.
// 프로토콜 이름 앞에 any를 붙여서 만듬니다. 아래 예제 참고
struct VerticalShapes: Shape {
    var shapes: [any Shape] // boxed protocol type
    func draw() -> String {
        return shapes.map { $0.draw() }.joined(separator: "\n\n")
    }
}
let largeTriangle = Triangle(size: 5)
let largeSquare = Square(size: 5)
let vertical = VerticalShapes(shapes: [largeTriangle, largeSquare])
print(vertical.draw())

// 위 VerticalShape에 shapes는 any Shape라는 타입으로, Shape를 만족하는
// 원소들을 가질 수 있습니다. 이러한 런타임 유연성을 제공하기 위해 Swift는 간접 참조 수준을 추가함니다.
// 이런 간접 참조를 박스(Box)라고 부르며, 성능 비용이 발생합니다.


// MARK: shapes의 여러가지 ver
// 1. 타입 파라미터를 사용해서 특정 타입의 배열로 받을 수 있음
struct Shapes1<S: Shape> { var shapes: [S] }
// 2. 불투명한 타입을 사용하여 타입을 숨기고 내부는 Shape를 만족하는 단일 타입의 원소를 받을 수 있음
struct Shapes2<S: Shape> { var shapes: [some Shape] = [Triangle(size: 3), Triangle(size: 4)] }
// 3. 박스형 프로토콜 타입을 사용하여, 다른 타입의 요소로 저장할 수 있게 함 그리고 타입의 식별자도 숨김
struct Shapes3<S: Shape> { var shapes: [any Shape] }

// 여기서 Shape의 다른 타입들도 혼합하여 저장할 수 있는 방법은 3번 뿐입니다.

// MARK: 불투명한 타입과 박스형 프로토콜 타입의 차이점
// 두 타입의 차이점으로
// 불투명한 타입은 하나의 특정타입을 참조하여 이러한 기본 타입에 대해 보증이 좋고, 호출자는 이를 모릅니다.
// 박스형 프로토콜은 프로토콜을 만족하는 여러 타입에 관해 참조하여 사용이 가능하며 유연성이 좋슴니다.

// 아까 위에서 본 불투명한 반환 타입을 쓰는 flip대신
// 박스형 프로토콜을 쓰는 flip 코드를 보겠슴니다.
// 얘는 이제 반환 타입이 2가지가 넘어가도 오류가 없는 모습을 볼 수 있슴다
// 이는 좀 더 느슨한 API 계약이고, 유연성을 얻었다고 볼 수 있슴니다.
func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }
    return FlippedShape2(shape: shape)
}

// 위 protoFlip의 구체적이지 않은 반환타입은 타입 정보에 의존하는
// 많은 작업들을 반환 값에서 사용할 수 없음을 의미합니다.
// 예를 들어 아래코드와 같습니다.
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing  // Error

// 위 에러의 이유로 첫 번째는 Shape 프로토콜에서는 == 연산을 구현하지 않았습니다.
// 구현을 했다면 좌항과 우항의 타입을 알아야합니다. 하지만 이러한 종류의 연산자는
// 일반적으로 프로토콜을 채택하는 구체적 타입과 일치하는 Self 타입의 인수를 사용하는데
// 프로토콜에 Self 요구사항을 추가한다면, 프로토콜을 타입으로 사용할 때 발생하는 타입 삭제가 허용되지 x

// 박스형 프로토콜 타입을 사용하는 점은 많은 유연성을 가져다 주지만
// 그 만큼 위에 같은 상황이 일어나는 대가가 존재함니다..

// 불투명한 타입은 반대로 기본 타입의 정체성을 보존합니다.
// Swift는 연관 타입을 유추할 수 있으므로 박스형 프로토콜 타입을 반환값으로 사용할 수 없는 위치에
// 불투명한 반환값을 사용할 수 있슴니다.
// 제네릭을 사용하는 Container 예시
//
//        protocol Container {
//            associatedtype Item
//            var count: Int { get }
//            subscript(i: Int) -> Item { get }
//        }
//        extension Array: Container { }
//
// 위 프로토콜은 연관 타입을 가지고 있으므로, 함수의 반환 타입으로
// Container를 사용할 수 없습니다.
// 또 충분한 정보가 없으므로 제약조건으로도 사용이 불가합니다. 아래 T,C:Container 부분

// Error: Protocol with associated types can't be used as a return type.
func makeProtocolContainer<T>(item: T) -> Container {
    return [item]
}
// Error: Not enough information to infer C.
func makeProtocolContainer<T, C: Container>(item: T) -> C {
    return [item]
}

// 이를 해결하는 방법으로 불투명한 타입을 사용하여 반환하면
// Container 타입을 반환하지만 타입 지정은 하지 않으므로 오류가 없는 모습을 볼 수 있슴다
// 이 구현에서 반환 타입은 [T] 임니다.
func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}
let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))
// Prints "Int"
