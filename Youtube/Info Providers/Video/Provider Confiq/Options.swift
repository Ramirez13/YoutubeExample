
import Foundation
import ObjectMapper

struct Options {

    enum Part: String {
        case id
        case snippet
    }

    enum `Type`: String {
        case video
    }

    let part: Part
    let maxResults: Int
    let q: String
    let type: Type
    var key: String {
        return "AIzaSyC-O4GFWLZLuK69qJNTkAQmeiFErtt88jw"
    }
    let nextPageToken: String?

    init(_ part: Part = .snippet, maxResults: Int = 10, q: String = "", type: Type = .video, nextPageToken: String? = nil ) {
        self.part = part
        self.maxResults = maxResults
        self.q = q
        self.type = type
        self.nextPageToken = nextPageToken
    }
}

extension Options: BaseMappable {

    mutating func mapping(map: Map) {
        part >>> map["part"]
        maxResults >>> map["maxResults"]
        q >>> map["q"]
        type >>> map["type"]
        key >>> map["key"]
        nextPageToken >>> map["pageToken"]
    }

}
