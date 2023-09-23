dx = [-1,0,1,0]
dy = [0,1,0,-1]

minus = {0.05: 0, 0.1:0, 0.07:0, 0.02: 0, 0.01:0}

def check_area(y,x) :
    return 0<= y < N and 0<= x < N

def solution(area,y,x) :
    global count,minus
    p = 0
    check = 0
    for i in range(1,N+1) :
        for _ in range(2) :
            if p == 4 :
                p = 0
            for k in range(i) :
                ny = y+dy[p]
                nx = x+dx[p]       

                if (y,x) == (0,0) :
                    return count 

                if p == 0 :
                    if check_area(ny,nx-2) :
                        area[ny][nx-2] += int(0.05*area[ny][nx])
                        check += int(0.05*area[ny][nx])                    
                        minus[0.05] = 1
                    if check_area(ny-1,nx-1) :
                        area[ny-1][nx-1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])                         
                        minus[0.1] += 1 
                    if check_area(ny+1,nx-1) :
                        area[ny+1][nx-1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])                        
                        minus[0.1] += 1
                    if check_area(ny-1,nx) :
                        area[ny-1][nx] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])                         
                        minus[0.07] +=1
                    if check_area(ny+1,nx) :
                        area[ny+1][nx] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])                        
                        minus[0.07] +=1
                    if check_area(ny-2,nx) :
                        area[ny-2][nx] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])                         
                        minus[0.02] += 1
                    if check_area(ny+2,nx) :
                        area[ny+2][nx] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx]) 
                        minus[0.02] += 1
                    if check_area(ny-1,nx+1) :
                        area[ny-1][nx+1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx]) 
                        minus[0.01] += 1
                    if check_area(ny+1,nx+1) :
                        area[ny+1][nx+1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx]) 
                        minus[0.01] += 1                
                    if check_area(ny,nx-1) :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2* int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                                
                        area[ny][nx-1] += (area[ny][nx] - check)
                        check += (area[ny][nx] - check)
                    else :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                                
                        count += (area[ny][nx] - check)
                   

                if p == 3:
                    if check_area(ny-2,nx) :
                        area[ny-2][nx] += int(0.05*area[ny][nx])
                        check += int(0.05*area[ny][nx])
                        minus[0.05] = 1
                    if check_area(ny-1,nx-1) :
                        area[ny-1][nx-1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])
                        minus[0.1] += 1
                    if check_area(ny-1,nx+1) :
                        area[ny-1][nx+1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])
                        minus[0.1] += 1
                    if check_area(ny,nx-1) :
                        area[ny][nx-1] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])
                        minus[0.07] += 1
                    if check_area(ny,nx+1) :
                        area[ny][nx+1] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])
                        minus[0.07] += 1
                    if check_area(ny,nx-2) :
                        area[ny][nx-2] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])
                        minus[0.02] += 1
                    if check_area(ny,nx+2) :
                        area[ny][nx+2] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])
                        minus[0.02] += 1
                    if check_area(ny+1,nx+1) :
                        area[ny+1][nx+1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx])
                        minus[0.01] += 1
                    if check_area(ny+1,nx-1) :
                        area[ny+1][nx-1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx])
                        minus[0.01] += 1
                    if check_area(ny-1,nx) :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                                
                        area[ny-1][nx] += (area[ny][nx] - check)
                        check += (area[ny][nx] - check)
                    else :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                     
                        count += (area[ny][nx] - check)

                 
                if p == 2 :
                    if check_area(ny,nx+2) :
                        area[ny][nx+2] += int(0.05*area[ny][nx])
                        check += int(0.05*area[ny][nx])
                        minus[0.05] += 1
                    if check_area(ny-1,nx+1) :
                        area[ny-1][nx+1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])
                        minus[0.1] += 1
                    if check_area(ny+1,nx+1) :
                        area[ny+1][nx+1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])
                        minus[0.1] += 1
                    if check_area(ny-1,nx) :
                        area[ny-1][nx] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])
                        minus[0.07] += 1
                    if check_area(ny+1,nx) :
                        area[ny+1][nx] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])
                        minus[0.07] += 1
                    if check_area(ny-2,nx) :
                        area[ny-2][nx] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])
                        minus[0.02] += 1
                    if check_area(ny+2,nx) :
                        area[ny+2][nx] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])
                        minus[0.02] += 1
                    if check_area(ny-1,nx-1) :
                        area[ny-1][nx-1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx])
                        minus[0.01] += 1
                    if check_area(ny+1,nx-1) :
                        area[ny+1][nx-1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx])
                        minus[0.01] += 1
                    if check_area(ny,nx+1) :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])

                        area[ny][nx+1] += (area[ny][nx] - check)
                        check += (area[ny][nx] - check)
                    else :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                                
                        count += (area[ny][nx] - check)

                if p == 1 :
                    if check_area(ny+2,nx) :
                        area[ny+2][nx] += int(0.05*area[ny][nx])
                        check += int(0.05*area[ny][nx])
                        minus[0.05] += 1
                    if check_area(ny+1,nx-1) :
                        area[ny+1][nx-1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])
                        minus[0.1] += 1
                    if check_area(ny+1,nx+1) :
                        area[ny+1][nx+1] += int(0.1 * area[ny][nx])
                        check += int(0.1*area[ny][nx])
                        minus[0.1] += 1
                    if check_area(ny,nx-1) :
                        area[ny][nx-1] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])
                        minus[0.07] += 1
                    if check_area(ny,nx+1) :
                        area[ny][nx+1] += int(0.07 * area[ny][nx])
                        check += int(0.07*area[ny][nx])
                        minus[0.07] += 1
                    if check_area(ny,nx-2) :
                        area[ny][nx-2] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])
                        minus[0.02] += 1
                    if check_area(ny,nx+2) :
                        area[ny][nx+2] += int(0.02 * area[ny][nx])
                        check += int(0.02*area[ny][nx])
                        minus[0.02] += 1
                    if check_area(ny-1,nx+1) :
                        area[ny-1][nx+1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx])
                        minus[0.01] += 1
                    if check_area(ny-1,nx-1) :
                        area[ny-1][nx-1] += int(0.01 * area[ny][nx])
                        check += int(0.01*area[ny][nx])
                        minus[0.01] += 1
                    if check_area(ny+1,nx) :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                                
                        area[ny+1][nx] += (area[ny][nx] - check)
                        check += (area[ny][nx] - check)

                    else :
                        for idx, value in minus.items() :
                            if value == 0 and idx == 0.05:
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])
                            
                            elif value == 0 :
                                count += (2 * int(idx*area[ny][nx]))
                                check += (2 * int(idx*area[ny][nx]))
                           
                            elif value == 1 and idx != 0.05 :
                                count += int(idx*area[ny][nx])
                                check += int(idx*area[ny][nx])

                        count += (area[ny][nx] - check)
                    
                minus = {0.05: 0, 0.1:0, 0.07:0, 0.02: 0, 0.01:0}
                area[ny][nx] = 0
                y,x = ny, nx
                check = 0
            p += 1
    return count

N = int(input())
area = [list(map(int,input().split())) for _ in range(N)]
start_y = N//2
start_x = N//2
count = 0
count = solution(area,start_y,start_x)
print(count)