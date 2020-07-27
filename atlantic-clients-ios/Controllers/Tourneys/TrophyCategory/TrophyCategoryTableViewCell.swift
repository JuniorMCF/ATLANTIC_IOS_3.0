import UIKit

class TrophyCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trophyImageView: UIImageView!
    @IBOutlet weak var levelTitle: Label!
    
    func prepare(trophyCategory: Tournament) {
        trophyImageView.image = UIImage(named: trophyCategory.logo)
        levelTitle.setDetailSubDark(with: trophyCategory.nombre)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
