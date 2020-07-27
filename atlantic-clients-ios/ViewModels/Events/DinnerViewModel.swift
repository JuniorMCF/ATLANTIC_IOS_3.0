import Foundation

public struct Dinner {
    
    var title: String
    var date: String
    var totalPersons: Int
    
}

class DinnerDatasources {
    var items: [Dinner] = [
        Dinner(title: "Festival Brasas", date: "Lunes 28 de marzo" , totalPersons: 2),
        Dinner(title: "Parrilla Atlantic", date: "Lunes 28 de marzo" , totalPersons: 2),
        Dinner(title: "Parrilla Atlantic", date: "Lunes 28 de marzo" , totalPersons: 2)
    ]
}

protocol DinnerViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didDinnerSelected(_ indexPath: IndexPath)
    
    // Mark: - Outputs (Closures)
    
    var loadDatasources: ((DinnerDatasources) -> Void)? { get set }
    var presentDinnerDetail: (() -> Void)? { get set }
}

class DinnerViewModel: DinnerViewModelProtocol {
    
    
    var loadDatasources: ((DinnerDatasources) -> Void)?
    var presentDinnerDetail: (() -> Void)?
    
    func viewDidLoad() {
        let datasources = DinnerDatasources()
        loadDatasources?(datasources)
    }
    
    /**
    Retorna la posicion del evento seleccionado
     - Parameters:
        - indexPath:  evento  seleccionado
     */
        func didDinnerSelected(_ indexPath: IndexPath) {
        presentDinnerDetail?()
    }
}
