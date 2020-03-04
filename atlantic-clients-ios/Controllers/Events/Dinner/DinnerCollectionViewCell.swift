//
//  DinnerCollectionViewCell.swift
//  clients-ios
//
//  Created by Jhona on 9/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class DinnerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var totalLabel: Label!
    @IBOutlet weak var dinnerView: View!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
    }
    
    func prepare(dinner: Dinner) {
        titleLabel.setDinnerTitle(with: dinner.title)
        dateLabel.setDinnerSubTitle(with: dinner.date)
        totalLabel.setDinnerSubTitle(with: "\(dinner.totalPersons) Acompañantes")
        dinnerView.addCornerRadius(radius: 20)
    }

}
