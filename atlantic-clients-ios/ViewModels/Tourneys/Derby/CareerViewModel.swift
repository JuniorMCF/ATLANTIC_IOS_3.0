import Foundation

struct CareerTitles {
    
    var title: String = "Carrera Oro"
    var date: String = "fecha: 02 de Enero"
    var hour: String = "18:00 Hrs"
    var haveTitle: String = "Usted tiene 150 puntos"
    var lackTitle: String = "¡le faltan 50 puntos para ingresar a la carrera!"
    var nextCarrer: String = "Proxima carrera:"
    var categoryCarrer: String = "Carrera Diamante a las 22:00 hrs"
    var reminderTitle: String = "Crea Recordatorio"
    
}

protocol CareerViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapCareerResult()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((CareerTitles) -> Void)? { get set }
    var presentCareerResult: (() -> Void)? { get set }
    
}

class CareerViewModel: CareerViewModelProtocol {
    
    var showTitles: ((CareerTitles) -> Void)?
    var presentCareerResult: (() -> Void)?
    
    /**
     Muestra los titulos delas carreras
     */
    func viewDidLoad() {
        let titles = CareerTitles()
        showTitles?(titles)
    }
    
    /**
     Muestra los resultados de la carrera
     */
    func tapCareerResult() {
        presentCareerResult?()
    }
    
}
