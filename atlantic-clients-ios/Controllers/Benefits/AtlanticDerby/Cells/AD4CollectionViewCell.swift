//
//  AD4CollectionViewCell.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AD4CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var puestoLabel: Label!
    @IBOutlet var view: UIView!
    func prepare(data:String){
        view.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        view.layer.cornerRadius = 20
        puestoLabel.text = data
        puestoLabel.textColor = .white
    }
    
}
