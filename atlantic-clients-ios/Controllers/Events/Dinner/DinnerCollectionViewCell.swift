import UIKit

class DinnerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var totalLabel: Label!
    @IBOutlet weak var dinnerView: View!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(dinner: Dinner) {
        titleLabel.setDinnerTitle(with: dinner.title)
        dateLabel.setDinnerSubTitle(with: dinner.date)
        totalLabel.setDinnerSubTitle(with: "\(dinner.totalPersons) Acompañantes")
        dinnerView.addCornerRadius(radius: 20)
    }

}
