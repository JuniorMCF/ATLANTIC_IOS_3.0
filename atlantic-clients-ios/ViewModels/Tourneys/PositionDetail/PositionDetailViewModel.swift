//
//  PositionDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/10/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct PositionDetailTitles {
    
    var positionTitle: String = "Usted está en el:"
    var position: String = "1er"
    var postTitle: String = "puesto en el ranking"
    var winTitle: String = "Ha ganado"
    var win: String = "$ 1000"
    var payTittle: String = "IR A MIS COBROS"
    
}

protocol PositionDetailViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapPayments()
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String)
    // Mark: - Outputs (Closures)
    
    var showTitles: ((PositionDetailTitles) -> Void)? { get set }
    var presentPayments: (() -> Void)? { get set }
    
}

class PositionDetailViewModel: PositionDetailViewModelProtocol {
    
    var showTitles: ((PositionDetailTitles) -> Void)?
    var presentPayments: (() -> Void)?
    
    /**
       agrega una promocion al cliente
    - Parameters:
       - clienteId: id del cliente
            - fechaIngreso: fecha de ingreso a la promocion
            - nombrePromocion: nombre de la promocion
            - promocionId: id de la promocion
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
    func viewDidLoad() {
        let titles = PositionDetailTitles()
        showTitles?(titles)
        
    }
    
    /**
     presenta los pagos
     */
    func tapPayments() {
        presentPayments?()
    }
    

    
}
