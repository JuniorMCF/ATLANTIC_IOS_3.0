import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class BreakfastCollectionViewDatasourceAndDelegate: NSObject {
    private var items: [Event] = []
    var fotoList : [UIImage]!
    init(items: [Event]) {
        self.items = items
    }
}

extension BreakfastCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if(fotoList.count > 0){
            cell.imageBreakfast.image = fotoList[indexPath.row]
        }
        cell.tituloBreakfast.text = items[indexPath.row].nombreCorto
        
       
        return cell
            
        }
}
