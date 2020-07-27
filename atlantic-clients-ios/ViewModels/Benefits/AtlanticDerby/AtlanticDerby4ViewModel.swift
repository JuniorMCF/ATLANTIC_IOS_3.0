import Foundation
import Alamofire
import SwiftyJSON
protocol AtlanticDerby4ViewModelProtocol{
    //funciones de entrada
    func viewDidLoad(nombre:String)
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String)
    //variables de salida
    var loadDataSources:(([String])->Void)?{get set}
    var presentTitles:(([String])->Void)?{get set}
    
}
class AtlanticDerby4ViewModel : AtlanticDerby4ViewModelProtocol{
    var loadDataSources: (([String]) -> Void)?
    var presentTitles: (([String]) -> Void)?
    
    /**
    Agrega actividad de la promocion
    - Parameters:
        - clienteId: id del cliente
        - fechaIngreso: fecha de ingreso a la promocion
        - nombrePromocion: nombre de la promocion
        - promocionId: id de la promocion
    */
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
    
    /**
     Prepara la vista del derby
     */
    func viewDidLoad(nombre:String){
        if(nombre.lowercased().contains("diamante")){
           let list = ["1er puesto: $100","2do puesto: $40","3er puesto: $20"]
           loadDataSources?(list)
           presentTitles?(list)
        }else{
            let list = ["1er puesto: $50","2do puesto: $20","3er puesto: $10"]
            loadDataSources?(list)
            presentTitles?(list)
        }
        
        
    }
}
