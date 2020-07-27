import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var dailyPromotionLabel: UILabel!
    
    public func configure() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        
    }

}
