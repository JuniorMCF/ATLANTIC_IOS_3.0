
import UIKit

class AllBenefitsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var AllBenefitsImageView: UIImageView!
    
    func prepare(foto: Foto){
        AllBenefitsImageView.image = UIImage(named: foto.foto)
    }
}
