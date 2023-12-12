import Foundation

// pg_캐시
// 도시이름 검색, 해당 도시 관련 맛집 게시물을 db에서 보여주는 서비스
// 매우 간단하게 LRU 캐시를 흉내내보는 문제였음
// 크게 고려할 부분은 없었고 배열 하나 만들어서 꽉차거나 기존에 있는
// 도시를 검색하면 업데이트 하는정도였다~
func solution(_ cacheSize:Int, _ cities:[String]) -> Int {
    var time = 0
    var cache: [String] = []
    
    for item in cities {
        var item = item.lowercased()
        var idx = cache.firstIndex(of: item)
        
        if idx != nil {
            time += 1
            cache.append(cache.remove(at: idx!))
        }
        
        else {
            time += 5
            
            if cache.count < cacheSize {
                cache.append(item)
            }
            
            else if cacheSize != 0 {
                cache.removeFirst()
                cache.append(item)
            }
        }
    }
    
    return time
}
