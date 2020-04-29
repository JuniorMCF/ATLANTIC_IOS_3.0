//
//  ForgotPasswordViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/1/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ForgotPasswordTitles {
    
    var screenTitle: String = "Elija su tipo de documento"
    var dniPlaceholder: String = "DNI"
    var recoveryPassword : String = "Continuar"
    var screenTitle2 : String = "CÓDIGO DE VERIFICACIÓN"
    
}

protocol ForgotPasswordViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func getPhone(dni:String,tipo:Int)
    func tapForgotPassword()
    func recoveryPassword()
    func verifyCode(code:String,celular:String,clienteId:String)
    // Outputs
    
    var showTitles: ((ForgotPasswordTitles) -> Void)? { get set }
    var showToast: ((String)->Void)?{get set}
    var presentForgotPassword:((String,String)->Void)?{get set}
    var presentRecoveryPassword:(()->Void)?{get set}
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    var presentForgotPassword: ((String,String) -> Void)?
    var presentRecoveryPassword: (()->Void)?
    var showToast: ((String) -> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func verifyCode(code:String,celular:String,clienteId:String){
        
        if(code.count < 4){
            self.showToast?("Código de 4 digitos")
            return
        }
        appDelegate.progressDialog.message = "Validando código de verificación"
        appDelegate.progressDialog.showProgress()
        let dominio = Constants().urlBase + Constants().postVerificarCodigo
        
        var dominioUrl = URL(string: dominio)
        dominioUrl = dominioUrl?.appending("to", value:celular)
        dominioUrl = dominioUrl?.appending("code", value:code)
        let url = dominioUrl!.absoluteString
        AF.request(url,method: .post,parameters: nil,encoding:  URLEncoding.default,headers:nil).responseJSON{(response) in
          switch response.result{
              
          case.success(let value):
            let json = JSON(value).boolValue
            if(json){
                self.presentRecoveryPassword?()
                self.appDelegate.progressDialog.hideProgress()
            }else{
                self.showToast?("Error: código incorrecto")
                self.appDelegate.progressDialog.hideProgress()
            }
            
                        
             break
            case.failure(let error):
                self.showToast?("Error de conexión")
                self.appDelegate.progressDialog.hideProgress()
                print(error)
                break
                  }
                  
              }
        
        
        
    }
    
    func getPhone(dni:String,tipo:Int) {
        
        if(dni.count>=8 && dni.count <= 12){
            appDelegate.progressDialog.message = "Verificando Usuario..."
            appDelegate.progressDialog.showProgress()
                   var dominioUrl = URL(string: Constants().urlBase+Constants().getObtenerTelefono)
                   dominioUrl = dominioUrl?.appending("dni", value:dni)

                   let url = dominioUrl!.absoluteString
                   
                   AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
                   switch response.result{
                       
                   case.success(let value):
                                let json = JSON(value)
                                print(json)
                                let data = json.stringValue.data(using: .utf8)
                                 do {
                                     // make sure this JSON is in the format we expect
                                     if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                                         // try to read out a string array
                                        let resultado = json["resultado"] as! String
                                         if(resultado == "200"){
                                            self.appDelegate.progressDialog.hideProgress()
                                            self.appDelegate.progressDialog.message = "Enviando código de verificación..."
                                            self.appDelegate.progressDialog.showProgress()
                                            //showToast?()
                                            let response = json["response"] as! [String:String]
                                            var celular = ""
                                            var clienteId = ""
                                            for data in response.keys{
                                                if data == "celular"{
                                                    celular = response[data]!
                                                }
                                                if data == "clienteId"{
                                                    clienteId = response[data]!
                                                }
                                            }
                                            let dominio = Constants().urlBase + Constants().postObtenerCodigo
                                          
                                            var dominioUrl = URL(string: dominio)
                                            dominioUrl = dominioUrl?.appending("to", value:celular)
                                            let url = dominioUrl!.absoluteString
                                       
                                            AF.request(url,method: .post,parameters: nil,encoding:  URLEncoding.default,headers:nil).responseJSON{(response) in
                                                              switch response.result{
                                                                  
                                                              case.success(let value):
                                                            let json = JSON(value).boolValue
                                                           
                                                            if(json){
                                                               self.presentForgotPassword?(celular,clienteId)
                                                                self.appDelegate.progressDialog.hideProgress()
                                                            }else{
                                                                self.showToast?("Error al enviar el código")
                                                                self.appDelegate.progressDialog.hideProgress()
                                                            }
                                                                           
                                                            
                                                                           break
                                                                      case.failure(let error):
                                                                          self.showToast?("Error de conexión")
                                                                          self.appDelegate.progressDialog.hideProgress()
                                                                          print(error)
                                                                          break
                                                                      }
                                                                      
                                                                  }
                                            
                                            
                                         }else{
                                            self.showToast?("Usuario no registrado")
                                            self.appDelegate.progressDialog.hideProgress()
                                            
                                        }
                                       
                                         
                                     }
                                 } catch let error as NSError {
                                    
                                     print("Failed to load: \(error.localizedDescription)")
                                 }
                                 
                                break
                           case.failure(let error):
                           
                               print(error)
                               break
                           }
                           
                }
            }else{
                if(tipo == 0){
                    self.showToast?("Longitud minima 8")
                }else{
                    self.showToast?("Longitud minima 12")
                }
                
            }
        
       
    }
    
    func recoveryPassword() {
        
        
        
    }

    var showTitles: ((ForgotPasswordTitles) -> Void)?

    
    func viewDidLoad() {
        let titles = ForgotPasswordTitles()
        showTitles?(titles)
    }
    
    func tapForgotPassword() {
        
    }

}
