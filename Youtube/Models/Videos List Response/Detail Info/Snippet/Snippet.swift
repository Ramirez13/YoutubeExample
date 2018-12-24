
import Foundation
import ObjectMapper

final class Snippet {
    
    var channelId: String?
    var channelTitle: String?
    var description: String?
    var liveBroadcastContent: String?
    var publishedAt: String?
    var title: String?
    var thumbnails: Thumbnails?
    
}

extension Snippet: Mappable {
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        channelId <- map["channelId"]
        channelTitle <- map["channelTitle"]
        description <- map["description"]
        liveBroadcastContent <- map["liveBroadcastContent"]
        publishedAt <- map["publishedAt"]
        title <- map["title"]
        thumbnails <- map["thumbnails"]
    }
    
}
