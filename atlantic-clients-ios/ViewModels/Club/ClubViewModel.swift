
import Foundation

public struct ClubCategory{
    
    var title: String
    var image: String
    
}

class ClubDatasources {
    
    var items: [ClubCategory] = [
        ClubCategory(title: "Sorteos",image: "sorteos_img"),
        ClubCategory(title: "Beneficios",image: "beneficios_img"),
        ClubCategory(title: "Torneos",image: "torneos_img"),
    ]
}

protocol ClubViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didSelectClub(_ indexPath: IndexPath)
    
    // Mark: - Outputs (Closures)
    
    var loadDatasources: ((ClubDatasources) -> Void)? { get set }
    var presentClubCategory: ((ClubCategoryTypes) -> Void)? { get set }
}

class ClubViewModel: ClubViewModelProtocol {
    
    var loadDatasources: ((ClubDatasources) -> Void)?
    var presentClubCategory: ((ClubCategoryTypes) -> Void)?
    
    func viewDidLoad() {
        let datasources = ClubDatasources()
        loadDatasources?(datasources)
    }
    
    /**
        Selecciona el club del banner
     - Parameters:
        - indexParh: categoria del club
     */
    func didSelectClub(_ indexPath: IndexPath) {
        guard let type = ClubCategoryTypes(rawValue: indexPath.row) else { return }
        presentClubCategory?(type)
    }
 
}

enum ClubCategoryTypes: Int {
    
    case sorteo = 0
    case beneficios = 1
    case torneos = 2
    
}
