# 출처: 프로그래머스 코딩 테스트 연습, https://programmers.co.kr/learn/challenges

import math

def time_check(a,b):
  hour,minute = a.split(':')
  hour2,minute2 = b.split(':')

  temp = (int(hour2) - int(hour)) * 60

  if minute2 > minute :
    temp += int(minute2) - int(minute)
  else :
    temp += 60 - int(minute) + int(minute2)
    temp -= 60

  return temp

def solution(fees, records):
    answer = []
    inputed = {}
    outputed = {}

    for item in records :
      res = item.split(' ')
      if res[2] == 'IN' :
        if res[1] not in inputed :
          inputed[res[1]] = [res[0]]
        else :
          inputed[res[1]].append(res[0])
      if res[2] == 'OUT' :
        if res[1] not in outputed :
          outputed[res[1]] = [res[0]]
        else :
          outputed[res[1]].append(res[0])

    ids = {item : 0 for item in inputed.keys()}
    order_id = sorted(ids)

    for item in inputed:
      for i in range(len(inputed[item])):
        if item in outputed :
          if len(outputed[item]) != 0 :
            ids[item] += time_check(inputed[item][0],outputed[item][0])
            inputed[item].pop(0)
            outputed[item].pop(0)
          else :
            ids[item] += time_check(inputed[item][0],'23:59')
        else :
            ids[item] += time_check(inputed[item][0],'23:59')

    for i in range(len(ids)) :
      answer.append(ids[order_id[i]])

    for i in range(len(answer)):
      charge = 0
      if answer[i] <= fees[0] :
        answer[i] = fees[1]
      else :
        charge = fees[1] + math.ceil((answer[i]-fees[0])/fees[2]) * fees[3]
        answer[i] = charge

    return answer

# print(solution([180, 5000, 10, 600],["05:34 5961 IN", "06:00 0000 IN", 
# "06:34 0000 OUT", "07:59 5961 OUT", "07:59 0148 IN", "18:59 0000 IN", 
# "19:09 0148 OUT", "22:59 5961 IN", "23:00 5961 OUT"]))

print(solution([1, 461, 1, 10],["00:00 1234 IN"]))