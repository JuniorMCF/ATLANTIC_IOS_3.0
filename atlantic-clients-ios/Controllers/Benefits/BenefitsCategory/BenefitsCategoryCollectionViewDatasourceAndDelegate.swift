import Foundation
import UIKit

class BenefitsCategoryCollectionViewDatasourceAndDelegate: NSObject {
    
    private var items: [BenefitsCategory] = []
    private var viewModel: BenefitsCategoryViewModelProtocol
    
    init(items: [BenefitsCategory], viewModel: BenefitsCategoryViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension BenefitsCategoryCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitsCategoryCellID", for: indexPath) as? BenefitsCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let benefitsCategory = items[indexPath.row]
        cell.prepare(benefitsCategory: benefitsCategory)
        return cell
    }
    
}

extension BenefitsCategoryCollectionViewDatasourceAndDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectBenefitsCategory(indexPath)
    }
}
