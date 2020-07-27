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
            buffeteTitleLabel.setTextNormal(with: "Almuerzo buffet")
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
            fechaLabel.setTextNormal2(with: Utils().getDia(weekDay: weekDay!)+" "+txtFecha)
            if(event.nAcompanantes.elementsEqual("1")){
                acompanantesButton.setFirstButton3(with: event.nAcompanantes+" Acompañante")
            }else{
                acompanantesButton.setFirstButton3(with: event.nAcompanantes+" Acompañantes")
            }
            
        }else{
            self.foto.image = UIImage(named: "img_desayuno")
            buffeteTitleLabel.setTextNormal(with: "Almuerzo buffet")
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
            fechaLabel.setTextNormal2(with: Utils().getDia(weekDay: weekDay!)+" "+txtFecha)
            acompanantesButton.setFirstButton3(with: event.nAcompanantes+" Acompañantes")
        }
    }
}
