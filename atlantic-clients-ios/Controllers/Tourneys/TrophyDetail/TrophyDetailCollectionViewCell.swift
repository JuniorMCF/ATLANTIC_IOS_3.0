//
//  TrophyDetailCollectionViewCell.swift
//  clients-ios
//
//  Created by Jhona on 9/10/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class TrophyDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var positionLabel: Label!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var awardsLabel: Label!
    @IBOutlet weak var positionView: View!
    
    func prepare(positions: Positions) {
        
        positionView.addCornerRadius(radius: 20)
        
        positionLabel.setCategorySubTitle(with: positions.position)
        nameLabel.setCategorySubTitle(with: positions.name)
        pointsLabel.setCategorySubTitle(with: positions.points)
        awardsLabel.setCategorySubTitle(with: positions.awards)
        
    }
    
}
