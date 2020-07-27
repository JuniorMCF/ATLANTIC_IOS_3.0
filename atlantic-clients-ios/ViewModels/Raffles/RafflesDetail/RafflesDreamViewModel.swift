

import Foundation
import Alamofire
import SwiftyJSON
struct RafflesDreamTitles {
    
    var rafflesTitle: String = "Sorteo De Tus Sueños"
    var nextDate: String = "Próxima fecha:"
    var date: String = "5 y 6 Diciembre"
    var reminderTitle = "Crear Recordatorio"
    var optionsTitle: String = "Hasta este momento tiene:"
    var options: String = "250 opciones"
    var points: String = "Tiene 60 000 Puntos"
    var necesaryPoints = "¡Le faltan 258 puntos para una opcion adicional!"
    
}

protocol RafflesDreamViewModelProtocol {
    
    // Mark: - Inputs
    func onStart(clienteId:String,fechaIngreso:String,nombrePromocion:String,promocionId:String)
    func viewDidLoad()
    func tapCreateReminder()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((RafflesDreamTitles) -> Void)? { get set }
    var presentCreateReminder: (() -> Void)? { get set }
}

class RafflesDreamViewModel: RafflesDreamViewModelProtocol {
    
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String) {
        var dominioUrl = URL(string: Constants().urlBase+Constants().postAgregarActividadPromocion)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        dominioUrl = dominioUrl?.appending("fechaIngreso", value: fechaIngreso)
        dominioUrl = dominioUrl?.appending("nombrePromocion", value: nombrePromocion)
        dominioUrl = dominioUrl?.appending("promocionId", value: promocionId)
        
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print("statistics",json)
                     
                     //self.presentToast?("datos actualizados correctamente")

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
        
    }
    

    var showTitles: ((RafflesDreamTitles) -> Void)?
    var presentCreateReminder: (() -> Void)?
    
    func viewDidLoad() {
        let titles = RafflesDreamTitles()
        showTitles?(titles)
    }
    
    func tapCreateReminder() {
        presentCreateReminder?()
    }

}
