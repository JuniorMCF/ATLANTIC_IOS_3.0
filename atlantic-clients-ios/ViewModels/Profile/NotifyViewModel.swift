//
//  AgendaViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/26/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol NotifyViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    
    // Outputs
    
    var showTitles: (([Notify]) -> Void)? { get set }
    var loadDatasources : (([Notify])-> Void)?{get set}
}

class NotifyViewModel: NotifyViewModelProtocol {
    
    var showTitles: (([Notify]) -> Void)?
    var loadDatasources : (([Notify])-> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var datasourcce = [Notify]()
    func viewDidLoad() {
        let titles = [Notify]()
        showTitles?(titles)
        
        let parameters = ["clienteId":appDelegate.usuario.clienteId]
         
        AF.request(Constants().urlBase+Constants().getGetNotify,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                     let notify = Notify()
                                     let value = JSON(data)
                                     notify.fecha = value["fecha"].stringValue
                                     notify.id = value["id"].stringValue
                                     notify.mensaje = value["mensaje"].stringValue
                                     self.datasourcce.append(notify)
                                 }
                                 
                                 self.loadDatasources?(self.datasourcce)
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
        
        
        
        loadDatasources?(titles)
    }
    
}
