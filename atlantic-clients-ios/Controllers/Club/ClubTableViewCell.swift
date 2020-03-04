//
//  ClubTableViewCell.swift
//  clients-ios
//
//  Created by Jhona on 9/7/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: Label!
    
    @IBOutlet var img: UIImageView!
    
    
    func prepare(category: ClubCategory) {
        title.setClubTitle(with: category.title)
        title.font = UIFont.boldSystemFont(ofSize: 16.0)
        img.image = UIImage(named: category.image)
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
