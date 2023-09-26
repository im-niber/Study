import Foundation

// MARK: 타입 캐스팅 (Type Casting)
// 값의 런타임 타입을 정하고 타입의 정보를 제공합니다.
// 타입 캐스팅은 인스턴스의 타입을 확인하거나 해당 인스턴스를
// 자체 클래스 계층 구조의 다른 곳에서 다른 상위 클래스 또는 하위 클래스로써 취급하는 방법입니다.

// Swift에서 타입 캐스팅은 is 와 as 연산자로 구현됩니다.
// 이 두 연산자는 값의 타입을 확인하거나 값을 다른 타입으로 캐스팅하는 방법을 제공합니다.

// MARK: 타입 캐스팅을 위한 클래스 계층 정의

// 클래스와 하위 클래스에 타입 캐스팅을 사용하여 특정 클래스 인스턴스의
// 타입을 확인하고 같은 계층도 내에서 다른 클래스로 인스턴스를 캐스팅 가능함니다.

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 이 친구는 [MediaItem] 으로 추론댐니다.
// Movie, Song이 공통으로 MediaItem을 상위 클래스로 가지고 있기 때문.
// Movie, Song으로 작업을 하려면 다운 캐스팅이 필요함니다. 현재는 MediaItem으로 추론되기 때무네
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
    
// MARK: 타입 검사
// 인스턴스가 특정 하위 클래스 타입인지 확인하기 위해 타입 검사 연산자 is 를 사용함니다
// 이 타입 검사 연산자는 인스턴스가 하위 클래스 타입이면 true 를 아니면 false 를 반환합니다.

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"

// MARK: 다운 캐스팅

// 특정 클래스 타입의 상수 또는 변수는 하위 클래스의 인스턴스를 참조할 수 있습니다.
// 타입 캐스트 연산자(as?, as!)를 사용하여 하위 클래스 타입으로 다운 캐스팅 할 수 있슴니다.
// as! 는 다운 캐스팅이 무조건 성공하는 경우에 사용해야 함니다. 아니면 런타임 에러~

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

// NOTE: 캐스팅은 실제로 인스턴스를 수정하지 않습니다. 기본 인스턴스는 동일하게 유지 되며,
// 캐스팅된 타입의 인스턴스로 처리할 뿐임니다.

// MARK: Any 와 AnyObject 에 대한 타입 캐스팅
// Any : 모든 타입을 나타낼 수 있슴니다.
// AnyObject : 클래스에 한해서 모든 타입의 인스턴스를 나타낼 수 있슴다

var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

// 아래와 같이 패턴 매칭의 경우 as를 사용할 수도 있습니다.

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

// NOTE: Any 타입은 옵셔널을 포함한 모든 타입을 의미합니다.
// Any 타입이 기대되는 값에 옵셔널을 준다면 Swift는 경고를 띄움니다.
// 아래와 같이 명시적으로 Any로 캐스팅한다면 경고를 없앨 수 있슴다
let optionalNumber: Int? = 3
things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No warning
