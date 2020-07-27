import Foundation

public struct Breakfast {
    
    var nameImage: String
    
}

class BreakfastDatasources {
    var items: [Breakfast] = [
        Breakfast(nameImage: "img-breakfast-1"),
        Breakfast(nameImage: "img-breakfast-2"),
        Breakfast(nameImage: "img-breakfast-3"),
        Breakfast(nameImage: "img-breakfast-4"),
        Breakfast(nameImage: "img-breakfast-2"),
        Breakfast(nameImage: "img-breakfast-3"),
        Breakfast(nameImage: "img-breakfast-4"),
        Breakfast(nameImage: "img-breakfast-3"),
        Breakfast(nameImage: "img-breakfast-4"),
        Breakfast(nameImage: "img-breakfast-1")
    ]
}

protocol BreakfastViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didBreakfastSelected(_ indexPath: Event)
    
    // Mark: - Outputs (Closures)
    
    var loadDatasources: ((BreakfastDatasources) -> Void)? { get set }
    var presentBreakfastDetail: (() -> Void)? { get set }
    var presentEventDetail: ((Event)->Void)?{get set}
}

class BreakfastViewModel: BreakfastViewModelProtocol {
    var presentEventDetail: ((Event) -> Void)?
    var loadDatasources: ((BreakfastDatasources) -> Void)?
    var presentBreakfastDetail: (() -> Void)?
    
    /**
    Inicializa la vista
     */
    func viewDidLoad() {
        let datasources = BreakfastDatasources()
        loadDatasources?(datasources)
    }
    

    /**
    Accede al evento seleccionado
     - Parameters:
        - indexPath: evento seleccionado
     */
    
    func didBreakfastSelected(_ indexPath: Event) {
        presentEventDetail?(indexPath)
    }
}
