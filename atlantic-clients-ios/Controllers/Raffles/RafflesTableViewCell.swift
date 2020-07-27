import UIKit

class RafflesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rafflesImageView: UIImageView!
    
    func prepare(raffles: Sorteo) {
        rafflesImageView.image = UIImage(named: raffles.logoUrl)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
