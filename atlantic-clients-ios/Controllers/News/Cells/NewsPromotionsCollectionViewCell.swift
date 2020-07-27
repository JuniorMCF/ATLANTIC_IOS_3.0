import UIKit

class NewsPromotionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var promotionsImage: UIImageView!
    
    public func configure() {
 
        promotionsImage.layer.cornerRadius = 0
        promotionsImage.layer.masksToBounds = true
    }
    
}
