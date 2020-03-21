//
//  AllBenefitsViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/14/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
struct AllBenefitsTitles {
    
    var dateSwapTitle: String = "Fecha de canje"
    var dateSwap: String = "21 de noviembre"
    var reminderTitle = "Crear Recordatorio"
    var pointsTitle: String = "Hasta este momento usted"
    var points: String = "4900 PUNTOS"
    var awardSubTitle: String = "Ha ganado $40 dólares"
    var lackTitle: String = "Le faltan:"
    var lackPoints: String = "3100 PUNTOS"
    var lackAward: String = "Para ganar $60 dólares"
    var ticketTitle = "SOLICITE SU TICKET DE CANJE"
    
}

protocol AllBenefitsViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func onStart(clienteId: String,fechaIngreso : String,nombrePromocion :String,promocionId:String)
    // Mark: - Outputs (Closures)
    
    var showTitles: ((AllBenefitsTitles) -> Void)? { get set }
}

class AllBenefitsViewModel: AllBenefitsViewModelProtocol {
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
    
    
    var showTitles: ((AllBenefitsTitles) -> Void)?
    
    func viewDidLoad() {
        let titles = AllBenefitsTitles()
        showTitles?(titles)
    }
}
