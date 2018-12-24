
import Foundation
import ObjectMapper

final class VideoId {

    var videoId: String?
    var kind: String?

}

extension VideoId: Mappable {

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        videoId <- map["videoId"]
        kind <- map["kind"]
    }

}
