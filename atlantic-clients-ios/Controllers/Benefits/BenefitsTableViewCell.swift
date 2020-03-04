//
//  BenefitsTableViewCell.swift
//  clients-ios
//BenefitsTableViewCell
//  Created by Jhona on 8/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class BenefitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var benefitImageView: UIImageView!
    
    func prepare(benefit: Benefits) {
        benefitImageView.image = UIImage(named: benefit.nombre)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
