import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
class AllBenefitsCollectionViewDelegateAndDatasource: NSObject {

    private var items : [Foto] = []
    private var viewModel : AllBenefitsViewModelProtocol
    private var pageControl : UIPageControl
    private var collectionView: UICollectionView
        
    init(items:[Foto],viewModel:AllBenefitsViewModelProtocol,pageControl:UIPageControl,collectionView:UICollectionView){
            self.items = items
            self.viewModel = viewModel
            self.pageControl = pageControl
            self.pageControl.numberOfPages = items.count
            self.collectionView = collectionView
        }
    
}

extension AllBenefitsCollectionViewDelegateAndDatasource: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.currentPage = 0
        return items.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllBenefitsCellID", for: indexPath) as? AllBenefitsCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
        
        AF.request(dominio + items[indexPath.row].foto).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell.AllBenefitsImageView.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        
        return cell
    }
        
}

extension AllBenefitsCollectionViewDelegateAndDatasource: UICollectionViewDelegateFlowLayout{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.tag == 0) {
           let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
            if let ip = self.collectionView.indexPathForItem(at: center) {
               self.pageControl.currentPage = ip.row
           }
       }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
}
