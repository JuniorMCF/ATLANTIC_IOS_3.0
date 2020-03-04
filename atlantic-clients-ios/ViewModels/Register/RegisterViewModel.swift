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
    var pushRegisterPassword: (() -> Void)? { get set }
}

class RegisterViewModel: RegisterDocumentViewModelProtocol {
    
    var loadPickerData: ((PickerData) -> Void)?
    var showTitles: ((RegisterDocumentTitles) -> Void)?
    var pushRegisterPassword: (() -> Void)?
    
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
            let parameters = ["dni":dni]
            let dominio = Constants().urlBase+Constants().postValidarDni
           
            AF.request(dominio,method: .post,parameters: parameters,encoding: JSONEncoding.default,headers:nil).responseJSON{(response) in
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
                                    //enviar data
                                   
                                 }else {
                                    //en otros casos
                            
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
            
            
        }
        
        
        
        
        pushRegisterPassword?()
    }
 
}
