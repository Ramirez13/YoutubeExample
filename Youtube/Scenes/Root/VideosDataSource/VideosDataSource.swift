
import UIKit

//MARK: - VideosDataSourceErrorHandler protocol

@objc protocol VideosDataSourceErrorHandler {
    func handle(_ error: Error)
}

//MARK: - VideosDataSource class

final class VideosDataSource: NSObject {

    //MARK: - IBOutlets

    @IBOutlet private weak var errorHandler: VideosDataSourceErrorHandler?
    @IBOutlet private weak var collectionView: UICollectionView?

    //MARK: - Properties

    private let cellIdentifier = "Cell"
    private let videosProvider = VideoInfoProvider()
    private var query: String!

    //MARK: - Interface

    func videoId(by cell: UICollectionViewCell) -> String? {
        guard
            let indexPath = collectionView?.indexPath(for: cell),
            videosProvider.items.count > indexPath.row,
            let videoId = videosProvider.items[indexPath.row].id?.videoId else { return nil }
        return videoId
    }

    func fetchVideos(using query: String = "") {
        self.query = query
        videosProvider.fetchVideos(by: query, with: { [weak self] in
            guard let `self` = self else { return }
            self.reloadUI()
        }) { [weak self] (error) in
            guard let `self` = self else { return }
            self.errorHandler?.handle(error)
        }
    }

}

//MARK: - VideosDataSource private

private extension VideosDataSource {

    func reloadUI() {
        collectionView?.reloadData()
    }

}

//MARK: - UICollectionViewDataSource extension

extension VideosDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosProvider.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! VideoCell
        if indexPath.row < videosProvider.items.count {
            let info = videosProvider.items[indexPath.row]
            cell.setUp(info)
        }
        guard indexPath.row == videosProvider.items.count - 1 else { return cell }
        fetchVideos(using: query)
        return cell
    }

}
