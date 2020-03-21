//
//  TrophyCategoryViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
public struct TrophyCategory {
    
    var title: String
    var nameImage: String
    
}

class TrophyCategoryDatasource {
    
    var items: [TrophyCategory] = [
        TrophyCategory(title: "Nivel 1 y 2", nameImage: "img-trophy"),
        TrophyCategory(title: "Nivel 3 y 4", nameImage: "img-trophy"),
        TrophyCategory(title: "Nivel 5 a +", nameImage: "img-trophy")
    ]
}

protocol TrophyCategoryViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad(tipo:String,clienteId:String)
    func didSelectTrophyCategory(_ indexPath: Tournament)
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String)
    // Mark: - Outputs (Closures)

    var loadDatasources: (([Tournament]) -> Void)? { get set }
    var presentTrophyCategory: ((Tournament) -> Void)? { get set }
}

class TrophyCategoryViewModel: TrophyCategoryViewModelProtocol {

    var loadDatasources: (([Tournament]) -> Void)?
    var presentTrophyCategory: ((Tournament) -> Void)?
    var progress = CustomProgress()
    var datasources = [Tournament]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String) {
        var dominioUrl = URL(string: Constants().urlBase+Constants().postAgregarActividadPromocion)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        dominioUrl = dominioUrl?.appending("fechaIngreso", value: fechaIngreso)
        dominioUrl = dominioUrl?.appending("nombrePromocion", value: nombrePromocion)
        dominioUrl = dominioUrl?.appending("promocionId", value: promocionId)
        
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
    
    
    
    
    
    
    func viewDidLoad(tipo:String,clienteId:String) {
        progress = appDelegate.progressDialog!
        progress.showProgress()
        let parameters = ["tipo":tipo,"id":clienteId]
         
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
                                    self.datasources.append(torneo)
                                 }
                                self.progress.hideProgress()
                                 self.loadDatasources?(self.datasources)
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
    
    func didSelectTrophyCategory(_ indexPath: Tournament) {
       let type = indexPath
        presentTrophyCategory?(type)
    }    

}

enum TrophyCategoryTypes: Int {
    
    case nivel12 = 0
    case nivel34 = 1
    case nivel5 = 2
    
}
