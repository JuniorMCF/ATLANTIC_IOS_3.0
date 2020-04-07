//
//  RegisterSucessViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/8/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol RegisterSucessViewModelProtocol {
    
    // Inputs
    func viewDidLoad()
    func registerUser(dni:String,number:String,password:String,repeatpass:String)
    // Outputs
    var showTitles: (([String]) -> Void)? { get set }
    var pushRegisterUser: ((String)->Void)?{get set}
    var showToast: ((String)->Void)?{get set}

}

class RegisterSucessViewModel: RegisterSucessViewModelProtocol {
    var showToast: ((String) -> Void)?
    
    var pushRegisterUser: ((String)->Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func registerUser(dni: String, number: String, password: String,repeatpass: String) {

        if(repeatpass.isEmpty){
            self.showToast?("Ingrese password")
        }
        if(password.isEmpty){
            self.showToast?("Ingrese password")
        }

        if(!password.isEmpty && !repeatpass.isEmpty){
            if(password != repeatpass){
                 self.showToast?("Contraseña no coincide")
            }
        }

        if(number.isEmpty){
             self.showToast?("Ingrese numero de celular")
        }


        if(!repeatpass.isEmpty && !password.isEmpty && repeatpass == password  && !number.isEmpty && !repeatpass.isEmpty){
        
            appDelegate.progressDialog.showProgress()
        let user_pass = Utils().MD5(string : password)
        var dominioUrl = URL(string: Constants().urlBase+Constants().postRegistro)
            dominioUrl = dominioUrl?.appending("dni", value: dni)
            dominioUrl = dominioUrl?.appending("user_pass", value: user_pass)
            dominioUrl = dominioUrl?.appending("phone", value: number)
            let url = dominioUrl!.absoluteString
            
            AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
            switch response.result{
                
            case.success(let value):
                         let json = JSON(value)
                         let resultado = json["resultado"].stringValue
                         let response = json["response"].stringValue
                         if(resultado == "200"){
                            self.showToast?(response)
                            self.pushRegisterUser?(response)
                           
                         }else {
                            if(resultado == "400"){
                                self.showToast?(response)
                            }else{
                               self.showToast?(response)
                            }
                            //en otros casos
                            
                         }
                         self.appDelegate.progressDialog.hideProgress()
                        break
                    case.failure(let error):
                       self.showToast?("Error: revise su conexión e intentelo nuevamente")
                        print(error)
                        break
                    }
                    
                }
            
        }
    }
        
    
    
    
    var showTitles: (([String]) -> Void)?
    
    func viewDidLoad() {
        var titles = [String]()
        let title1 = "ÚNANSE A NUESTRA GRAN FAMILIA"
        let title2 = "Número de celular"
        let title3 = "ingrese una clave"
        let title4 = "Su clave debe tener como máximo 4 dígitos, pueden ser números y letras"
        let title5 = "Repita su clave"
        titles.append(title1)
        titles.append(title2)
        titles.append(title3)
        titles.append(title4)
        titles.append(title5)
        showTitles?(titles)
    }
    
    
 

}
