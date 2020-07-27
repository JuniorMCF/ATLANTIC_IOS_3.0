

import Foundation

struct RafflesDetailTitles {
    
    var rafflesTitle: String = "Sorteo Estelar"
    var nextDate: String = "Próxima fecha:"
    var date: String = "Sábado 15 de noviembre"
    var reminderTitle = "Crear Recordatorio"
    var optionsTitle: String = "Hasta este momento tiene:"
    var options: String = "208 opciones"
    var points: String = "Tiene 2487 Puntos"
    var necesaryPoints = "¡Le faltan 258 puntos para una opcion adicional!"
    
}

protocol RafflesDetailViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapCreateReminder()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((RafflesDetailTitles) -> Void)? { get set }
    var presentCreateReminder: (() -> Void)? { get set }
}

class RafflesDetailViewModel: RafflesDetailViewModelProtocol {

    var showTitles: ((RafflesDetailTitles) -> Void)?
    var presentCreateReminder: (() -> Void)?
    
    /**
    muestra los titulos de los sorteos
     */
    func viewDidLoad() {
        let titles = RafflesDetailTitles()
        showTitles?(titles)
    }
    /**
    crea un recordatorio del torneo
     */
    func tapCreateReminder() {
        presentCreateReminder?()
    }

}
