//
//  AtlanticDerby2ViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/21/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
protocol AtlanticDerby2ViewModelProtocol{
    //funciones de entrada
     func viewDidLoad()
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String)
    //variables de salida
    var loadDataSources:(([Puestos])->Void)?{get set}
    var presentTitles:(([String])->Void)?{get set}
    
}
class AtlanticDerby2ViewModel : AtlanticDerby2ViewModelProtocol{
    var loadDataSources: (([Puestos]) -> Void)?
    var presentTitles: (([String]) -> Void)?
    
    /**
       agrega una promocion del derby
     - Parameters:
               -clienteId: id del cliente
               -fechaIngreso: fecha que se ejecuta la promocion
               -nombrePromocion: nombre de la promocion
               -promocionId: id de la promocion
     */
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
    
    /**
     prepara la vista del derby
     */
    func viewDidLoad(){
        let list = ["ic_coup_1","ic_coup_2","ic_coup_3"]
        let puesto = Puestos()
        var puestos = [Puestos]()
        puesto.foto = "ic_coup_1"
        puesto.puesto = "1er Puesto"
        puestos.append(puesto)
        let puesto2 = Puestos()
        puesto2.foto = "ic_coup_2"
        puesto2.puesto = "2do Puesto"
        puestos.append(puesto2)
        let puesto3 = Puestos()
        puesto3.foto = "ic_coup_3"
        puesto3.puesto = "3er Puesto"
        puestos.append(puesto3)

        loadDataSources?(puestos)
        presentTitles?(list)
    }
}
