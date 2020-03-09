//
//  RecoveryPasswordViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/8/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol RecoveryPasswordViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()

    func tapForgotPassword()
    func recoveryPassword(clienteId:String,password1:String,password2:String)
    // Outputs
    
    var showTitles: (([String]) -> Void)? { get set }
    var showToast: ((String)->Void)?{get set}
    var presentForgotPassword:(()->Void)?{get set}
}

class RecoveryPasswordViewModel: RecoveryPasswordViewModelProtocol {
    var showToast: ((String) -> Void)?
    
    var showTitles: (([String]) -> Void)?
    
    func recoveryPassword(clienteId:String,password1:String,password2:String) {
        
        if(!password1.isEmpty && !password2.isEmpty && password1.count == 4 && password2.count == 4){
            if(password1 == password2){
                let user_pass = Utils().MD5(string: password1)
                var dominioUrl = URL(string: Constants().urlBase+Constants().postUpdatePassword)
                dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
                dominioUrl = dominioUrl?.appending("user_pass", value: user_pass)

                let url = dominioUrl!.absoluteString
                
                AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
                switch response.result{
                    
                case.success(let value):
                             let json = JSON(value)
                             print(json)
                             let resultado = json["resultado"].stringValue
                             let response = json["response"].stringValue
                             if(resultado == "200"){
                                self.showToast?(response)
                             }
                             

                            break
                        case.failure(let error):
                           
                            print(error)
                            break
                        }
                        
                    }
            }else{
                showToast?("Contraseña no coinciden")
            }
        }

        if(password2.isEmpty){
            showToast?("Ingrese contraseña")
        }
        if(password1.isEmpty){
            showToast?("Ingrese contraseña")
        }

        if(password2.count<4){
            showToast?("Longitud de contraseña debe ser 4")
        }
        if(password1.count<4){
            showToast?("Longitud de contraseña debe ser 4")
        }
        
    }


    var presentForgotPassword: (() -> Void)?
    
    func viewDidLoad() {
        var titles = [String]()
        titles.append("INGRESE CONTRASEÑA")
        titles.append("Contraseña")
        titles.append("Repetir Contraseña")
        titles.append("Repetir Contraseña")
        titles.append("Continuar")
        showTitles?(titles)
    }
    
    func tapForgotPassword() {
        
    }

}