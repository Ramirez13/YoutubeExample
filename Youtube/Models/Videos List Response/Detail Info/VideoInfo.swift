
import Foundation
import ObjectMapper

final class VideoInfo {

    var etag: String?
    var kind: String?
    var duration: String?
    var id: VideoId?
    var snippet: Snippet?

}

extension VideoInfo: Mappable {

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        etag <- map["etag"]
        kind <- map["kind"]
        id <- map["id"]
        snippet <- map["snippet"]
    }

}
