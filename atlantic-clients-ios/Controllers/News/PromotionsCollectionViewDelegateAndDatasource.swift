//
//  PromotionsCollectionViewDelegateAndDatasource.swift
//  clients-ios
//
//  Created by Jhona on 7/29/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class PromotionsCollectionViewDelegateAndDatasource: NSObject {
    
    private var items: [ImagenNoticia] = []
    private let pageControl: UIPageControl
    
    init(items: [ImagenNoticia], pageControl: UIPageControl) {
        self.items = items
        self.pageControl = pageControl
        self.pageControl.numberOfPages = items.count
    }

}

extension PromotionsCollectionViewDelegateAndDatasource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionsID", for: indexPath) as? NewsPromotionsCollectionViewCell
            let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/noticia/"
            AF.request(dominio + items[indexPath.row].foto).responseImage { response in
                       
                           switch response.result {
                                 case .success(let value):
                                   
                                    cell?.promotionsImage.image = value
                                    cell?.configure()
                                 case .failure(let error):
                                     print(error)
                                     
                                 }

            }
            
            return cell!
    }
}

extension PromotionsCollectionViewDelegateAndDatasource: UICollectionViewDelegate {
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.tag == 0 else { return }
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                             y: (scrollView.frame.height / 2))
        guard let collectionView = scrollView as? UICollectionView else { return }
        if let ip = collectionView.indexPathForItem(at: center) {
            pageControl.currentPage = ip.row
        }
    }
}

