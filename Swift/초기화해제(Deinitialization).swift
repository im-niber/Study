import Foundation

// 초기화 해제 (Deinitialization)
// 얘는 클래스 타입에서만 사용 가능하고, 인스턴스가 할당 해제 되기 직전에 호출됩니다.
class A {
    // 아래처럼 작성해서 사용합니다.
    // 파일을 닫거나 인스턴스가 할당 해제되기 전에 해야할 조치가 있다면 여기서 함니다.
    deinit {
        // perform the deinitialization
    }
}

// 상위 클래스의 deinit은 하위 클래스로 상속되고, 하위 클래스의 deinit이 끝날 때 호출됩니다.
// 상위 클래스의 deinit을 하위 클래스에 deinit을 명시적으로 작성하지 않아도 항상 호출됩니다.

// 사용예시
// Bank, Player 클래스를 만들고 코인 개수를 공유하는 ? 그런 예시임니다
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

class Print {
    static func doSomething() {
        
        // Player는 게임을 나갈 수 있기 때문에 옵셔널로 선언함
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        // Prints "A new player has joined the game with 100 coins"
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        // Prints "There are now 9900 coins left in the bank"

        // MARK: player가 떠난 경우에 deinit이 호출되는 모습
        playerOne = nil
        print("PlayerOne has left the game")
        // Prints "PlayerOne has left the game"
        print("The bank now has \(Bank.coinsInBank) coins")
        // Prints "The bank now has 10000 coins"

    }
}

// Player는 게임을 나갈 수 있기 때문에 옵셔널로 선언함
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"

// Player 인스턴스를 참조하는 부분이 끊기고, 다른 프로퍼티나 변수가 참조하고 있지 않으므로
// 메모리를 확보하기 위해 deinit이 호출되는 모습

playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"
