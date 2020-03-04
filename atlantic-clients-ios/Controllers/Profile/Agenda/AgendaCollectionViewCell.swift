//
//  AgendaCollectionViewCell.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AgendaCollectionViewCell: UICollectionViewCell {

    @IBOutlet var foto: UIImageView!
    @IBOutlet var buffeteTitleLabel: Label!
    @IBOutlet var buffeteSubtitleLabel: Label!
    @IBOutlet var fechaLabel: Label!
    @IBOutlet var eliminarAgendaButton: Button!
    
    @IBOutlet var acompanantesButton: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
