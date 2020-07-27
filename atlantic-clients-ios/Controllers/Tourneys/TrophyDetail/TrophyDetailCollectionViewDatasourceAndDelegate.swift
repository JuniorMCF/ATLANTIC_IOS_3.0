import Foundation
import UIKit

class TrophyDetailCollectionViewDatasourceAndDelegate: NSObject {
    
    private var items: [Positions] = []
    private var viewModel: TrophyDetailViewModelProtocol
    
    init(items: [Positions], viewModel: TrophyDetailViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension TrophyDetailCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrophyDetailCellID", for: indexPath) as? TrophyDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let positions = items[indexPath.row]
        cell.prepare(positions: positions)
        return cell
    }
    

    
}

