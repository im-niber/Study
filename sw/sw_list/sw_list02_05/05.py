a = int(input())

for i in range(0,a):
    purple = 0
    
    data = int(input())

    color_area = [[0 for item in range(10)] for item in range(10)]

    case_red = []
    case_blue = []

    for k in range(data):
        sample_data = list(map(int,input().split()))

        for p in range(sample_data[0],sample_data[2]+1) :
            for j in range(sample_data[1], sample_data[3]+1):
                color_area[p][j] += sample_data[4]
                if color_area[p][j] == 3 :
                    purple +=1
    

    print("#%d %d" %(i+1, purple))
    
    