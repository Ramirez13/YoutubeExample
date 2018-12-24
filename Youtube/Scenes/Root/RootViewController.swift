
import UIKit

// MARK: - RootViewController class

final class RootViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var dataSource: VideosDataSource?
    @IBOutlet private weak var collectionView: UICollectionView?
    
    // MARK: - Properties

    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        dataSource?.fetchVideos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let playerViewController = segue.destination as? PlayerViewController,
            let cell = sender as? UICollectionViewCell,
            let videoId = dataSource?.videoId(by: cell) else { return }
        playerViewController.videoId = videoId
    }

}

// MARK: - UICollectionViewDelegateFlowLayout extension

extension RootViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

}

// MARK: - RootViewController private

private extension RootViewController {

    func setUpSearchController() {
        searchController.searchBar.tintColor = .white
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search video"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

// MARK: - UISearchResultsUpdating Delegate

extension RootViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        searchController.isActive = false
        dataSource?.fetchVideos(using: query)
    }

}

// MARK: - VideosDataSourceErrorHandler

extension RootViewController: VideosDataSourceErrorHandler {

    func handle(_ error: Error) {
        let alert = UIAlertController.init(title: "Network error", message: error.localizedDescription, preferredStyle: .alert)
        let close = UIAlertAction.init(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }

}
