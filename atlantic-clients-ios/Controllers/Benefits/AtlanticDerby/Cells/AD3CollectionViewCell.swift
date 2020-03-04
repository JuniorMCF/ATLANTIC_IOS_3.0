//
//  AD3CollectionViewCell.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AD3CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var puestoLabel: UILabel!
    
    func prepare(data:String){
           image.image = UIImage(named: data)
           puestoLabel.text = data
       }
    
}
