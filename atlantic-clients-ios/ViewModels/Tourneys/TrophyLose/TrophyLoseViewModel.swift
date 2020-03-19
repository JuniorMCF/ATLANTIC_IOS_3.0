//
//  TrophyLoseViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/27/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol TrophyLoseViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad(promocionId:String)
    func didSelectTrophyCategory(_ indexPath: IndexPath)
    
    // Mark: - Outputs (Closures)

    var loadDatasources: (([TournamentTable]) -> Void)? { get set }
    var presentTrophyCategory: ((TrophyCategoryTypes) -> Void)? { get set }
}

class TrophyLoseViewModel: TrophyLoseViewModelProtocol {

    var loadDatasources: (([TournamentTable]) -> Void)?
    var presentTrophyCategory: ((TrophyCategoryTypes) -> Void)?
    var tournamentTableList = [TournamentTable]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress = CustomProgress()
    func viewDidLoad(promocionId:String) {
        progress = appDelegate.progressDialog
        progress.showProgress()
        let parameters = ["promocionId":promocionId]
        
        AF.request(Constants().urlBase+Constants().getTorneosTabla,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                        let torneo = TournamentTable()
                                        let value = JSON(data)
                                        torneo.nombre = value["nombre"].stringValue
                                        torneo.posicion = value["posicion"].intValue
                                        torneo.premio = value["premio"].intValue
                                        torneo.puntaje = value["puntaje"].intValue
                                        torneo.promoId = value["promo_id"].intValue
                                        self.tournamentTableList.append(torneo)
                                        
                                    }
                                    self.progress.hideProgress()
                                    self.loadDatasources?(self.tournamentTableList)
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
    
    func didSelectTrophyCategory(_ indexPath: IndexPath) {
       
    }

}
