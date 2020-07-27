import Foundation
import UIKit

class DinnerCollectionViewDatasourceAndDelegate: NSObject {
    private var items: [Dinner] = []
    private var viewModel: DinnerViewModelProtocol
    
    init(items: [Dinner], viewModel: DinnerViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension DinnerCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DinnerCellID", for: indexPath) as? DinnerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dinner = items[indexPath.row]
        cell.prepare(dinner: dinner)
        return cell
        
    }
}

extension DinnerCollectionViewDatasourceAndDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didDinnerSelected(indexPath)
    }
}
