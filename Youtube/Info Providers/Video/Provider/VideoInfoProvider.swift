
import Foundation
import Alamofire
import AlamofireObjectMapper

final class VideoInfoProvider {

    private(set) var items = [VideoInfo]()
    private(set) var isLastPageLoaded = false
    private var nextPageToken: String?
    private var query: String = ""

    func fetchVideos(by query: String, with success: @escaping () -> Void, or failure: @escaping (_ error: Error) -> Void) {
        if self.query != query {
            reset()
        } else if isLastPageLoaded {
            success()
        }
        fetchVideoData(by: query, with: { [weak self] (response) in
            guard let `self` = self else { return }
            self.items.append(contentsOf: response.items)
            guard let nextPageToken = response.nextPageToken else {
                self.isLastPageLoaded = true
                self.nextPageToken = nil
                success()
                return
            }
            self.nextPageToken = nextPageToken
            success()
        }, or: failure)
    }

    private func fetchVideoData(by query: String, with success: @escaping (_ response: VideosResponse) -> Void, or failure: @escaping (_ error: Error) -> Void) {
        let options = Options(q: query, nextPageToken: nextPageToken)
        SessionManager.default.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: options.toJSON(), encoding: URLEncoding.methodDependent, headers: nil).validate().responseObject { [weak self] (response: DataResponse<VideosResponse>) in
            switch response.result {
            case .success(let responseValue):
                self?.fetchVideoDetails(using: responseValue, with: success, or: failure)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    private func fetchVideoDetails(using videoResponse: VideosResponse, with success: @escaping (_ response: VideosResponse) -> Void, or failure: @escaping (_ error: Error) -> Void) {
        let ids = videoResponse.items.compactMap { $0.id?.videoId }
        let options = VideoDetailInfoOptions(ids)
        SessionManager.default.request("https://www.googleapis.com/youtube/v3/videos", method: .get, parameters: options.toJSON(), encoding: URLEncoding.methodDependent, headers: nil).validate().responseObject { (response: DataResponse<VideosDetailInfoResponse>) in
            switch response.result {
            case .success(let responseValue):
                let updatedItems = zip(videoResponse.items, responseValue.items).map { (videoInfo, details) -> VideoInfo in
                    videoInfo.duration = details.contentDetails?.duration
                    return videoInfo
                }
                videoResponse.items = updatedItems
                success(videoResponse)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }

    private func reset() {
        items.removeAll()
        isLastPageLoaded = false
        nextPageToken = nil
    }

}
