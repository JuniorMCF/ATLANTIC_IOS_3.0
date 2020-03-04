//
//  NewsPromotionsViewContoller+CollectionViewDatasource.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
extension NewsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dailyCollectionView {
            return imagesDaylies.promotionDay.list.count
        } else if collectionView == eventsCollectionView {
            return imagesEvents.eventWeek.count
        } else if collectionView == giftsCollectionView {
            return imagesGifts.benefitList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dailyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyPromotionsID", for: indexPath) as? NewsCollectionViewCell

            let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/noticia/"
                
            if(imagesDaylies.promotionDay.tipo[indexPath.row] == "sorteos"){
                        let val = imagesDaylies.promotionDay.list[indexPath.row] as! Sorteo
                AF.request("https://clienteatlantic.azurewebsites.net/admin/upload/promocion/" + val.logoUrl ).responseImage { response in
                                   
                                       switch response.result {
                                             case .success(let value):
                                                cell?.imageView.image = value
                                                cell?.dailyPromotionLabel.text = val.nombreSorteo
                                             case .failure(let error):
                                                 print(error)
                                                 
                                             }

                        }
            }
            if(imagesDaylies.promotionDay.tipo[indexPath.row] == "beneficios"){
                        let val = imagesDaylies.promotionDay.list[indexPath.row] as! Benefits
                        AF.request(dominio + dominio).responseImage { response in
                                   
                                       switch response.result {
                                             case .success(let value):
                                               
                                                cell?.imageView.image = value
                                                cell?.dailyPromotionLabel.text = val.nombre
                                             case .failure(let error):
                                                 print(error)
                                                 
                                             }

                        }
            }
            if(imagesDaylies.promotionDay.tipo[indexPath.row] == "torneos"){
                        let val = imagesDaylies.promotionDay.list[indexPath.row] as! Tournament
                        AF.request(dominio + dominio).responseImage { response in
                                   
                                       switch response.result {
                                             case .success(let value):
                                               
                                                cell?.imageView.image = value
                                                cell?.dailyPromotionLabel.text = val.nombre
 
                                             case .failure(let error):
                                                 print(error)
                                                 
                                             }

                        }
            }

            
            
            cell?.configure()
            return cell!
        } else if collectionView == eventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsID", for: indexPath) as? NewsCollectionViewCell
            //cell?.imageView.image = UIImage(named: imagesEvents[indexPath.row].orquesta)
            cell?.configure()
            return cell!
        } else if collectionView == giftsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "giftsID", for: indexPath) as? NewsCollectionViewCell
            //cell?.imageView.image = UIImage(named: imagesGifts[indexPath.row].orquesta)
            cell?.configure()
            return cell!
        }
        return UICollectionViewCell()
    }
    
}
