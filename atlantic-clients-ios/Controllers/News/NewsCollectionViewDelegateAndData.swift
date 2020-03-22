//
//  NewsCollectionViewDelegateAndData.swift
//  atlantic-clients-ios
//
//  Created by admin on 2/26/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class NewsCollectionViewDelegateAndData: NSObject {
    private var dailyPromotions = News()
    private var eventWeeks = News()
    private var giftsWeeks = News()
    var dailyCollectionView : UICollectionView!
    var eventsCollectionView : UICollectionView!
    var giftsCollectionView : UICollectionView!
    var parentController : NewsViewController!
    init(dailyPromotions: News,eventWeeks : News, giftsWeeks : News) {
        self.dailyPromotions = dailyPromotions
        self.eventWeeks = eventWeeks
        self.giftsWeeks = giftsWeeks
    }

}

extension NewsCollectionViewDelegateAndData: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dailyCollectionView {
            print(dailyPromotions.promotionDay.list.count)
            return dailyPromotions.promotionDay.list.count
        } else if collectionView == eventsCollectionView {
            return eventWeeks.eventWeek.count
        } else if collectionView == giftsCollectionView {
            print(giftsWeeks.benefitList.count)
            return giftsWeeks.benefitList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == giftsCollectionView {
            let benefit = giftsWeeks.benefitList[indexPath.row]
            if giftsWeeks.isEmpty {
                return
            }
            let storyboard = UIStoryboard(name: "AllBenefits", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "AllBenefitsID") as! AllBenefitsViewController
            viewController.modalPresentationStyle = .fullScreen
            viewController.benefit = benefit
            parentController.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
         if collectionView == eventsCollectionView {
            let event = eventWeeks.eventWeek[indexPath.row]
            
            if eventWeeks.isEmpty{
                return
            }
            
            if eventWeeks.eventWeek.count == 0 {
                return
            }else {
                let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailID") as! EventsDetailViewController
                viewController.modalPresentationStyle = .fullScreen
                viewController.event = event
                parentController.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
        
        if collectionView == dailyCollectionView {
            if(dailyPromotions.isEmpty){
                return
            }
            let tipo = dailyPromotions.promotionDay.tipo[indexPath.row]
            
            
            if(tipo.caseInsensitiveCompare("sorteos") == .orderedSame){
                let sorteo = dailyPromotions.promotionDay.list[indexPath.row] as! Sorteo
                
                let storyboard = UIStoryboard(name: "RafflesDream", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "RafflesDreamID") as! RafflesDreamViewController
                viewController.sorteo = sorteo
                viewController.modalPresentationStyle = .fullScreen
                
                parentController.navigationController?.pushViewController(viewController, animated: true)
            }
            
            
            if(tipo.caseInsensitiveCompare("torneos") == .orderedSame){
                let torneo = dailyPromotions.promotionDay.list[indexPath.row] as! Tournament
                if(torneo.concluido){
                    if(torneo.posicion > 40){
                        let storyboard = UIStoryboard(name: "PositionDetail40", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetail40ID") as! PositionDetail40ViewController
                        viewController.modalPresentationStyle = .fullScreen
                        viewController.torneo = torneo
                        parentController.navigationController?.pushViewController(viewController, animated: true)
                    }else{
                        let storyboard = UIStoryboard(name: "PositionDetail", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetailID") as! PositionDetailViewController
                        viewController.modalPresentationStyle = .fullScreen
                        viewController.torneo = torneo
                        parentController.navigationController?.pushViewController(viewController, animated: true)
                    }
                    
                }
                else{
                    let storyboard = UIStoryboard(name: "TrophyLose", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "TrophyLoseID") as! TrophyLoseViewController
                    viewController.torneo = torneo
                    viewController.modalPresentationStyle = .fullScreen
                    parentController.navigationController?.pushViewController(viewController, animated: true)
                    
                }
                
            }
            
            if(tipo.elementsEqual("beneficios")){
                let type = dailyPromotions.promotionDay.list[indexPath.row] as! Benefits
                
                let mr: ComparisonResult = type.tipo.compare("Martes Regalones", options: NSString.CompareOptions.caseInsensitive)
                     let dr: ComparisonResult = type.tipo.compare("Domingos Regalones", options: NSString.CompareOptions.caseInsensitive)
                
                     if (mr == .orderedSame || dr == .orderedSame){
                             // Esta vista fue modificada para parecerse a la de listBenefits
                             let storyboard = UIStoryboard(name: "AllBenefits", bundle: nil)
                             let viewController = storyboard.instantiateViewController(withIdentifier: "AllBenefitsID") as! AllBenefitsViewController
                             viewController.modalPresentationStyle = .fullScreen
                             viewController.benefit = type
                             parentController.navigationController?.pushViewController(viewController, animated: true)
                             return
                     }else{
                          
                         if(type.esCarrera == nil){

                                 let storyboard = UIStoryboard(name: "AllBenefits", bundle: nil)
                                 let viewController = storyboard.instantiateViewController(withIdentifier: "AllBenefitsID") as! AllBenefitsViewController
                                 viewController.modalPresentationStyle = .fullScreen
                                 viewController.benefit = type
                                 parentController.navigationController?.pushViewController(viewController, animated: true)
                                 return
                         }else{
                             //variable key:Int
                             //1: no hay carrera hoy

                             //2: faltan puntos para participar
                             //3: cliente participa de carrera
                             //4: gano carrera
                             //5: perdio carrera
                             var key = 0

                             if(type.esCarrera!){

                                 if(type.carrera_participa){
                                     key = 3
                                 }
                                 else if(!type.carrera_participa){
                                     key = 2
                                 }
                                 if(!type.carrera_pendiente){

                                     if(type.posicion <= 3 && type.premio != 0.0){
                                         key = 4
                                     }else{
                                         key = 5
                                     }
                                 }
                             }else{
                                 key = 1
                             }
                             
                  

                                 //5 casos segun el key se inflan los AtlanticDerby
                                     switch key {
                                     case 1  :
                                         //atlantic derby5
                                         let storyboard = UIStoryboard(name: "AtlanticDerby5", bundle: nil)
                                         let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby5ID") as! AtlanticDerby5ViewController
                                         viewController.modalPresentationStyle = .fullScreen
                                         viewController.benefit = type
                                         parentController.navigationController?.pushViewController(viewController, animated: true)
                                         break /* optional */
                                     case 2 :
                                         //atlantic derby
                                         let storyboard = UIStoryboard(name: "AtlanticDerby", bundle: nil)
                                         let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerbyID") as! AtlanticDerbyViewController
                                         viewController.modalPresentationStyle = .fullScreen
                                         viewController.benefit = type
                                         parentController.navigationController?.pushViewController(viewController, animated: true)
                                         break /* optional */
                                     case 3 :
                                         //atlantic derby4
                                         let storyboard = UIStoryboard(name: "AtlanticDerby4", bundle: nil)
                                         let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby4ID") as! AtlanticDerby4ViewController
                                         viewController.modalPresentationStyle = .fullScreen
                                         viewController.benefit = type
                                         parentController.navigationController?.pushViewController(viewController, animated: true)
                                         break /* optional */
                                     case 4 :
                                         //atlantic derby3
                                         let storyboard = UIStoryboard(name: "AtlanticDerby3", bundle: nil)
                                         let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby3ID") as! AtlanticDerby3ViewController
                                         viewController.modalPresentationStyle = .fullScreen
                                         viewController.benefit = type
                                         parentController.navigationController?.pushViewController(viewController, animated: true)
                                         break /* optional */
                                     case 5 :
                                         //atlantic derby2
                                         let storyboard = UIStoryboard(name: "AtlanticDerby2", bundle: nil)
                                         let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby2ID") as! AtlanticDerby2ViewController
                                         viewController.modalPresentationStyle = .fullScreen
                                         viewController.benefit = type
                                         parentController.navigationController?.pushViewController(viewController, animated: true)
                                         break /* optional */
                                   
                                     /* you can have any number of case statements */
                                     default : /* Optional */
                                       print("default value")
                                 }

                             }



                         }
            }
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            
         if collectionView == dailyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyPromotionsID", for: indexPath) as! NewsCollectionViewCell
            
            let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
            
            if(dailyPromotions.isEmpty){
               cell.dailyPromotionLabel.text = ""
            }
            else{
             
            let tipo = dailyPromotions.promotionDay.tipo[indexPath.row]
            
            if(tipo.caseInsensitiveCompare("sorteos") == .orderedSame){
               
                let sorteo = dailyPromotions.promotionDay.list[indexPath.row] as! Sorteo
                cell.dailyPromotionLabel.text = sorteo.nombreSorteo
                AF.request(dominio + sorteo.logoUrl).responseImage { response in
                            
                                switch response.result {
                                      case .success(let value):
                                        cell.imageView.image = value
                                        //cell?.promotionsImage.image = value
                                        //cell?.configure()
                                      case .failure(let error):
                                          print(error)
                                          
                                      }

                 }
                cell.dailyPromotionLabel.fontSizeScaleFamily(family: "Avenir-Medium", size: 14)
            }
            
            if(tipo.elementsEqual("beneficios")){
                let benefit = dailyPromotions.promotionDay.list[indexPath.row] as! Benefits
                cell.dailyPromotionLabel.text = benefit.nombre
                AF.request(dominio + benefit.logo).responseImage { response in
                            
                                switch response.result {
                                      case .success(let value):
                                        cell.imageView.image = value
                                        //cell?.promotionsImage.image = value
                                        //cell?.configure()
                                      case .failure(let error):
                                          print(error)
                                          
                                      }
                 }
                cell.dailyPromotionLabel.fontSizeScaleFamily(family: "Avenir-Medium", size: 14)
            }
            
            if(tipo.caseInsensitiveCompare("torneos") == .orderedSame){
                let torneo = dailyPromotions.promotionDay.list[indexPath.row] as! Tournament
                cell.dailyPromotionLabel.text = torneo.nombre
                
                AF.request(dominio + torneo.logo).responseImage { response in
                            
                                switch response.result {
                                      case .success(let value):
                                        cell.imageView.image = value
                                        //cell?.promotionsImage.image = value
                                        //cell?.configure()
                                      case .failure(let error):
                                          print(error)
                                          
                                      }

                 }
                cell.dailyPromotionLabel.fontSizeScaleFamily(family: "Avenir-Medium", size: 14)
            }
            }
            
            return cell
        }
        
        else if collectionView == eventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsID", for: indexPath) as! NewsCollectionViewCell
            
            
            if(eventWeeks.isEmpty){
            
                cell.dailyPromotionLabel.text = "Orquesta"
                let dominioOrquesta = "http://clienteatlantic.azurewebsites.net/admin/upload/orquesta/"
               
                AF.request(dominioOrquesta + eventWeeks.orquesta).responseImage { response in
                           
                               switch response.result {
                                     case .success(let value):
                                       cell.imageView.image = value
                                       //cell?.promotionsImage.image = value
                                       //cell?.configure()
                                     case .failure(let error):
                                         print(error)
                                         
                                     }

                }
                
                
            }else{
                let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/evento/"
                let event = eventWeeks.eventWeek[indexPath.row]
                cell.dailyPromotionLabel.text = event.nombreCorto
                
                
                
                for fotos in event.fotos{
                    var k = 0
                    print(fotos)
                    if(fotos.esPrincipal){
                        AF.request(dominio + fotos.foto).responseImage { response in
                                   
                                       switch response.result {
                                             case .success(let value):
                                               cell.imageView.image = value
                                               //cell?.promotionsImage.image = value
                                               //cell?.configure()
                                             case .failure(let error):
                                                 print(error)
                                                 
                                             }

                        }
                        
                        break
                    }
                    k += 1
                }
            }
            
            
            return cell
         }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "giftsID", for: indexPath) as! NewsCollectionViewCell
            
            if(giftsWeeks.isEmpty){
               cell.dailyPromotionLabel.text = ""
            }else{
            
             let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
            
            let benefit = giftsWeeks.benefitList[indexPath.row]
            
            cell.dailyPromotionLabel.text = benefit.nombre
            
            AF.request(dominio + giftsWeeks.fotoList[indexPath.row]).responseImage { response in
                        
                            switch response.result {
                                  case .success(let value):
                                    cell.imageView.image = value
                                    //cell?.promotionsImage.image = value
                                    //cell?.configure()
                                  case .failure(let error):
                                      print(error)
                                      
                                  }

             }
            }
             return cell
        }
            
           /* let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/noticia/"
           AF.request(dominio + items[indexPath.row].foto).responseImage { response in
                       
                           switch response.result {
                                 case .success(let value):
                                   
                                    cell?.promotionsImage.image = value
                                    cell?.configure()
                                 case .failure(let error):
                                     print(error)
                                     
                                 }

            }*/
            
           
    }
}

extension NewsCollectionViewDelegateAndData: UICollectionViewDelegate {
 
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.tag == 0 else { return }
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                             y: (scrollView.frame.height / 2))
        guard let collectionView = scrollView as? UICollectionView else { return }
       
    }
}

extension NewsCollectionViewDelegateAndData: UICollectionViewDelegateFlowLayout {
   
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 1.7, height: collectionView.frame.height)
}
}


