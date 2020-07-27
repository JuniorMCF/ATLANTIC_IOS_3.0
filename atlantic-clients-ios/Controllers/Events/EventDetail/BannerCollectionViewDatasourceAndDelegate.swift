import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class BannerCollectionViewDatasourceAndDelegate: NSObject {
    
    private var items: [String] = []
    private let pageControl: UIPageControl
    
    init(items: [String], pageControl: UIPageControl) {
        self.items = items
        self.pageControl = pageControl
        self.pageControl.numberOfPages = items.count
    }
    
}

extension BannerCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCellID", for: indexPath) as? BannerCollectionViewCell
        
        let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/evento/"
        
        if(items[indexPath.row].isEmpty){
            
            cell?.bannerImage.contentMode = UIView.ContentMode.scaleAspectFit
        }
        
        AF.request(dominio + items[indexPath.row]).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell?.bannerImage.image = value
                             case .failure(let error):
                                 print(error)
                                 cell?.bannerImage.image = UIImage(named: "casino")
                             }

        }
        cell?.configure()
        return cell!
    }
    
    
}

extension BannerCollectionViewDatasourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension BannerCollectionViewDatasourceAndDelegate: UICollectionViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.tag == 0 else { return }
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                             y: (scrollView.frame.height / 2))
        guard let collectionView = scrollView as? UICollectionView else { return }
        if let ip = collectionView.indexPathForItem(at: center) {
            pageControl.currentPage = ip.row
        }
    }
}
