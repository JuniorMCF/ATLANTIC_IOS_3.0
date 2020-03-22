//
//  NewsViewModel.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

struct NewsTitles {
    
    var dailyTitle: String = "Promociones del día"
    var eventsTitle: String = "Eventos de la Semana"
    var giftsTitle: String = "Regalos de noviembre"
    
}

class NewsDatasources {
    
    var promotions: [ImagenNoticia] = []
    var dailys =  News()
    var events = News()
    var gifts = News()
    
}

protocol NewsViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad(clienteId:String,nivelId:String)
    
    // Outputs (Clousures)
    
    var showTitles: ((NewsTitles) -> Void)? { get set }
    var loadDatasources: ((NewsDatasources) -> Void)? { get set }
    
}

class NewsViewModel: NewsViewModelProtocol {
    
    var showTitles: ((NewsTitles) -> Void)?
    var loadDatasources: ((NewsDatasources) -> Void)?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress : CustomProgress!
    //variables
    var countVerify = 0 //cuenta que todas las peticiones por Alamofire se hayan concretado 0: ninguna , 4:todas
    let datasources = NewsDatasources()
    
    func viewDidLoad(clienteId:String,nivelId:String) {
        progress = appDelegate.progressDialog
        
        let titles = NewsTitles()
        
        var listImagenNoticia = [ImagenNoticia]()

        //lista de tamaño 4 con response = 100 , si response = 200 en los 4 se envia la data por el metodo loadDatasource()
        
        //obteniendo imagenes de las noticias
        
        //banner Imagenes Noticia
        progress.showProgress()
        
        AF.request(Constants().urlBase+Constants().getImagenNoticia ,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                            //let response = json["response"] as! NSArray
                                            let response = json["response"] as! NSArray

                                            for data in response{
                                                let imagenNoticia = ImagenNoticia()
                                                let value = JSON(data)
                                                imagenNoticia.foto = value["foto"].stringValue
                                                imagenNoticia.orden = value["orden"].intValue
                                                listImagenNoticia.append(imagenNoticia)
                                            }
                                            self.datasources.promotions = listImagenNoticia
                                            self.verifyResponse()
                                            //self.loadDatasources?(self.datasources)
                                            
                                            
                                         }else if (resultado == "400")  {
                                             //usuario no existe
                                         }else if (resultado == "401" ){
                                             //clave incorrecta
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
        
        //PromotionDia
        let parametersPD = ["clienteId": (clienteId as NSString).intValue] as [String : Any]
        print(parametersPD)
        AF.request(Constants().urlBase+Constants().getPromocionesDia ,method: .get,parameters: parametersPD,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                            let promotionDay = PromotionDay()
                            
                            if(resultado == "200"){
                                
                                //let response = json["response"] as! NSArray
                                let responseSorteo = json["sorteoList"] as! NSArray
                                let responseBenefits = json["beneficiosList"] as! NSArray
                                let responseTorneos = json["torneosList"] as! NSArray
                                
                                if(responseSorteo.count == 0 && responseBenefits.count == 0 && responseTorneos.count == 0){
                                    var sorteoList = [Sorteo]()
                                    let sorteo = Sorteo()
                                    sorteoList.append(sorteo)
                                    promotionDay.list.append(sorteoList)
                                    let new = News()
                                    new.title = "Promociones del día"
                                    new.promotionDay = promotionDay
                                    new.isEmpty = true
                                    self.datasources.dailys = new
                                    self.verifyResponse()
                                }else{
                                    var sorteoList = [Sorteo]()
                                    var benefitsList = [Benefits]()
                                    var torneosList = [Tournament]()
                                    //sorteo list
                                    for data in responseSorteo{
                                        let value = JSON(data)
                                        print(value)
                                        let sorteo = Sorteo()
                                        promotionDay.tipo.append("sorteos")
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
                                        sorteoList.append(sorteo)
                                    }
                                    for item in sorteoList{
                                        //promotionDay.tipo.append("sorteo")
                                        promotionDay.list.append(item)
                                    }
                                    //benefits list
                                    for data in responseBenefits{
                                        let value = JSON(data)
                                        let benefit = Benefits()
                                        promotionDay.tipo.append("beneficios")
                                        //benefit.fotos = fotos
                                        benefit.nombre = value["nombre"].stringValue
                                        benefit.descripcion = value["descripcion"].stringValue
                                        benefit.tipo  = value["tipo"].stringValue
                                        benefit.cliente_id  = value["cliente_id"].intValue
                                        benefit.promocion_id  = value["promocion_id"].intValue
                                        benefit.logo  = value["logo"].stringValue
                                        benefit.puntos  = value["puntos"].intValue
                                        benefit.puntos_falta  = value["puntos_falta"].intValue
                                        benefit.puntos_minimo  = value["puntos_minimo"].intValue
                                        benefit.premio = value["premio"].doubleValue
                                        benefit.premio_falta  = value["premio_falta"].doubleValue
                                        benefit.posicion  = value["posicion"].intValue
                                        benefit.carrera_pendiente  = value["carrera_pendiente"].boolValue
                                        benefit.carrera_participa  = value["carrera_participa"].boolValue
                                        benefit.carrera_es_domingo  = value["carrera_es_domingo"].boolValue
                                        benefit.carrera_hay  = value["carrera_hay"].boolValue
                                        benefit.fechaTexto  = value["fecha_texto"].stringValue
                                        benefit.fechaProximaTexto = value["fecha_proxima_texto"].stringValue
                                        benefit.estado  = value["estado"].intValue
                                        benefit.tipoMoneda  = value["tipoMoneda"].stringValue
                                        benefit.fecha  = value["fecha"].stringValue
                                        if(value["esCarrera"].stringValue.isEmpty){
                                            benefit.esCarrera  = nil
                                        }else{
                                            benefit.esCarrera  = value["esCarrera"].boolValue
                                        }
                                        
                                        
                                        benefit.fechaProxima  = value["fecha_proxima"].stringValue
                                        benefit.fechaActualizacion  = value["fecha_actualizacion"].stringValue
                                        
                                        
                                        benefitsList.append(benefit)
                                    }
                                    for item in benefitsList{
                                        //promotionDay.tipo.append("beneficios")
                                        promotionDay.list.append(item)
                                    }
                                    //torneos list
                                    for data in responseTorneos{
                                        let value = JSON(data)
                                        print(value)
                                        let torneo = Tournament()
                                        promotionDay.tipo.append("torneos")
                                        torneo.tipo = value["tipo"].stringValue
                                        torneo.logo = value["logo"].stringValue
                                        torneo.nombre = value["nombre"].stringValue
                                        torneo.cliente_id = value["cliente_id"].stringValue
                                        torneo.pomocion_id = value["pomocion_id"].intValue
                                        torneo.posicion = value["posicion"].intValue
                                        torneo.puntaje = value["puntaje"].intValue
                                        torneo.premio = value["premio"].doubleValue
                                        torneo.concluido  = value["concluido"].boolValue
                                        torneo.fechaTexto = value["fechaTexto"].stringValue
                                        torneo.fechaProximaTexto = value["fechaProximaTexto"].stringValue
                                        torneo.fechaProxima = value["fechaProxima"].stringValue
                                        torneo.fechaActualizacion = value["fechaActualizacion"].stringValue
                                        
                                        
                                        torneosList.append(torneo)
                                    }
                                    for item in torneosList{
                                       // promotionDay.tipo.append("torneos")
                                        promotionDay.list.append(item)
                                    }


                                    let new = News()
                                    new.title = "Promociones del día"
                                    new.promotionDay = promotionDay
                                    new.isEmpty = false
                                    self.datasources.dailys = new
                                    self.verifyResponse()
                                }
                                
                                
                                //pasar la noticia
                                
                             }else {
                                //en otros casos
                                let new = News()
                                new.title = "Promociones del día"
                                new.promotionDay = promotionDay
                                new.isEmpty = true
                                self.datasources.dailys = new
                                self.verifyResponse()
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
        //Eventos Semanales
        let parametersEW = ["clienteId": (clienteId as NSString).intValue,"nivelId": (nivelId as NSString).intValue] as [String : Any]
        print(parametersEW)
        AF.request(Constants().urlBase+Constants().getEventosSemana,method: .get,parameters: parametersEW,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     let data = json.stringValue.data(using: .utf8)
                     do {
                         // make sure this JSON is in the format we expect
                         if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                             // try to read out a string array
                            let resultado = json["resultado"] as! String
                            var eventList = [Event]()
                            
                            if(resultado == "200"){
                                
                                let response = json["response"] as! NSArray
                                if(response.count == 0){
                                    //getOrquesta
                                    self.getOrquesta(clienteId: clienteId)
                                    //self.verifyResponse()
                                }else{
                                    
                                    for data in response{
                                        
                                        let event = Event()
                                        let value = JSON(data)
                                        event.agendaId = value["agendaId"].intValue
                                        event.clienteId = value["cliente_id"].intValue
                                        event.descripcion = value["descripcion"].stringValue
                                        event.esPrincipal = value["es_principal"].boolValue
                                        event.eventoId = value["evento_id"].intValue
                                        event.fecha = value["fecha"].stringValue
                                        event.foto = value["foto"].stringValue
                                        //event.fotos = value[""]
                                        event.horarioId = value["horarioId"].intValue
                                        event.id = value["evento_id"].intValue
                                        event.nAcompanantes = value["nAcompanantes"].stringValue
                                        event.nombre = value["nombre"].stringValue
                                        event.nombreCorto = value["nombre_corto"].stringValue
                                        event.nombreTipo = value["nombreTipo"].stringValue
                                        event.nroAcompañantes = value["nroAcompañantes"].stringValue
                                        event.tituloShow = value["titulo_show"].stringValue
                                        let fotos = value["fotos"].arrayValue
                                        for foto in fotos{
                                            let photos = FotoEvent()
                                            let value = JSON(foto)
                                            photos.esPrincipal = value["esPrincipal"].boolValue
                                            photos.foto = value["foto"].stringValue
                                            event.fotos.append(photos)
                                        }
                                        
                                        eventList.append(event)
                                    }
                                    
                                    let new = News()
                                    new.title = "Eventos de la semana"
                                    new.eventWeek = eventList
                                    new.isEmpty = false
                                    self.datasources.events = new
                                    self.verifyResponse()
                                }
                               
                                	
                                
                                
                             }else {
                                //en otros casos
                                self.verifyResponse()
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
        
        //Benefits
        
        let parametersB = ["id": (clienteId as NSString).intValue] as [String : Any]
        print(parametersEW)
        AF.request(Constants().urlBase+Constants().getBeneficiosSemana,method: .get,parameters: parametersB,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                            var benefitList = [Benefits]()
                            print(resultado)
                            if(resultado == "200"){
                                
                                let response = json["response"] as! NSArray
                              //  print(response.count)
                                if(response.count == 0){
                                    let benefit = Benefits()
                                    benefitList.append(benefit)
                                    let new = News()
                                    
                                    new.title = "Regalos de la semana"
                                    new.benefitList = benefitList
                                    new.isEmpty = true
                                    self.datasources.gifts = new
                                    self.verifyResponse()
                                }else{
                                    
                                    for data in response{
                                        
                                        let benefit = Benefits()
                                        let value = JSON(data)
                                        
                                        benefit.tipo = value["tipo"].stringValue
                                        benefit.tipoMoneda = value["tipo_moneda"].stringValue
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
                                        
                                        benefitList.append(benefit)
                                    }
                                    let new = News()
                                    new.title = "Regalos de la semana"
                                    for benefit in benefitList{
                                        for foto in benefit.fotos{
                                            new.fotoList.append(foto.foto)
                                            new.benefitList.append(benefit)
                                        }
                                    }
                                    //new.benefitList = benefitList
                                    new.isEmpty = false
                                    self.datasources.gifts = new
                                    self.verifyResponse()
                                }
                               
                                    
                                
                                
                             }else {
                                //en otros casos
                                self.verifyResponse()
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
        
        
        
        
        
        
        
        
        showTitles?(titles)
        
    }
    
    func verifyResponse(){
        countVerify += 1
        if(countVerify == 4){
            progress.hideProgress()
            loadDatasources?(datasources)
        }
    }
    
    
    func getOrquesta(clienteId: String){
        
        let parametersPD = ["idCliente": (clienteId as NSString).intValue] as [String : Any]
        
        AF.request(Constants().urlBase+Constants().getOrquesta ,method: .get,parameters: parametersPD,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
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
                                //let response = json["response"] as! NSArray
                                let response = json["response"] as! String
                                var eventList = [Event]()
                                let event = Event()
                                let new = News()
                                eventList.append(event)
                                new.title = "Orquesta de la semana"
                                new.orquesta = response
                                new.eventWeek = eventList
                                //new.benefitList = benefitList
                                new.isEmpty = true
                                self.datasources.events = new
                                self.verifyResponse()
                             }else{
                                var eventList = [Event]()
                                let event = Event()
                                let new = News()
                                new.title = "Orquesta de la semana"
                                new.orquesta = ""
                                new.eventWeek = eventList
                                //new.benefitList = benefitList
                                new.isEmpty = true
                                self.datasources.events = new
                                self.verifyResponse()
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
    
}
