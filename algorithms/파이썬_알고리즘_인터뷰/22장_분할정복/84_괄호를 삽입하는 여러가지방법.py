# 241. Different Ways to Add Parentheses, leetcode

test_data = "2*3-4*5"
#출력 : [-34,-14,-10,-10,10]

class solution :
  def diffWaysToCompute(self, input : str) -> list :

    def compute(left, right, op) :
      results = []
      for l in left :
        for r in right :
          results.append(eval(str(l)+op+str(r)))
      return results


    if input.isdigit():
      return[int(input)]


    results =[]
    for idx, val in enumerate(input):
      if val in "-+*" :
        left = self.diffWaysToCompute(input[:idx])
        right = self.diffWaysToCompute(input[idx+1:])

        results.extend(compute(left,right,val))

    return results

s = solution()
print(s.diffWaysToCompute(test_data))

