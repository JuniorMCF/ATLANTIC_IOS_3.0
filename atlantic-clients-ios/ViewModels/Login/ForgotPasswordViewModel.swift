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
    
}

protocol ForgotPasswordViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func getPhone(dni:String,tipo:Int)
    func tapForgotPassword()
    func recoveryPassword()
    // Outputs
    
    var showTitles: ((ForgotPasswordTitles) -> Void)? { get set }
    var showToast: ((String)->Void)?{get set}
    var presentForgotPassword:((String,String)->Void)?{get set}
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    var presentForgotPassword: ((String,String) -> Void)?
    
    var showToast: ((String) -> Void)?
    
    func getPhone(dni:String,tipo:Int) {
        if(tipo == 0){
            if(dni.count>=8){
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
                                            //showToast?()
                                            let response = json["response"] as! NSArray
                                            
                                            
                                         }else if (resultado == "400")  {
                                             //usuario no existe
                                         }else if (resultado == "401" ){
                                             //clave incorrecta
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
                self.showToast?("Longitud minima 8")
            }
        }else{
            if(dni.count>=12){
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
                                         let response = json["response"] as! NSArray
                                        var cel = ""
                                        var clienteId = ""
                                        for data in response{
                                            let val = JSON(data)
                                            cel = val["celular"].stringValue
                                            clienteId = val["clienteId"].stringValue
                                        }
                                        self.presentForgotPassword?(cel,clienteId)
                                         
                                      }else if (resultado == "400")  {
                                          //usuario no existe
                                      }else if (resultado == "401" ){
                                          //clave incorrecta
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
