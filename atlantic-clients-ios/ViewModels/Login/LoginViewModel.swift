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
    var dniPlaceholder: String = "Documento"
    var passwordPlaceholder: String = "Contraseña"
    var buttonTitle: String = "Iniciar Sesión"
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
    var showToastMessage : ((String)->Void)?{get set}
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
    var showToastMessage : ((String)->Void)?
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
    
    func getNov(){
        self.tapTerminos(estado: true)
        
        let dominioUrl = Constants().urlBase+Constants().getNovedades
        let parameters = ["idCliente":self.appDelegate.usuario.clienteId]
        AF.request(dominioUrl ,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON(completionHandler: { response in
            
            switch response.result{
                
            case.success(let value):
                         let json = JSON(value)
                         let data = json.stringValue.data(using: .utf8)
                         do {
                             if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                                let cobros = json["cobros"] as! Bool
                                let sorteo = json["sorteo"] as! Bool
                                let beneficio = json["beneficio"] as! Bool
                                let torneo = json["torneo"] as! Bool
                                let eventos = json["eventos"] as! Bool
                                
                                var body = "0"
                                
                                if(cobros){
                                    body = "0"
                                    Constants().saveBody(isActive: true, key: "body"+body)
                                }
                                if(sorteo){
                                    body = "1"
                                    Constants().saveBody(isActive: true, key: "body"+body)
                                }
                                if(beneficio){
                                    body = "2"
                                    Constants().saveBody(isActive: true, key: "body"+body)
                                }
                                if(torneo){
                                    body = "3"
                                    Constants().saveBody(isActive: true, key: "body"+body)
                                }
                                if(eventos){
                                    body = "4"
                                    Constants().saveBody(isActive: true, key: "body"+body)
                                }
                                
                                 self.progressDialog.hideProgress()
                                 self.presentOnboarding?()
                             }
                         } catch let error as NSError {
                            self.progressDialog.hideProgress()
                            self.presentOnboarding?()
                             print("Failed to load: \(error.localizedDescription)")
                         }
                         
                        break
                    case.failure(let error):
                        self.progressDialog.hideProgress()
                        self.presentOnboarding?()
                        print(error)
                        break
                    }
              /*print(response)
              let result = JSON(response)
              print("data aca")
              print(result)
              */
              
	        })
        
    }

    
    func tapLogin(dni:String,password:String,terminos:Bool) {
        let isLogin = Constants().getLogin()
        
        if(terminos == true){
                //tapTerminos(estado: true)
                if(dni == "" || password == ""){
                    if(dni == ""){
                        self.showToastMessage?("Longitud minima 8")
                        return
                        //return ingrese campo
                    }
                    if(password == ""){
                        self.showToastMessage?("Campo requerido")
                        return
                        //return ingrese password
                    }
                }else{
                    let user_pass = Utils().MD5(string : password)
                    
                    let parameters = ["dni":dni,"user_pass":user_pass]
                    if(!isLogin){
                        progressDialog.showProgress()
                    }
                    
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
                                                if #available(iOS 13.0, *) {
                                                    let scene = UIApplication.shared.connectedScenes.first
                                                    if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                                                        sd.usuario = usuario
                                                    }
                                                    
                                                } 
                                               self.appDelegate.usuario = usuario
                                                
                                                Constants().saveUsername(username: dni)
                                                Constants().savePassword(password: password)
                                                Constants().saveTerminos(terminoState: true)
                                                Constants().saveLogin(isLogin: true)
                                                self.getNov()
                                                
                                             }else if (resultado == "400")  {
                                                self.progressDialog.hideProgress()
                                                 //usuario no existe
                                                self.showToastMessage?("Usuario no existe")
                                             }else if (resultado == "401" ){
                                                self.progressDialog.hideProgress()
                                                self.showToastMessage?("Contraseña Incorrecta")
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
             showToastMessage?("Tiene que aceptar las politicas de privacidad")
             //tapTerminos(estado: false)
        }
        
        

    }
    
    func tapNewUSer() {
        presentRegister?()
    }
    
}
