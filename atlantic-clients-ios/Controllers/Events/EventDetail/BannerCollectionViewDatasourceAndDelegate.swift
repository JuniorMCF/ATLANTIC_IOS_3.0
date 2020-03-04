//
//  BannerCollectionViewDatasourceAndDelegate.swift
//  clients-ios
//
//  Created by Jhona on 9/6/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class BannerCollectionViewDatasourceAndDelegate: NSObject {
    
    private var items: [String] = []
    private let pageControl: UIPageControl
    
    init(items: [String], pageControl: UIPageControl) {
        self.items = items
        self.pageControl = pageControl
        self.pageControl.numberOfPages = items.count
    }
    
}

extension BannerCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCellID", for: indexPath) as? BannerCollectionViewCell
        
        let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/evento/"
        

        AF.request(dominio + items[indexPath.row]).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell?.bannerImage.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        cell?.configure()
        return cell!
    }
}

extension BannerCollectionViewDatasourceAndDelegate: UICollectionViewDelegate {
    
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
