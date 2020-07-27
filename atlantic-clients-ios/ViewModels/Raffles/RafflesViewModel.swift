

import Foundation
import Alamofire
import SwiftyJSON
public struct Raffles {
    
    var nameImage: String
    
}

class RafflesDatasources {
    
    var items: [Raffles] = [
        Raffles(nameImage: "img-raffle1"),
        Raffles(nameImage: "img-raffle2"),
        Raffles(nameImage: "img-raffle3"),
        Raffles(nameImage: "img-raffle4")
    ]
}

protocol RafflesViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didSelectRaffles(_ indexPath: Sorteo)
    
    // Mark: - Outputs (Closures)
    
    var loadDatasources: (([Sorteo]) -> Void)? { get set }
    var presentRafflesCategory: ((Sorteo) -> Void)? { get set }
}

class RafflesViewModel: RafflesViewModelProtocol {
    
    var loadDatasources: (([Sorteo]) -> Void)?
    var presentRafflesCategory: ((Sorteo) -> Void)?
    var listSorteos = [Sorteo]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress : CustomProgress!
    
    /**
    Obtiene la lista de sorteos
     */
    func viewDidLoad() {
        //let datasources = RafflesDatasources()
        progress = appDelegate.progressDialog
        
        let parameters = ["id":appDelegate.usuario.clienteId]
        
        progress.showProgress()
       AF.request(Constants().urlBase+Constants().getSorteos,method: .get,parameters: parameters,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                    let sorteo = Sorteo()
                                    let value = JSON(data)

                                    sorteo.logoUrl = value["logo"].stringValue
                                    sorteo.clienteId = value["cliente_d"].intValue
                                    sorteo.fecha = value["fecha"].stringValue
                                    sorteo.fechaActualizacion = value["fecha_actualizacion"].stringValue
                                    sorteo.fechaproxima = value["fecha_proxima"].stringValue
                                    sorteo.fechaProximaSorteo = value["fecha_proxima_texto"].stringValue
                                    sorteo.fechaTexto = value["fecha_texto"].stringValue
                                    let fotos = value["fotos"].arrayValue
                                    for data in fotos{
                                        print("data",data)
                                        let val = JSON(data)
                                        let foto = Foto()
                                        foto.foto = val["foto"].stringValue
                                        foto.esPrincipal = val["esPrincipal"].boolValue
                                        sorteo.fotos.append(foto)
                                    }
                                    sorteo.nombreSorteo = value["nombre"].stringValue
                                    sorteo.opciones = value["opciones"].intValue
                                    sorteo.opcionesFalta = value["opciones_falta"].intValue
                                    sorteo.promocionId = value["promocion_id"].intValue
                                    sorteo.puntos = value["puntos"].intValue
                                    sorteo.puntosFalta = value["puntos_falta"].intValue
                                
                                    self.listSorteos.append(sorteo)
                                }
                                self.appDelegate.sorteos = self.listSorteos
                                self.loadDatasources?(self.listSorteos)
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
    obtiene la categoria del sorteo
     - Parameters:
        - indexPath:  sorteo seleccionado
     */
    func didSelectRaffles(_ indexPath: Sorteo) {
        presentRafflesCategory?(indexPath)
    }
    
}


/**
devuelve la categoria del sorteo
 */
enum RafflesCategoryTypes: Int {
    
    case sorteoEstelar = 0
    case sorteoSueños = 1
    case atlanticVip = 2
    case saltaGana = 3
    
}

