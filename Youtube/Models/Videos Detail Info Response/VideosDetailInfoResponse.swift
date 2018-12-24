
import Foundation
import ObjectMapper

final class VideosDetailInfoResponse {
    
    var items: [VideoDetailInfo] = []

}

extension VideosDetailInfoResponse: Mappable {
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
    
}
