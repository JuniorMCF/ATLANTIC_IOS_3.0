//
//  RafflesTableViewCell.swift
//  clients-ios
//
//  Created by Jhona on 9/7/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class RafflesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rafflesImageView: UIImageView!
    
    func prepare(raffles: Sorteo) {
        rafflesImageView.image = UIImage(named: raffles.logoUrl)
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
