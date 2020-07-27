import UIKit

class NewsEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventsImage: UIImageView!
    
    public func configure() {
        eventsImage.layer.cornerRadius = 8
        eventsImage.layer.masksToBounds = true
    }
    
}
