import Foundation

struct ReminderTitles {
    
    var reminderTitle: String = "¿Permitir que Atlantic City cree recordatorios en calendar?"
    var acceptTitle = "ACEPTAR"
    var declineTitle = "RECHAZAR"
    
}

protocol ReminderViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapAccept()
    func tapDecline()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((ReminderTitles) -> Void)? { get set }
    var dismisViewController: (() -> Void)? { get set }
}

class ReminderViewModel: ReminderViewModelProtocol {
    
    
    var showTitles: ((ReminderTitles) -> Void)?
    var dismisViewController: (() -> Void)?
    /**
    Cargar los titulos de los elementos de la vista
     */
    func viewDidLoad() {
        let titles = ReminderTitles()
        showTitles?(titles)
    }
    
    /**
    Acepta el recordatorio
     */
    func tapAccept() {
        dismisViewController?()
    }
    /**
    Deniega el recordatorio
     */
    func tapDecline() {
        dismisViewController?()
    }
}
