import Foundation
import Alamofire
import SwiftyJSON
public struct Tourney {
    
    var nameImage: String
    
}

class TourneyDatasources {
    
    var items: [Tourney] = [
        Tourney(nameImage: "img-torneo1"),
        Tourney(nameImage: "img-torneo2"),
        Tourney(nameImage: "img-torneo3")
    ]
}

protocol TourneyViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didSelectTourney(tipo:String,isList:Bool)
    func didSelectGranPrix(tipo:String,id:String)
    // Mark: - Outputs (Closures)
    
    var loadDatasources: (([TournamentDetails]) -> Void)? { get set }
    var presentTourneyCategory: ((String,Bool) -> Void)? { get set }
    var presentGranPrixDetail: (([Tournament])->Void)? {get set}
}

class TourneyViewModel: TourneyViewModelProtocol {
    var presentGranPrixDetail: (([Tournament]) -> Void)?
    var loadDatasources: (([TournamentDetails]) -> Void)?
    var presentTourneyCategory: ((String,Bool) -> Void)?
    
    var datasources = [TournamentDetails]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var torneoList = [Tournament]()
    var torneoList2 = [Tournament]()
    var torneoHashMap : [String: [Tournament]] = [:] 
    var progress : CustomProgress!
    
    
    /**
     Obtiene la informacion de todos los torneos
     */
    func viewDidLoad() {
        let parameters = ["id":appDelegate.usuario.clienteId]
        progress = appDelegate.progressDialog
        progress.showProgress()
        AF.request(Constants().urlBase+Constants().getTorneos,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
            switch response.result{
                
            case.success(let value):
                         let json = JSON(value)
                         print(json)
                         let data = json.stringValue.data(using: .utf8)
                         do {
                             // make sure this JSON is in the format we expect
                            if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                                 // try to read out a string array
                                let resultado = json["resultado"] as! String
                                
                                if(resultado == "200"){
                                    
                                    let response = json["response"] as! NSArray
                                    
                                    for data in response{
                                        let torneo = Tournament()
                                        let value = JSON(data)
                                        torneo.cliente_id = value["cliente_id"].stringValue
                                        torneo.concluido = value["concluido"].boolValue
                                        torneo.fechaActualizacion = value["fecha_actualizacion"].stringValue
                                        torneo.fechaProxima = value["fecha_proxima"].stringValue
                                        torneo.fechaProximaTexto = value["fecha_proxima_texto"].stringValue
                                        torneo.fechaTexto = value["fecha_texto"].stringValue
                                        torneo.logo = value["logo"].stringValue
                                        torneo.nombre = value["nombre"].stringValue
                                        torneo.pomocion_id = value["pomocion_id"].intValue
                                        torneo.posicion = value["posicion"].intValue
                                        torneo.premio = value["premio"].doubleValue
                                        torneo.puntaje = value["puntaje"].intValue
                                        torneo.tipo = value["tipo"].stringValue
                                        self.torneoList.append(torneo)
                                        
                                    }

                                    for tournamentItem in self.torneoList {
                                        print(tournamentItem.tipo)
                                        if(self.torneoHashMap[tournamentItem.tipo]?.isEmpty == true || self.torneoHashMap[tournamentItem.tipo] == nil){
                                            self.torneoHashMap[tournamentItem.tipo] = [tournamentItem]
                                            print("aca",self.torneoHashMap[tournamentItem.tipo]![0].logo)
                                        }
                                        else{
                                          if(self.torneoHashMap[tournamentItem.tipo] != nil){
                                            var list = self.torneoHashMap[tournamentItem.tipo]! as [Tournament]
                                              list.append(tournamentItem)
                                              //print(list.count)
                                              self.torneoHashMap[tournamentItem.tipo]! = list
                                              //print(self.torneoHashMap[tournamentItem.tipo]![0].logo)
                                          }
                                        }

                                    }
                                    var isList = false
                                    for key in self.torneoHashMap.keys{
                                        print(key)
                                       
                                    }
                                    for key in self.torneoHashMap.keys{
                                        var indexList : [String] = []
                                        for data in (self.torneoHashMap[key])!{
                                            indexList.append(String(data.pomocion_id))

                                        }
                                        print("key",key)
                                        isList = self.torneoHashMap[key]!.count > 1
                                        let torneoDetails = TournamentDetails()
                                        torneoDetails.isList = isList
                                        torneoDetails.logo = self.torneoHashMap[key]![0].logo
                                        torneoDetails.tipo = self.torneoHashMap[key]![0].tipo
                                        self.datasources.append(torneoDetails)
                                    }
                                    
                                    
                                    self.loadDatasources?(self.datasources)
                                     self.progress.hideProgress()
                                 }else {
                                    //en otros casos
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
    
    /**
    Obtiene la categoria del torneo
    - Parameters:
        - tipo: tipo de torneo
        - isList : verifica si es una lista de torneos
     */
    func didSelectTourney(tipo:String,isList:Bool) {
        presentTourneyCategory?(tipo,isList)
    }
    
    /**
    Obtiene los torneos de grandprix
    - Parameters:
     - tipo: tipo de torneo
     - id : id de cliente
    */
    func didSelectGranPrix(tipo:String,id:String){
        let parameters = ["tipo":tipo,"id":id]
        
        progress = appDelegate.progressDialog
	        progress.showProgress()
        AF.request(Constants().urlBase+Constants().getTorneosTipo,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
            switch response.result{
                
            case.success(let value):
                         let json = JSON(value)
                         print(json)
                         let data = json.stringValue.data(using: .utf8)
                         do {
                             // make sure this JSON is in the format we expect
                            if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                                 // try to read out a string array
                                let resultado = json["resultado"] as! String
                                
                                if(resultado == "200"){
                                    
                                    let response = json["response"] as! NSArray
                                    
                                    for data in response{
                                        let torneo = Tournament()
                                        let value = JSON(data)
                                        torneo.cliente_id = value["cliente_id"].stringValue
                                        torneo.concluido = value["concluido"].boolValue
                                        torneo.fechaActualizacion = value["fecha_actualizacion"].stringValue
                                        torneo.fechaProxima = value["fecha_proxima"].stringValue
                                        torneo.fechaProximaTexto = value["fecha_proxima_texto"].stringValue
                                        torneo.fechaTexto = value["fecha_texto"].stringValue
                                        torneo.logo = value["logo"].stringValue
                                        torneo.nombre = value["nombre"].stringValue
                                        torneo.pomocion_id = value["pomocion_id"].intValue
                                        torneo.posicion = value["posicion"].intValue
                                        torneo.premio = value["premio"].doubleValue
                                        torneo.puntaje = value["puntaje"].intValue
                                        torneo.tipo = value["tipo"].stringValue
                                        self.torneoList2.append(torneo)
                                        
                                    }
                                    self.progress.hideProgress()
                                    self.presentGranPrixDetail?(self.torneoList2)

                                 }else {
                                     self.progress.hideProgress()
                                    //en otros casos
                                    
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
}
/**
Retorna la categoria de los torneos
 */

enum TourneyCategoryTypes: Int {
    
    case atlanticDerby = 0
    case grandPrix = 1
    case torneoDomingo = 2
    
}
