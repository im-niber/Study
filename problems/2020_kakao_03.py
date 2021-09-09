# 2020_카카오 블라인드 03_자물쇠와 열쇠

def spin(arr) :
    return list(zip(*arr[::-1]))

def attach(x,y,M,key,board) :
    for i in range(M):
        for j in range(M):
            board[x+i][y+j] += key[i][j]

def detach(x,y,M,key,board):
    for i in range(M):
        for j in range(M):
            board[x+i][y+j] -= key[i][j]
        
def check(board,M,N):
    for i in range(N):
        for j in range(N):
            if board[M+i][M+j] != 1:
                return False
    return True

def solution(key, lock):
    M = len(key)
    N = len(lock)
    board = [[0] * (M*2 + N) for _ in range(M*2 + N)]
    
    for i in range(N):
        for j in range(N):
            board[M+i][M+j] = lock[i][j]

    spined_key = key
    for _ in range(4) :
        spined_key = spin(spined_key)
        for x in range(1,M+N) :
            for y in range(1,M+N):
                attach(x,y,M,spined_key,board)
                if check(board,M,N):
                    return True
                detach(x,y,M,spined_key,board)

    return False

# print(solution([[0, 0, 0], [1, 0, 0], [0, 1, 1]],[[1, 1, 1], [1, 1, 0], [1, 0, 1]]))