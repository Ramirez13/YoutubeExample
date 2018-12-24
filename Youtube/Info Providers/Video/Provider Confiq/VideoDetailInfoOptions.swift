
import Foundation
import ObjectMapper

struct VideoDetailInfoOptions {

    var part: String {
        return "contentDetails"
    }
    var key: String {
        return "AIzaSyC-O4GFWLZLuK69qJNTkAQmeiFErtt88jw"
    }
    var ids = [String]()
    
    var idsString: String {
        return ids.joined(separator: ",")
    }
    
    init(_ ids: [String]) {
        self.ids = ids
    }
}

extension VideoDetailInfoOptions: BaseMappable {
    
    mutating func mapping(map: Map) {
        part >>> map["part"]
        key >>> map["key"]
        idsString >>> map["id"]
    }
    
}
