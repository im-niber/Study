tex = "ADCBBBBCABBCBDACBDCAACDDDCAABABDBCBCBDBDBDDABBAAAAAAADADBDBCBDABADCADC"
total=0

a = list(map(lambda x:4 if x=='A' else 0 ,tex))
b = list(map(lambda x:3 if x=='B' else 0 ,tex))
c = list(map(lambda x:2 if x=='C' else 0 ,tex))
d = list(map(lambda x:1 if x=='D' else 0 ,tex))

for i in range(0,len(tex)):
    total += a[i] + b[i] + c[i] + d[i]

print(total)