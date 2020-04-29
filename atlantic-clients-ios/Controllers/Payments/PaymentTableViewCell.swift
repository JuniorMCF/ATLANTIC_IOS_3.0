//
//  PaymentTableViewCell.swift
//  clients-ios
//
//  Created by Jhona on 7/31/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var payImageView: UIImageView!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var payLabel: Label!
    @IBOutlet weak var stateTitleLabel: Label!
    @IBOutlet weak var stateLabel: Label!
    
    func prepare(payment: Cobros) {
        titleLabel.text = payment.nombre
        titleLabel.fontSizeScale = 14.0
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        
        stateTitleLabel.text = "Estado: "
        
        payment.premio = String(format: "%.0f", (payment.premio as NSString).floatValue)
 
        if(payment.puesto == "" ){
            if(payment.tipoMoneda == "soles"){
                payLabel.text = "S/ " + payment.premio + " " + payment.tipoMoneda
            }else if (payment.tipoMoneda == "dólares"){
                payLabel.text = "$ " + payment.premio + " " + payment.tipoMoneda
            }

        }else if (payment.puesto == "0"){
            if(payment.tipoMoneda == "soles"){
               payLabel.text = "S/ " + payment.premio + " " + payment.tipoMoneda
            }else if (payment.tipoMoneda == "dólares"){
                 payLabel.text = "$ " + payment.premio + " " + payment.tipoMoneda
            }
        }else{
            if(payment.tipoMoneda == "soles"){
                if(payment.puesto == "0" || payment.puesto == "null" || payment.puesto == "" || payment.puesto.isEmpty){
                    payLabel.text = payment.premio + " " + payment.tipoMoneda
                }else{
                    payLabel.text = payment.puesto + "° Puesto - S/ " + payment.premio + " " + payment.tipoMoneda
                }

            }else if (payment.tipoMoneda == "dólares"){
                if(payment.puesto == "0" || payment.puesto == "null" || payment.puesto == "" || payment.puesto.isEmpty){
                    payLabel.text = payment.premio + " " + payment.tipoMoneda
                }else{
                    payLabel.text = payment.puesto + "° Puesto - $/ " + payment.premio + " " + payment.tipoMoneda
                }

            }

        }
        
        //estados
        if(payment.estado == "1"){
            stateLabel.text = "por cobrar"
            stateLabel.textColor = UIColor(named: "Color-Inactive")
        }else{
            stateLabel.text = "Cobrado"
            stateLabel.textColor = UIColor(named: "Color-Active")
        }
 
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
