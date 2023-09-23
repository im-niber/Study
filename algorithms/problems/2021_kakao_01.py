# 2021 카카오 블라인드 01_신규 아이디 추천

def solution(new_id):
    answer = ''
    check = ['-','.','_']
    check2 = '..'
    new_id = new_id.lower()
    k = 0
    
    while len(new_id) > k :
        if new_id[k].isalnum() :
            k += 1
            continue
        else :
            if new_id[k] in check :
                k += 1
                continue
            else :
                new_id = new_id.replace(new_id[k],'')
   
    while check2 in new_id :
        new_id = new_id.replace('..','.')

    if new_id[0] == '.' :
        new_id = new_id.lstrip('.')
    if len(new_id) != 0 and new_id[len(new_id)-1] == '.' :
        new_id = new_id.rstrip('.')
    
    if len(new_id) == 0 :
        new_id += 'a'
    
    elif len(new_id) > 16 :
        new_id = new_id[:15]

    if new_id[len(new_id)-1] == '.' :
        new_id = new_id.rstrip('.')
    
    if len(new_id) <= 2 :
        while len(new_id) < 3 :
            new_id += new_id[len(new_id)-1]

    answer = new_id

    return answer