import Foundation

// 잘 안 떠오르기도 하고, 케이스도 얼마 없을거같아서
// 다 체크해서 풀었다,,, 다른 사람 풀이 보니 절댓값 개념으로 풀기도하고
// 라인을 담는 배열을 만들어서 풀기도 하고,, 대단한둣,, ㅎㅇㅌ~

enum WinCase {
    case Owin
    case Xwin
    case Nothing
    case Error
}

func add(_ item: inout Int) { item += 1 }

func winCheck(_ board:[[String.Element]]) -> WinCase {
    
    var Owin = 0
    var Xwin = 0

    // 행 열 조건
    for i in 0..<3 {
        if board[i][0] == board[i][1] && board[i][0] == board[i][2] {
            board[i][0] == "O" ? add(&Owin) : board[i][0] == "X" ? add(&Xwin) : ()
        }
        
        if board[0][i] == board[1][i] && board[0][i] == board[2][i] {
            board[0][i] == "O" ? add(&Owin) : board[0][i] == "X" ? add(&Xwin) : ()
        }
    }
    
    // 대각 조건
    if board[0][0] == board[1][1] && board[0][0] == board[2][2] {
        board[0][0] == "O" ? add(&Owin) : board[0][0] == "X" ? add(&Xwin) : ()
    }
    if board[0][2] == board[1][1] && board[0][2] == board[2][0] {
        board[0][2] == "O" ? add(&Owin) : board[0][2] == "X" ? add(&Xwin) : ()
    }
    
    if Owin >= 1 && Xwin >= 1 { return .Error }
    // O는 5개까지 작성이 가능하여 2가 나올 확률도 있다
    else if Owin >= 1 { return .Owin }
    else if Xwin == 1 { return .Xwin }
    else if Owin == 0 && Xwin == 0 { return .Nothing }
    else { return .Error }
}

func solution(_ board:[String]) -> Int {
    var board = board.map { Array($0) }

    var O_count = 0
    var X_count = 0
    
    for i in 0..<3 {
        for k in 0..<3 {
            board[i][k] == "O" ? add(&O_count) : board[i][k] == "X" ? add(&X_count) : ()
        }
    }
    
    // 개수가 안맞다면 error ~
    if O_count > X_count + 1 { return 0 }
    if X_count > O_count { return 0 }
    
    let winCase = winCheck(board)

    if winCase == .Error { return 0 }
    else if winCase == .Owin && O_count == X_count { return 0 }
    else if winCase == .Xwin && O_count == X_count + 1 { return 0 }
    
    return 1
}
