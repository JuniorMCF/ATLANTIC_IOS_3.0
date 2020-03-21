//
//  AtlanticDerby5ViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol AtlanticDerby5ViewModelProtocol{
    //funciones de entrada
    func viewDidLoad()
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String)
    //variables de salida
    var loadDataSources:(([String])->Void)?{get set}
    var presentTitles:(([String])->Void)?{get set}
    
}
class AtlanticDerby5ViewModel : AtlanticDerby5ViewModelProtocol{
    var loadDataSources: (([String]) -> Void)?
    var presentTitles: (([String]) -> Void)?
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
    
    func viewDidLoad(){
        let list = ["ic_coup_1","ic_coup_2","ic_coup_3"]
        loadDataSources?(list)
        presentTitles?(list)
    }
}
