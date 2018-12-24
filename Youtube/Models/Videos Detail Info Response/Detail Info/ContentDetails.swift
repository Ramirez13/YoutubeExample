
import Foundation
import ObjectMapper

final class ContentDetails {
    
    var duration: String?
    private var youtubeDuration: String? {
        didSet {
            duration = youtubeDuration?.getYoutubeFormattedDuration()
        }
    }
    
}

extension ContentDetails: Mappable {

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        youtubeDuration <- map["duration"]
    }

}
