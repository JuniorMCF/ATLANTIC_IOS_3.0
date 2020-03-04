//
//  NewsEventsCollectionViewCell.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class NewsEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventsImage: UIImageView!
    
    public func configure() {
        eventsImage.layer.cornerRadius = 8
        eventsImage.layer.masksToBounds = true
    }
    
}
