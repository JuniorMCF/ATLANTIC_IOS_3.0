//
//  NewsCollectionViewCell.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var dailyPromotionLabel: UILabel!
    
    public func configure() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

}
