import Foundation
import Alamofire
import SwiftyJSON

protocol ChangePasswordViewModelProtocol {
    
    //Inputs
    
    func viewDidLoad()
    func changePassword(beforePassword:String,newPassword:String,confirmPassword:String,condition1:Bool,condition2:Bool)
    //Outputs
    
    var showTitles: (([String]) -> Void)? { get set }
    var showToast: ((String)->Void)? {get set}
    var backPressed: (()->Void)? {get set}
}

class ChangePasswordViewModel: ChangePasswordViewModelProtocol {
    var backPressed: (() -> Void)?
    var showToast: ((String) -> Void)?
    let appDelegate = UIApplication
        .shared.delegate as! AppDelegate
    
    
    /**
    cambia el password por el password ingresado
     - Parameters:
        - beforePassword: antiguo password
        - newPassword : nuevo password
        - confirmPassword : nuevo password
        - condition1 :  la longitud minima es de 4 caracteres
        - condition2 : el password debe tener almenos 1 numero
     */
    func changePassword(beforePassword:String,newPassword:String,confirmPassword:String,condition1:Bool,condition2:Bool) {
        if(beforePassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty){
            showToast?("Todos los campos son requeridos")
            return
        }

        if(!condition1 ){
            showToast?("Longitud minima 4")
            return
        }
        if(!condition2){
            showToast?("La contraseña debe tener almenos 1 numero")
            return
        }
        let currentPassword = Constants().getPassword()

        if(currentPassword != beforePassword ){
            showToast?("Contraseña ingresada incorrecta")
            return
        }

        if(newPassword != confirmPassword){
            showToast?("Las contraseñas no coinciden")
            return
        }
        let user_pass = Utils().MD5(string: newPassword)
        var dominioUrl = URL(string: Constants().urlBase+Constants().postUpdatePassword)
        dominioUrl = dominioUrl?.appending("clienteId", value: String(appDelegate.usuario.clienteId))
        dominioUrl = dominioUrl?.appending("user_pass", value : user_pass)
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print(json)
                     Constants().savePassword(password: newPassword)
                     self.showToast?("Contraseña cambiada con exito")
                     self.backPressed?()

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
        
    }
    
    var showTitles: (([String]) -> Void)?
    
        
    /**
    inicializa los titulos para el cambio de password
     */
    func viewDidLoad() {
        var titles = [String]()
        titles.append("Contraseña Antigua")
        titles.append("Contraseña Nueva")
        titles.append("Repetir Nueva Contraseña")
        titles.append("Continuar")
        showTitles?(titles)

        
    }
    
}
