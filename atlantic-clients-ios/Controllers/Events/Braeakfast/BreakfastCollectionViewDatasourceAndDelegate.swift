//
//  BreakfastCollectionViewDatasourceAndDelegate.swift
//  clients-ios
//
//  Created by Jhona on 9/3/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class BreakfastCollectionViewDatasourceAndDelegate: NSObject {
    private var items: [Event] = []
    
    init(items: [Event]) {
        self.items = items
    }
}

extension BreakfastCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let breakfast = items[indexPath.row].fotos
        var foto = ""
        for data in breakfast{
            if(data.esPrincipal == true){
                foto = data.foto
            }
        }

        
        cell.prepare(foto: foto,event:items[indexPath.row])
        return cell
            
        }
}
