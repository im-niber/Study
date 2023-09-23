#출처: 프로그래머스 코딩 테스트 연습, https://programmers.co.kr/learn/challenges

import math

def change_n(n,k) :
  rev_base = ''

  while n > 0:
      n, mod = divmod(n,k)
      rev_base += str(mod)

  return rev_base[::-1] 

def prime_number(x): 
  x = int(x)
  if x > 1 :
    for i in range(2, int(math.sqrt(x)) + 1):
        if x % i == 0:
            return False 
    return True
  return False

def solution(n, k):
    answer = 0
    temp = change_n(n,k)
    res = temp.split('0')

    for item in res:
      if item != '':
        if prime_number(item) :
          answer += 1

    return answer
