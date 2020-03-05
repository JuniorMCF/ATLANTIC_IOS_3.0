//
//  ADCollectionViewCell.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/21/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AD2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var puestoLabel: UILabel!
    func prepare(data: Puestos){
        image.image = UIImage(named: data.foto)
        puestoLabel.text = data.puesto
    }
}
