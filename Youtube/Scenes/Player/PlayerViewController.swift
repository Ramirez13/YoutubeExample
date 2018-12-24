
import UIKit
import YoutubeKit

//MARK: - PlayerViewController class

final class PlayerViewController: UIViewController {

    //MARK: - Properties

    var videoId: String?
    private var player: YTSwiftyPlayer!

    //MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let videoId = videoId else {
            return
        }
        player = YTSwiftyPlayer(frame: view.frame, playerVars: [.videoID(videoId)])
        player.loadPlayer()
        player.autoplay = true
        view = player
        player.delegate = self
    }

}

//MARK: - YTSwiftyPlayerDelegate

extension PlayerViewController: YTSwiftyPlayerDelegate {

    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        print(error.rawValue)
    }

}
