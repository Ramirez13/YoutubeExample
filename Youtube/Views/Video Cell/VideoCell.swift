
import UIKit
import AlamofireImage

//MARK: - VideoCell class

final class VideoCell: UICollectionViewCell {

    //MARK: - IBOutlets

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var videoNameLabel: UILabel!
    @IBOutlet private weak var duration: UILabel!

    //MARK: - Interface

    func setUp(_ info: VideoInfo) {
        videoNameLabel.text = info.snippet?.title
        duration.text = info.duration
        guard
            let imageLink = info.snippet?.thumbnails?.medium?.url,
            let url = URL(string: imageLink) else { return }
        thumbnailImageView.af_setImage(withURL: url)
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.af_cancelImageRequest()
        thumbnailImageView.image = nil
        videoNameLabel.text = nil
        duration.text = nil
    }

}
