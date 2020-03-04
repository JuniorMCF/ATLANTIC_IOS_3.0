//
//  ItemCollectionViewCell.swift
//  clients-ios
//
//  Created by Jhona on 9/3/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageBreakfast: UIImageView!
    @IBOutlet var tituloBreakfast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
    }
    
    func prepare(foto: String,event:Event) {
        if(foto != "" ){
            let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/evento/"
            AF.request(dominio + foto).responseImage { response in
                       
                           switch response.result {
                                 case .success(let value):
                                    self.imageBreakfast.image = value
                                 case .failure(let error):
                                     print(error)
                                     
                                 }

            }
            tituloBreakfast.text = event.nombreCorto
        }else{
            imageBreakfast.image = UIImage(named: "img_desayuno")
            tituloBreakfast.text = event.nombreCorto
        }
    }
}
