//
//  AllBenefitsCollectionViewCell.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AllBenefitsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var AllBenefitsImageView: UIImageView!
    
    func prepare(foto: Foto){
        AllBenefitsImageView.image = UIImage(named: foto.foto)
    }
}
