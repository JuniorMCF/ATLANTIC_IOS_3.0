//
//  RegisterViewModel.swift
//  clients-ios
//
//  Created by Jhona on 7/25/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
struct RegisterDocumentTitles {
    
    var screenTitle: String = "ÚNASE A NUESTRA GRAN FAMILIA"
    var docTypeTitle: String = "Elige su tipo de documento"
    var docTypePlaceholder: String = "Tipo de documento"
    var docNumberTitle: String = "Ingrese el No. de documento"
    var docNumberPlaceholder: String = "Número de documento"
    var nextButtonTitle: String = "Continuar"
    
}

class PickerData {
    var pickerData: [String] = ["DNI", "Pasaporte", "Carnet de Extranjeria"]
}

protocol RegisterDocumentViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapDocType()
    func tapNext(dni:String)
    
    // Outputs
    
    var showTitles: ((RegisterDocumentTitles) -> Void)? { get set }
    var loadPickerData: ((PickerData) -> Void)? { get set }
    var pushRegisterPassword: ((String) -> Void)? { get set }
    var showToast:((String)->Void)?{get set}
}

class RegisterViewModel: RegisterDocumentViewModelProtocol {
    var showToast: ((String) -> Void)?
    var loadPickerData: ((PickerData) -> Void)?
    var showTitles: ((RegisterDocumentTitles) -> Void)?
    var pushRegisterPassword: ((String) -> Void)?
    
    func viewDidLoad() {
        let titles = RegisterDocumentTitles()
        showTitles?(titles)
    }

    func tapDocType() {
        let datasource = PickerData()
        loadPickerData?(datasource)
    }
    
    func tapNext(dni:String) {
        if(dni == ""){
            
        }else{
            
            var dominioUrl = URL(string: Constants().urlBase+Constants().postValidarDni)
            dominioUrl = dominioUrl?.appending("dni", value: dni)
            let url = dominioUrl!.absoluteString
            
            AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
            switch response.result{
                
            case.success(let value):
                         let json = JSON(value)
                         let resultado = json["resultado"].stringValue
                         let response = json["response"].stringValue
                         if(resultado == "200"){
                            
                            self.pushRegisterPassword?(dni)
                           
                         }else {
                            if(resultado == "400"){
                                self.showToast?(response)
                            }else{
                               self.showToast?(response)
                            }
                            //en otros casos
                            
                         }

                         
                        break
                    case.failure(let error):
                       self.showToast?("Error: revise su conexión e intentelo nuevamente")
                        print(error)
                        break
                    }
                    
                }
            
            
        }
        
        
        
        
        
    }
 
}
