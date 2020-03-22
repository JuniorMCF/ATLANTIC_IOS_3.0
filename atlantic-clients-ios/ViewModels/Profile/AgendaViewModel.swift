//
//  AgendaViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/10/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol AgendaViewModelProtocol {
    
    // Inputs
    func viewDidLoad()
    func deleteData(eventoRegistroId:String,clienteId:String)
    func didEventSelected(event:Event)
    func reloadData(data:[Event])
    // Outputs
    
    var showTitles: ((ProfileTitles) -> Void)? { get set }
    var presentEventDetail:((Event)->Void)? {get set}
    var loadDatasources: ((BreakfastDatasources) -> Void)?{get set}
    var presentToast: ((String)->Void)?{get set}
    var presentReloadData:(([Event])->Void)?{get set}
}

class AgendaViewModel: AgendaViewModelProtocol {
    var showTitles: ((ProfileTitles) -> Void)?
    var presentEventDetail:((Event)->Void)?
    var loadDatasources: ((BreakfastDatasources) -> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress :CustomProgress!
    var presentReloadData:(([Event])->Void)?
    func reloadData(data:[Event]) {
        presentReloadData?(data)
    }
    
    var presentToast: ((String)->Void)?
    
    func deleteData(eventoRegistroId: String, clienteId: String) {
        var dominioUrl = URL(string: Constants().urlBase+Constants().postEliminarAgendado)
        dominioUrl = dominioUrl?.appending("eventoRegistroId", value: eventoRegistroId)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print("datos",json)
                     self.presentToast?("datos actualizados correctamente")

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
    }
    
    
   
    func viewDidLoad() {
        let datasources = BreakfastDatasources()
        
        loadDatasources?(datasources)
        
    }
  
    func didEventSelected(event:Event){
        presentEventDetail?(event)
    }
    
}
