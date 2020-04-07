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
        if(data.contains("1er puesto:")){
            view.alpha = 1.0
        }
        if(data.contains("2do puesto:")){
            view.alpha = 0.8
        }
        if(data.contains("3er puesto:")){
            view.alpha = 0.6
        }
        view.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        view.layer.cornerRadius = 10
        puestoLabel.text = data
        puestoLabel.textColor = .white
    }
    
}
