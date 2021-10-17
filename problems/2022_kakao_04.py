# 출처: 프로그래머스 코딩 테스트 연습, https://programmers.co.kr/learn/challenges

from itertools import combinations_with_replacement

def score(rion,info,temp_dict) :
  temp = rion[:]
  temp_info=info[:]

  for i in range(len(info)) :
    if temp_info[i] >= rion[i] and temp_info[i] != 0 :
      rion[i] = 0
      temp_info[i] = 1
    elif temp_info[i] < rion[i] :
      temp_info[i] = 0
      rion[i] = 1

  a_result = 0
  b_result = 0

  for i in range(len(rion)) :
    b_result += (10-i) * rion[i]
    a_result += (10-i) * temp_info[i]

  result = b_result - a_result

  if result > 0 :
    temp_dict[result].append(temp)
    return result

  return 0

def solution(n, info):
    temp_dict = {idx : [] for idx in range(111)}
    mined = 0
    chk = 0
    idxs = []
    temp = [0] * 11

    for case in (combinations_with_replacement([0,1,2,3,4,5,6,7,8,9,10], n)) :
      for i in range(11) :
        num = case.count(i)
        temp[i] = num
      score(temp,info,temp_dict)

    for idx in range(len(temp_dict)-1,-1,-1) :
      if len(temp_dict[idx]) > 0 :
        for i in range(10,-1,-1):
          for item in temp_dict[idx] :
            if mined <= item[i] :
              mined = item[i]
          for item in temp_dict[idx] :
            if mined == item[i]:
              idxs.append(temp_dict[idx].index(item))
          mined = 0
        for i in range(len(temp_dict[idx])) :
          checked = idxs.count(i)
          if chk <= checked :
            chk = checked
            t = i
        return temp_dict[idx][t]

    return [-1]