//
//  AgendaCollectionViewCell.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import AlamofireImage
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
    

    
    
    
    
    func prepare(foto: String,event:Event) {
        if(foto != "" ){
            let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/evento/"
            AF.request(dominio + foto).responseImage { response in
                       
                           switch response.result {
                                 case .success(let value):
                                    self.foto.image = value
                                 case .failure(let error):
                                     print(error)
                                     
                                 }

            }
            buffeteTitleLabel.text = "Almuerzo buffet"
            buffeteSubtitleLabel.setDetailSubTitle(with: event.nombreCorto)
            let fecha = (event.fecha as NSString).doubleValue
            let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = NSLocale.current
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            
            let txtFecha = dateFormatter.string(from: date)
            
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
            let myComponents = myCalendar!.components(.weekday, from: date)
            let weekDay = myComponents.weekday
            fechaLabel.text = Utils().getDia(weekDay: weekDay!)+" "+txtFecha
            acompanantesButton.setFirstButton3(with: event.nAcompanantes+" Acompañante")
        }else{
            self.foto.image = UIImage(named: "img_desayuno")
            buffeteTitleLabel.text = "Almuerzo buffet"
            buffeteSubtitleLabel.setDetailSubTitle(with: event.nombreCorto)
           let fecha = (event.fecha as NSString).doubleValue
            let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = NSLocale.current
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            
            let txtFecha = dateFormatter.string(from: date)
            
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
            let myComponents = myCalendar!.components(.weekday, from: date)
            let weekDay = myComponents.weekday
            fechaLabel.text = Utils().getDia(weekDay: weekDay!)+" "+txtFecha
            acompanantesButton.setFirstButton3(with: event.nAcompanantes+" Acompañante")
        }
    }
}
