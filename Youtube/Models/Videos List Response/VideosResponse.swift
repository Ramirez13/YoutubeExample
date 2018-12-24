
import Foundation
import ObjectMapper

final class VideosResponse {

    var items = [VideoInfo]()
    var nextPageToken: String?

}

extension VideosResponse: Mappable {

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        items <- map["items"]
        nextPageToken <- map["nextPageToken"]
    }

}
