//
//  PaymentViewModel.swift
//  clients-ios
//
//  Created by Jhona on 7/31/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
public struct Payment {
    
    var title: String
    var amount: String
    var state: String
    var nameImage: String
    
    init(title: String, amount: String, state:String, nameImage: String) {
        self.title = title
        self.amount = amount
        self.state = state
        self.nameImage = nameImage
    }
    
}

class PaymentsDatasources {

    var items: [Payment] = [
        Payment(title: "Atlantic Derby", amount: "3º Puesto - $20 Dolares", state: "Por cobrar", nameImage: "derby"),
        Payment(title: "Top 100", amount: "Tiene $20 Dolares por cobrar", state: "Por cobrar", nameImage: "top"),
        Payment(title: "Grand Prix", amount: "Tiene $20 Dolares por cobrar", state: "Por cobrar", nameImage: "grandprix"),
        Payment(title: "Torneos de Domingo", amount: "Tiene $20 Dolares por cobrar", state: "Por cobrar", nameImage: "torneos")]

}

protocol PaymentsViewModelProtocol {

    // Mark: - Inputs
    
    func viewDidLoad()
    func searchBarTextDidChange(_ searchText: String)
    
    // Mark: - Outputs (Closures)

    var loadDatasources: (([Cobros]) -> Void)? { get set }
    var reloadDatasource: (([Cobros]) -> Void)? { get set }
}

class PaymentsViewModel: PaymentsViewModelProtocol {
    var reloadDatasource: (([Cobros]) -> Void)?
    var loadDatasources: (([Cobros]) -> Void)?
    
    var datasources = [Cobros]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress : CustomProgress!
    
    func viewDidLoad() {
        let parameters = ["id": appDelegate.usuario.clienteId]
        progress = appDelegate.progressDialog
        
        progress.showProgress()
        AF.request(Constants().urlBase+Constants().getCobros,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                
                                for data in response{
                                    let cobro = Cobros()
                                    let value = JSON(data)
                                    cobro.estado = value["estado"].stringValue
                                    cobro.id = value["id"].stringValue
                                    cobro.logoUrl = value["logo"].stringValue
                                    cobro.nombre = value["nombre"].stringValue
                                    cobro.premio = value["premio"].stringValue
                                    cobro.puesto = value["puesto"].stringValue
                                    cobro.puntos = value["puntos"].stringValue
                                    cobro.tipoMoneda = value["tipoMoneda"].stringValue
                                    self.datasources.append(cobro)
                                }
                                self.appDelegate.cobros = self.datasources
                                self.loadDatasources?(self.datasources)
                             }else {
                                //en otros casos
                                
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
        
        
        //loadDatasources?(datasources)
    }
    
    func searchBarTextDidChange(_ searchText: String) {
        if searchText.isEmpty {
            let datasources = appDelegate.cobros
            loadDatasources?(datasources)
        } else {
            var datasources = appDelegate.cobros
            let filteredDatasource = datasources.filter { $0.nombre.contains(searchText) }
            datasources = filteredDatasource
            reloadDatasource?(datasources)
        }
    }
    
}


