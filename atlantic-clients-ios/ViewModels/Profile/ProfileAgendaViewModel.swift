//
//  ProfileAgendaViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ProfileAgendaViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapProfile()
    func tapSettings()
    func tapLogOut()
    func pushNotify()
    // Outputs
    
    var showTitles: ((EventDetailPreview) -> Void)? { get set }
    var pushProfileDetail: (() -> Void)? { get set }
    var pushSettings: (() -> Void)? { get set }
    var presentLogin: (() -> Void)? { get set }
    var presentNotify: (()->Void)?{get set}
}

class ProfileAgendaViewModel: ProfileAgendaViewModelProtocol {
    
    var showTitles: ((EventDetailPreview) -> Void)?
    var pushProfileDetail: (() -> Void)?
    var pushSettings: (() -> Void)?
    var presentLogin: (() -> Void)?
    var presentNotify: (()->Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventList = [Event]()
    var eventHashMap : [String: [Event]] = ["":[Event]()]
    var tipoList : [String] = []
    func viewDidLoad() {
        let titles = EventDetailPreview()
        let parameters = ["clienteId":appDelegate.usuario.clienteId]
        
        AF.request(Constants().urlBase+Constants().getAgenda,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                var list = [[Event]]()
                                let array = JSON(response)
                                
                                for tipo in array.arrayValue {
                                    let evento = JSON(tipo["evento"])
                                    
                                    self.eventList.removeAll()
                                    for data in evento.arrayValue
                                    {
                                        let event = Event()
                                        let value = JSON(data)
                                        event.eventoId = value["evento_id"].intValue
                                        event.id = value["id"].intValue
                                        event.clienteId = value["cliente_id"].intValue
                                        event.descripcion = value["descripcion"].stringValue
                                        event.esPrincipal = value["es_principal"].boolValue
                                        event.fecha = value["fecha"].stringValue
                                        let fotos = value["fotos"].arrayValue
                                        for data in fotos{
                                            let val = JSON(data)
                                            let foto = FotoEvent()
                                            foto.foto = val["foto"].stringValue
                                            foto.esPrincipal = val["es_principal"].boolValue
                                            event.fotos.append(foto)
                                        }
                                        event.nAcompanantes = value["nroAcompañantes"].stringValue
                                        event.nombre = value["nombre"].stringValue
                                        event.descripcion = value["descripcion"].stringValue
                                        event.nombreCorto = value["nombre_corto"].stringValue
                                        event.nombreTipo = value["nombreTipo"].stringValue
                                        event.show = value["show"].stringValue
                                        event.tituloShow = value["titulo_show"].stringValue
                                        event.video = value["video"].stringValue
                                        event.agendaId = value["agendaId"].intValue
                                        event.horarioId = value["horarioId"].intValue
                                        self.tipoList.append(event.nombreTipo)
                                        self.eventList.append(event)
                                        
                                    }
                                    list.append(self.eventList)
                                    
                                }
                                let eventDetailPreview = EventDetailPreview()
                                
                                eventDetailPreview.list = list
                                eventDetailPreview.tipoList = self.tipoList
                                
                     
                            //enviar data
                               self.showTitles?(eventDetailPreview)
                             }else {
                                //en otros casos
                                let eventDetailPreview = EventDetailPreview()
                                //enviar data
                                self.showTitles?(eventDetailPreview)
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
        
        showTitles?(titles)
    }
    
    func tapProfile() {
        pushProfileDetail?()
    }
    
    func tapSettings() {
        pushSettings?()
    }
    
    func tapLogOut() {
        presentLogin?()
    }
    func pushNotify(){
        presentNotify?()
    }
}
