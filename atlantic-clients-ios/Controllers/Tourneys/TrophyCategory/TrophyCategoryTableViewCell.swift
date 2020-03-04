//
//  TrophyCategoryTableViewCell.swift
//  clients-ios
//
//  Created by Jhona on 9/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class TrophyCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trophyImageView: UIImageView!
    @IBOutlet weak var levelTitle: Label!
    
    func prepare(trophyCategory: Tournament) {
        trophyImageView.image = UIImage(named: trophyCategory.logo)
        levelTitle.setDetailSub(with: trophyCategory.nombre)
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
