import UIKit

class BenefitsCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var benefitsView: View!
    
    func prepare(benefitsCategory: BenefitsCategory) {
        titleLabel.setCategoryTitle(with: benefitsCategory.title)
        dateLabel.setCategorySubTitle(with: benefitsCategory.date)
        pointsLabel.setCategoryPoints(with: benefitsCategory.points)
        benefitsView.addCornerRadius(radius: 20)
        
    }
    
}
