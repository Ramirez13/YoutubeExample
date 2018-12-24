
import Foundation
import ObjectMapper

final class Thumbnails {

    var `default`: Thumbnail?
    var high: Thumbnail?
    var medium: Thumbnail?

}

extension Thumbnails: Mappable {
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        `default` <- map["default"]
        high <- map["high"]
        medium <- map["medium"]
    }
    
}
