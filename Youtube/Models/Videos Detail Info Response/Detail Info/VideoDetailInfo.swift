
import Foundation
import ObjectMapper

final class VideoDetailInfo {
    
    var id: String?
    var contentDetails: ContentDetails?
    
}

extension VideoDetailInfo: Mappable {
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        contentDetails <- map["contentDetails"]
    }
    
}
