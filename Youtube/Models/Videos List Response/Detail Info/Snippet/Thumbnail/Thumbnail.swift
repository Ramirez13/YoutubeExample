
import Foundation
import ObjectMapper

final class Thumbnail {
    
    var height: Int?
    var width: Int?
    var url: String?
    
}

extension Thumbnail: Mappable {
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        height <- map["height"]
        width <- map["width"]
        url <- map["url"]
    }
    
}
