//
//  EventsViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/3/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
protocol EventsViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapExpand()
    func tapRegister()
    
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((EventDetailPreview) -> Void)? { get set}
    var loadDatasources: ((BannerDatasources) -> Void)? { get set }
    var expandView: (() -> Void)? { get set }
    var presentRegister: (() -> Void)? { get set }
}

class EventsViewModel: EventsViewModelProtocol {
    
    var showTitles: ((EventDetailPreview) -> Void)?
    var loadDatasources: ((BannerDatasources) -> Void)?
    var expandView: (() -> Void)?
    var presentRegister: (() -> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventList = [Event]()
    var tipoList = [String]()
    var eventHashMap : [String: [Event]] = ["":[Event]()]
    var progress : CustomProgress!
    
    /**
     obtiene la lista de eventos
     */
    func viewDidLoad() {
        progress = appDelegate.progressDialog
        let parameters = ["id":appDelegate.usuario.clienteId,"nivelId":appDelegate.usuario.nivel]
        progress.showProgress()
        
        AF.request(Constants().urlBase+Constants().getEventoDetails,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                    let tipo1 = JSON(tipo["tipo"])
                                    self.tipoList.append(tipo1[0]["nombreTipo"].stringValue)
                                    self.eventList.removeAll()
                                    for data in tipo1.arrayValue
                                    {
                                        let event = Event()
                                        let value = JSON(data)
                                        event.id = value["id"].intValue
                                        event.eventoId = value["evento_id"].intValue
                                        event.clienteId = value["cliente_id"].intValue
                                        event.descripcion = value["descripcion"].stringValue
                                        event.esPrincipal = value["es_principal"].boolValue
                                        event.fecha = value["fecha"].stringValue
                                        let listaFotos = value["fotos"].arrayValue
                                        for foto in listaFotos{
                                            let val = JSON(foto)
                                            let foto = FotoEvent()
                                            foto.esPrincipal = val["es_principal"].boolValue
                                            foto.foto = val["foto"].stringValue
                                            event.fotos.append(foto)
                                        }
                                        event.nAcompanantes = value["nAcompanantes"].stringValue
                                        event.nombre = value["nombre"].stringValue
                                        event.nombreCorto = value["nombre_corto"].stringValue
                                        event.nombreTipo = value["nombreTipo"].stringValue
                                        event.show = value["show"].stringValue
                                        event.tituloShow = value["titulo_show"].stringValue
                                        event.video = value["video"].stringValue
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
                             
                            self.progress.hideProgress()
                             
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
        
        
        let datasources = BannerDatasources()
        loadDatasources?(datasources)
    }
    
    /**
     muestra la lista de eventos
     */
    func tapExpand() {
        expandView?()
    }
    
    /**
     registrar el recordatorio del evento
     */
    func tapRegister() {
        presentRegister?()
    }

}
