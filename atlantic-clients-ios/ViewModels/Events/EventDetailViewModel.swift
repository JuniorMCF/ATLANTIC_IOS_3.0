//
//  EventDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct EventDetailTitles {
    
    var title: String = "FESTIVAL BRASAS"
    var date: String = "LUNES 28 DE MARZO"
    var images: [String] = ["img-brasa-1","img-brasa-2","img-brasa-3"]
    var hours: String = "Horarios"
    var hour1: String = "7:00 PM"
    var hour2: String = "8:00 PM"
    var hour3: String = "9:00 PM"
    
    
    var buffetTitle: String = "Buffet"
    var soupsTitle: String = "Sopas"
    var soups1Title: String = "Sopas De Camarones"
    var entryTitle: String = "Entradas"
    var entry1Title: String = "Entrada Nicoise"
    var entry2Title: String = "Entrada Rusa"
    var entry3Title: String = "Entrada Waldorf"
    
    var fundTitle: String = "Fondos"
    var fund1Title: String = "Lasaña Boloñesa"
    var fund2Title: String = "Espaguetis Al Alfredo"
    var fund3Title: String = "Macarrones con queso"
    
    var dessertTitle: String = "Postres"
    var dessert1Title: String = "Lasaña Boloñesa"
    var dessert2Title: String = "Espaguetis Al Alfredo"
    var dessert3Title: String = "Macarrones con queso"
    
    var showTitle: String = "Show"
    var showNameTitle: String = "Perú en Brasas"
    var assistant: String = "Acompañantes"
    var video: String = "vid-brasas"
    var registerTitle: String = "REGISTRARSE"
    
}

class BannerDatasources {
    
    var images: [String] = ["img-brasa-1", "img-brasa-2", "img-brasa-3"]
    
}

protocol EventDetailViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad(eventoId:Int)
    func tapExpand()
    func tapRegister()
    func onStart(clienteId: String,fechaIngreso : String,nombreEvento :String,eventoId: String) 
    func saveData(clienteId:String,horarioId:String,nroAcom:String)
    func setHorario(horarioId:String)
    // Mark: - Outputs (Closures)
    
    var showTitles: ((EventDetailTitles) -> Void)? { get set}
    var loadDatasources: (([Horario]) -> Void)? { get set }
    var expandView: (() -> Void)? { get set }
    var loadBuffets : (([[String]]) -> Void)? { get set}
    var saveData: (() -> Void)? { get set }
    var getHorarioId: ((String)->Void)? {get set}
    var showToast: ((String)->Void)? {get set}
    var hideViews: (()->Void)?{get set}
}

class EventDetailViewModel: EventDetailViewModelProtocol {
    var showToast: ((String) -> Void)?
    var getHorarioId: ((String)->Void)?
    var hideViews: (()->Void)?
    var showTitles: ((EventDetailTitles) -> Void)?

    var loadDatasources: (([Horario]) -> Void)?
    
    var expandView: (() -> Void)?
    var saveData: (() -> Void)?
    var loadBuffets : (([[String]]) -> Void)?
    var listHorarios = [Horario]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress = CustomProgress()
    func setHorario(horarioId: String) {
        getHorarioId?(horarioId)
    }
    
    func saveData(clienteId:String,horarioId:String,nroAcom:String){
        progress = appDelegate.progressDialog
        progress.showProgress()
        var dominioUrl = URL(string: Constants().urlBase+Constants().postGuardarEvento)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        dominioUrl = dominioUrl?.appending("horarioId", value: horarioId)
        dominioUrl = dominioUrl?.appending("nroAcom", value: nroAcom)
        
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                self.showToast?("Registrado correctamente")
                                self.hideViews?()
                                self.progress.hideProgress()
                             }else {
                                self.showToast?("Ya se encuentra registrado")
                                self.progress.hideProgress()
                             }
                             
                         }
                     } catch let error as NSError {
                        self.progress.hideProgress()
                         print("Failed to load: \(error.localizedDescription)")
                     }
                     
                     
                    break
                case.failure(let error):
                   self.progress.hideProgress()
                    print(error)
                    break
                }
                
            }
    }
    
    
    func onStart(clienteId: String,fechaIngreso : String,nombreEvento :String,eventoId: String) {
        var dominioUrl = URL(string: Constants().urlBase+Constants().postAgregarActividadEvento)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        dominioUrl = dominioUrl?.appending("fechaIngreso", value: fechaIngreso)
        dominioUrl = dominioUrl?.appending("nombreEvento", value: nombreEvento)
        dominioUrl = dominioUrl?.appending("eventoId", value: eventoId)
        
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print("statistics",json)
                     
                     //self.presentToast?("datos actualizados correctamente")

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
    }
    
    
    
    func viewDidLoad(eventoId:Int) {
        let titles = EventDetailTitles()
        showTitles?(titles)
        let parameters = ["eventoId": eventoId,"clienteId": appDelegate.usuario.clienteId] as [String : Any]
        print("parameters",parameters)
        AF.request(Constants().urlBase+Constants().getEventoHorario,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print("horario",json)
                     let data = json.stringValue.data(using: .utf8)
                     do {
                         // make sure this JSON is in the format we expect
                         if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                             // try to read out a string array
                            let resultado = json["resultado"] as! String
                            
                            if(resultado == "200"){
                                
                                let response = json["response"] as! NSArray
                                let array = JSON(response)
                                
                                for tipo in array.arrayValue {
                                    let horario = Horario()
                                    horario.fecha = tipo["fecha"].stringValue
                                    horario.id = tipo["id"].intValue
                                    horario.registrado = tipo["registrado"].boolValue
                                    self.listHorarios.append(horario)
                                }
                                self.loadDatasources?(self.listHorarios)
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
   
        
        AF.request(Constants().urlBase+Constants().getBuffet,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     let data = json.stringValue.data(using: .utf8)
                     var buffetList = [[String]]()
                     do {
                         // make sure this JSON is in the format we expect
                         if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                             // try to read out a string array
                            let resultado = json["resultado"] as! String
                            if(resultado == "200"){
                                
                                let response = json["response"] as! NSArray
                                let array = JSON(response)
                                for tipoList in array.arrayValue {
                                    var i = 0
                                    var buffet = [String]()
                                    for tipo in tipoList{
                                        if(i == 0){
                                            buffet.append(tipo.1["tipo"].stringValue)
                                        }
                                        buffet.append(tipo.1["nombre"].stringValue)
                                        i += 1
                                    }
                                    buffetList.append(buffet)
                                }
                                self.loadBuffets?(buffetList)
                             }else {
                                
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
    
    
    
    
    func tapExpand() {
        expandView?()
    }
    
    func tapRegister() {
        saveData?()
    }

}
