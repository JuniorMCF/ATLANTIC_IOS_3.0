//
//  ProfileDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 8/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct DetailTitles {
    var nameTitle: String = "Nombres"
    var nameText: String = "Leonardo"
    var lastNameTitle: String = "Apellidos"
    var lastNameText: String = "Del Castillo"
    var birthdateTitle: String = "Fecha de Nacimiento"
    var birthdateText: String = "08-06-1983"
    var dniTitle: String = "DNI"
    var dniText: String = "12345678"
    var phoneTitle: String = "Teléfono"
    var phoneText: String = "123-456-789"
    var emailTitle: String = "Correo Electronico"
    var emailText: String = "email@gmail.com"
    var addressTitle: String = "Dirección"
    var addressText: String = "Jr. Direccion - Las Vegas, Nevada"
    var saveTitle: String = "Guardar Información"
}

protocol ProfileDetailViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func saveProfile(celular:String, direccion:String, fechaNac:String, email:String, clienteId :String)
    // Outputs
    
    var showTitles: ((DetailTitles) -> Void)? { get set }
    var presentToast: ((String)->Void)? {get set}
}

class ProfileDetailViewModel: ProfileDetailViewModelProtocol {
    var presentToast: ((String) -> Void)?

    
    func saveProfile(celular:String, direccion:String, fechaNac:String, email:String, clienteId :String) {
        
        var dominioUrl = URL(string: Constants().urlBase+Constants().postUpdateUserData)
        dominioUrl = dominioUrl?.appending("celular", value: celular)
        dominioUrl = dominioUrl?.appending("direccion", value: direccion)
        dominioUrl = dominioUrl?.appending("fechaNac", value: fechaNac)
        dominioUrl = dominioUrl?.appending("email", value: email)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print(json)
                     self.presentToast?("datos actualizados correctamente")

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
    }
    
    
    var showTitles: ((DetailTitles) -> Void)?
    
    func viewDidLoad() {
        let titles = DetailTitles()
        showTitles?(titles)
    }
    
}
