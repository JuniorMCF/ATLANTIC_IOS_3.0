import UIKit

class TourneyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tourneyImage: UIImageView!
    
    func prepare(tourney: TournamentDetails) {
        tourneyImage.image = UIImage(named: tourney.logo)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
