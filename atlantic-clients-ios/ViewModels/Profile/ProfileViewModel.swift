import Foundation

struct ProfileTitles {
    
    var userName: String = "Leonardo Del Castillo"
    var profilePlaceHolder: String = "Mi perfil"
    var diaryPlaceHolder: String = "Mi agenda"
    var contactPlaceHolder: String = "Notificaciones"
    var settingsPlaceHolder: String = "Configuración"
    var termsPlaceHolder: String = "Términos y políticas de privacidad"
    var logOutPlaceHolder: String = "Cerrar sesión"
    
}

protocol ProfileViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapProfile()
    func tapSettings()
    func tapLogOut()
    func pushNotify()
    func pushAgenda()
    // Outputs
    
    var showTitles: ((ProfileTitles) -> Void)? { get set }
    var pushProfileDetail: (() -> Void)? { get set }
    var pushSettings: (() -> Void)? { get set }
    var presentLogin: (() -> Void)? { get set }
    var presentNotify: (()->Void)?{get set}
    var presentAgenda: (()->Void)?{get set}
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var showTitles: ((ProfileTitles) -> Void)?
    var pushProfileDetail: (() -> Void)?
    var pushSettings: (() -> Void)?
    var presentLogin: (() -> Void)?
    var presentNotify: (()->Void)?
    var presentAgenda: (()->Void)?
    
    func viewDidLoad() {
        let titles = ProfileTitles()
        showTitles?(titles)
    }
    
    /**
     Abre los detalles de la cuenta
     */
    func tapProfile() {
        pushProfileDetail?()
    }
    /**
     Abre opciones adicionales
     */
    func tapSettings() {
        pushSettings?()
    }
    
    /**
     Cierra sesion de la cuenta
     */
    func tapLogOut() {
        presentLogin?()
    }
    
    /**
     Muestra las notificaciones.
     */
    func pushNotify(){
        presentNotify?()
    }
    /**
     Muestra la agenda del cliente
     */
    func pushAgenda() {
        presentAgenda?()
    }
}

