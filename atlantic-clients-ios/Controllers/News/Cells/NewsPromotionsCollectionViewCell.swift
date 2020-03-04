//
//  NewsCollectionViewCell.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class NewsPromotionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var promotionsImage: UIImageView!
    
    public func configure() {
 
        promotionsImage.layer.cornerRadius = 0
        promotionsImage.layer.masksToBounds = true
    }
    
}
