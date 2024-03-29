import Foundation
import Alamofire
import SwiftyJSON

protocol ProfileAgendaViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    
    // Outputs
    var reloadTabs: ((EventDetailPreview) -> Void)? { get set}
    func searchBarTextDidChange(_ searchText: String)
    var showTitles: ((EventDetailPreview) -> Void)? { get set }
    var loadDatasources: (([Cobros]) -> Void)?{get set}
}

class ProfileAgendaViewModel: ProfileAgendaViewModelProtocol {


    var showTitles: ((EventDetailPreview) -> Void)?
    var loadDatasources: (([Cobros]) -> Void)?
    var reloadTabs : ((EventDetailPreview) -> Void)?
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var eventList = [Event]()
    var eventHashMap : [String: [Event]] = ["":[Event]()]
    var tipoList : [String] = []
    
    
    /**
    Obtiene los eventos registrados en la agenda y los muestra en pantalla
    */
    
    func viewDidLoad() {
        
        appDelegate.progressDialog.showProgress()
        
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
                                self.appDelegate.eventDetailPreview = eventDetailPreview
                     
                            //enviar data
                               self.showTitles?(eventDetailPreview)
                             }else {
                                //en otros casos
                                let eventDetailPreview = EventDetailPreview()
                                self.appDelegate.eventDetailPreview = eventDetailPreview
                                //enviar data
                                self.showTitles?(eventDetailPreview)
                             }
                            self.appDelegate.progressDialog.hideProgress()
                           
                             
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
        
        //showTitles?(titles)
    }

    /**
    Busca entre todos los eventos de la agenda por palabra clave
     - Parameters:
        - searchText: palabra clave
     */
    func searchBarTextDidChange(_ searchText: String) {
        if searchText.isEmpty {
            let datasources = appDelegate.eventDetailPreview
            reloadTabs?(datasources)
            
        } else {
            let datasources = appDelegate.eventDetailPreview
            let eventDetail = EventDetailPreview()
            var eventList = [[Event]]()
            var tipo = [String]()
            for event in datasources.list{
                let filteredDatasource = event.filter { $0.nombreCorto.lowercased().contains(searchText.lowercased()) }
                eventList.append(filteredDatasource)
                
            }
            eventDetail.list = eventList
            eventDetail.tipoList = datasources.tipoList
            reloadTabs?(eventDetail)
            //showTitles?(eventDetail)
        }
    }
}
