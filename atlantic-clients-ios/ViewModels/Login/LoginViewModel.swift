//
//  LoginViewModel.swift
//  clients-ios
//
//  Created by Cristian Palomino on 7/20/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct LoginTitles {
    
    var screenTitle: String = "BIENVENIDO"
    var dniPlaceholder: String = "DNI"
    var passwordPlaceholder: String = "Contraseña"
    var buttonTitle: String = "Iniciar Sessión"
    var newUserPlaceholder: String = "Crear nuevo usuario"
    var forgotPasswordTitle: String = "¿Olvidó su contraseña?"
    
}

protocol LoginViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapLogin(dni:String,password:String,terminos:Bool)
    func tapNewUSer()
    func tapForgotPassword()
    func isLoggin()
    func tapTerminos(estado:Bool)
    // Outputs
    
    var showTitles: ((LoginTitles) -> Void)? { get set }
    var presentOnboarding: (() -> Void)? { get set }
    var presentRegister: (() -> Void)? { get set }
    var presentForgotPassword:(()->Void)?{get set}
    var changeTerminos:((Bool)->Void)?{get set}
    var presentSetData:((String,String)->Void)?{get set}
}

class LoginViewModel: LoginViewModelProtocol {
    

    func tapForgotPassword() {
        presentForgotPassword?()
    }
    var progressDialog : CustomProgress!
    var showTitles: ((LoginTitles) -> Void)?
    var presentOnboarding: (() -> Void)?
    var presentRegister: (() -> Void)?
    var presentForgotPassword: (() -> Void)?
    var changeTerminos: ((Bool) -> Void)?
    var presentSetData: ((String,String) -> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func viewDidLoad() {
        let titles = LoginTitles()
        progressDialog = appDelegate.progressDialog
        showTitles?(titles)
        
    }
    func isLoggin(){
        let value = Constants().getLogin()
        
        if(value == true){
            self.presentSetData?(Constants().getUsername(),Constants().getPassword())
            self.tapLogin(dni: Constants().getUsername(), password: Constants().getPassword(), terminos: true)
        }
    }
    func tapTerminos(estado:Bool) {
        if(estado == true){
            self.changeTerminos?(false)
        }else{
            self.changeTerminos?(true)
        }
    }

    
    func tapLogin(dni:String,password:String,terminos:Bool) {
        
        if(terminos == true){
                if(dni == "" || password == ""){
                    if(dni == ""){
                        //return ingrese campo
                    }
                    if(password == ""){
                        //return ingrese password
                    }
                }else{
                    let user_pass = Utils().MD5(string : password)
                    
                    let parameters = ["dni":dni,"user_pass":user_pass]
                    progressDialog.showProgress()
                    AF.request(Constants().urlBase+Constants().getLoginClients ,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
                        switch response.result{
                            
                        case.success(let value):
                                     let json = JSON(value)
                                     print("usuario",json)
                                     let data = json.stringValue.data(using: .utf8)
                                     do {
                                         // make sure this JSON is in the format we expect
                                         if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                                             // try to read out a string array
                                            let resultado = json["resultado"] as! String
                                             if(resultado == "200"){
                                                let response = json["response"] as! NSArray
                                                // jean kk se olvido de hacer bien la webservice para usuario :V
                                                let usuario = Usuario()
                                                
                                                for data in response{
                                                    let value = JSON(data)
                                                    usuario.nombre = value["nombre"].stringValue
                                                    usuario.celular = value["celular"].stringValue
                                                    usuario.clienteId = value["clienteId"].stringValue
                                                    usuario.configNotify = value["configNotify"].boolValue
                                                    usuario.direccion = value["direccion"].stringValue
                                                    usuario.distrito = value["direccion"].stringValue
                                                    usuario.dni = value["dni"].stringValue
                                                    usuario.email = value["email"].stringValue
                                                    usuario.fechaNac = value["fechaNac"].stringValue
                                                    usuario.nivel = value["nivel"].stringValue
                                                }
                                                self.appDelegate.usuario = usuario
                                                Constants().saveUsername(username: dni)
                                                Constants().savePassword(password: password)
                                                Constants().saveTerminos(terminoState: true)
                                                Constants().saveLogin(isLogin: true)
                                                 self.progressDialog.hideProgress()
                                                self.presentOnboarding?()
                                             }else if (resultado == "400")  {
                                                 //usuario no existe
                                             }else if (resultado == "401" ){
                                                 //clave incorrecta
                                             }
                                           
                                             
                                         }
                                     } catch let error as NSError {
                                        self.progressDialog.hideProgress()
                                         print("Failed to load: \(error.localizedDescription)")
                                     }
                                     
                                    break
                                case.failure(let error):
                                    self.progressDialog.hideProgress()
                                    print(error)
                                    break
                                }
                                
                            }
                }
        }else{
            
        }
        
        

    }
    
    func tapNewUSer() {
        presentRegister?()
    }
    
}
