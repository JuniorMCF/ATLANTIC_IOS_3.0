import UIKit
/**
 Cell del TableView del club
 */
class ClubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: Label!
    
    @IBOutlet var img: UIImageView!
    @IBOutlet weak var icNotify: UIImageView!
    
    
    func prepare(category: ClubCategory) {
        title.setClubTitle(with: category.title)
        
        title.fontSizeScaleFamily(family: "HelveticaNeue-Bold", size: 16)
        img.image = UIImage(named: category.image)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    


}
