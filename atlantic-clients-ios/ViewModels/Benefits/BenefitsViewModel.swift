import Foundation
import UIKit
import Alamofire
import SwiftyJSON
public struct Benefit {
    
    var nameImage: String
    
}

class BenefitsDatasources {
    var items: [Benefit] = [
        Benefit(nameImage: "img-ben1"),
        Benefit(nameImage: "img-ben2"),
        Benefit(nameImage: "img-ben3"),
        Benefit(nameImage: "img-ben4"),
        Benefit(nameImage: "img-ben1")
        ]
}

protocol BenefitsViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didSelectBenefits(_ indexPath: Benefits)
    
    // Mark: - Outputs (Closures)
    
    var loadDatasources: (([Benefits]) -> Void)? { get set }
    var presentBenefit: ((Benefits) -> Void)? { get set }
}

class BenefitsViewModel: BenefitsViewModelProtocol {
    
    var presentBenefit: ((Benefits) -> Void)?
    var loadDatasources: (([Benefits]) -> Void)?
    
    var datasource = [Benefits]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress : CustomProgress!
    
    /**
     Obtiene los beneficios semanales
     */
    func viewDidLoad() {
        progress = appDelegate.progressDialog
        let parameters = ["id":appDelegate.usuario.clienteId]

        progress.showProgress()
        AF.request(Constants().urlBase+Constants().getBeneficios,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                    let benefit = Benefits()
                                    let value = JSON(data)
                                    benefit.tipo = value["tipo"].stringValue
                                    benefit.tipoMoneda = value["tipoMoneda"].stringValue
                                    benefit.carrera_es_domingo = value["carrera_es_domingo"].boolValue
                                    benefit.carrera_hay = value["carrera_hay"].boolValue
                                    benefit.carrera_participa = value["carrera_participa"].boolValue
                                    benefit.carrera_pendiente = value["carrera_pendiente"].boolValue
                                    benefit.cliente_id = value["cliente_id"].intValue
                                    benefit.descripcion = value["descripcion"].stringValue
                                    if(value["esCarrera"].stringValue.isEmpty){
                                        benefit.esCarrera  = nil
                                    }else{
                                        benefit.esCarrera  = value["esCarrera"].boolValue
                                    }
                                    benefit.estado = value["estado"].intValue
                                    benefit.fecha = value["fecha"].stringValue
                                    benefit.fechaActualizacion = value["fecha_actualizacion"].stringValue
                                    benefit.fechaProxima = value["fecha_proxima"].stringValue
                                    benefit.fechaProximaTexto = value["fecha_proxima_texto"].stringValue
                                    benefit.fechaTexto = value["fecha_texto"].stringValue
                                    let fotos = value["fotos"].arrayValue
                                    for foto in fotos{
                                        let photos = Foto()
                                        let value = JSON(foto)
                                        photos.esPrincipal = value["esPrincipal"].boolValue
                                        photos.foto = value["foto"].stringValue
                                        benefit.fotos.append(photos)
                                    }
                                    
                                    benefit.logo = value["logo"].stringValue
                                    benefit.nombre = value["nombre"].stringValue
                                    benefit.posicion = value["posicion"].intValue
                                    benefit.premio = value["premio"].doubleValue
                                    benefit.premio_falta = value["premio_falta"].doubleValue
                                    benefit.promocion_id = value["promocion_id"].intValue
                                    benefit.puntos = value["puntos"].intValue
                                    benefit.puntos_falta = value["puntos_falta"].intValue
                                    benefit.puntos_minimo = value["puntos_minimo"].intValue
                                    self.datasource.append(benefit)
                                }
                                self.loadDatasources?(self.datasource)
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
        
        
    }
    
    /**
    Carga la categoria del beneficio seleccionado
    - Parameters:
        - indexPath: beneficio seleccionado
     */
    func didSelectBenefits(_ indexPath: Benefits) {
        presentBenefit?(indexPath)
    }
    
}

enum BenefitsTypes: Int {
    
    case martesRegalones = 0
    case domingosRegalones = 1
    case todosGanan = 2
    case todosGananPlus = 3
    case top100 = 4
    
}
