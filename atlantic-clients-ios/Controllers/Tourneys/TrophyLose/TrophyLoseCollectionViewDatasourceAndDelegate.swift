import UIKit

class TrophyLoseCollectionViewDatasourceAndDelegate: NSObject {
        private var items: [TournamentTable] = []
        private var viewModel: TrophyLoseViewModelProtocol
        var pos : Int = 0
    init(items: [TournamentTable], viewModel: TrophyLoseViewModelProtocol,pos:Int) {
            self.items = items
            self.viewModel = viewModel
            self.pos = pos
       }
}

extension TrophyLoseCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrophyLoseCellID", for: indexPath) as? TrophyLoseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 15
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowRadius = 15
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = true ? UIScreen.main.scale : 1
        
        let positions = items[indexPath.row]
        if(self.pos == positions.posicion){
            cell.layer.backgroundColor = UIColor.red.cgColor
        }else{
            cell.layer.backgroundColor = UIColor.white.cgColor
        }
        cell.prepare(item: positions)
        return cell
    }
    
}
extension TrophyLoseCollectionViewDatasourceAndDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didItemSelected(indexPath)
    }
   
}
extension TrophyLoseCollectionViewDatasourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,  height: collectionView.frame.height/5)
    }
}
