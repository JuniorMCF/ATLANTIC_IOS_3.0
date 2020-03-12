//
//  SettingsViewModel.swift
//  clients-ios
//
//  Created by Jhona on 8/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct SettingsTitles {
    
    var activeTitle: String = "Activar / Desactivar"
    var changePassword: String = "Cambiar Contraseña"
    
}

protocol SettingsViewModelProtocol {
    
    //Inputs
    
    func viewDidLoad(clienteId:String,isActivo:Bool)
    
    //Outputs
    
    var showTitles: ((SettingsTitles) -> Void)? { get set }
    
}

class SettingsViewModel: SettingsViewModelProtocol {

    
    
    var showTitles: ((SettingsTitles) -> Void)?
    
    func viewDidLoad(clienteId:String,isActivo:Bool) {
        let titles = SettingsTitles()
        showTitles?(titles)
        
        var dominioUrl = URL(string: Constants().urlBase+Constants().postConfigNotificacion)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        dominioUrl = dominioUrl?.appendingPathComponent("isActivo", isDirectory:isActivo)
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print(json)
                     //self.presentToast?("datos actualizados correctamente")

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
        
        
    }
    
}
