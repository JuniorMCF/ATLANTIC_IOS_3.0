import UIKit

class AD4CollectionViewDelegateAndDatasource: NSObject {
    private var items: [String] = []
    private var viewModel: AtlanticDerby4ViewModelProtocol
    
    init(items: [String], viewModel: AtlanticDerby4ViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension AD4CollectionViewDelegateAndDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AD4CellID", for: indexPath) as? AD4CollectionViewCell else {
            return UICollectionViewCell()
        }
        let positions = items[indexPath.row]
        cell.prepare(data: positions)
        return cell
    }
    
}
extension AD4CollectionViewDelegateAndDatasource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didItemSelected(indexPath)
    }
}
extension AD4CollectionViewDelegateAndDatasource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
