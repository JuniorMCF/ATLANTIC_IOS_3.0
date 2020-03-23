//
//  OnBoardingViewModel.swift
//  clients-ios
//
//  Created by Jhona on 7/20/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

struct OnBoardingTitles {
    var skitTitle: String = "Omitir"
    var nextTitle: String = "Siguiente"
    
}

protocol OnBoardingViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapNext()
    
    // Outputs (Clousures)
    
    var showTitles: ((OnBoardingTitles) -> Void)? { get set }
    var presentImages:(([Route])-> Void)?{get set}
    var presentFotos: (([String],String) -> Void)?{get set}
}

class OnBoardingViewModel: OnBoardingViewModelProtocol {
    
    var showTitles: ((OnBoardingTitles) -> Void)?
    var presentImages: (([Route]) -> Void)?
    var presentFotos: (([String],String) -> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var listRutas = [Route]()
    var listFotos = [String]()
    func viewDidLoad() {
        let titles = OnBoardingTitles()
        showTitles?(titles)
        let parameters = ["clienteId":appDelegate.usuario.clienteId,"nivelId":appDelegate.usuario.nivel]
        
        AF.request(Constants().urlBase + Constants().getLogoInicio,method: .get, parameters: parameters,encoding: URLEncoding.default, headers: nil).responseJSON{(response) in
            
            switch response.result{
                case.success(let value):
                    let json = JSON(value)
                    let data = json.stringValue.data(using: .utf8)
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            // try to read out a string array
                           let resultado = json["resultado"] as! String
                            if(resultado == "200"){
                               let response = json["response"] as! NSArray
                               print(response)
                               let encuesta = json["encuesta"] as? String ?? ""
                               print(encuesta)
                               for data in response{
                                  
                                   let value = JSON(data)
                                   self.listFotos.append(value["foto"].stringValue)
                               }
                                self.presentFotos?(self.listFotos,encuesta)

                            }else if (resultado == "400")  {
                                //usuario no existe
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
        
        
                
        AF.request(Constants().urlBase+Constants().getRutaFotos ,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                // jean kk se olvido de hacer bien la webservice para usuario :V
                                
                                for data in response{
                                    let route = Route()
                                    let value = JSON(data)
                                    route.nombre = value["nombre"].stringValue
                                    route.ruta = value["ruta"].stringValue
                                    
                                    self.listRutas.append(route)
                                }
                                self.presentImages?(self.listRutas)

                             }else if (resultado == "400")  {
                                 //usuario no existe
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
            
        
        
        
    }
    
    
    func tapNext() {
        
    }
    
}
