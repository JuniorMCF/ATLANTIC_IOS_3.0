
import UIKit

class BenefitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var benefitImageView: UIImageView!
    
    func prepare(benefit: Benefits) {
        benefitImageView.image = UIImage(named: benefit.nombre)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
