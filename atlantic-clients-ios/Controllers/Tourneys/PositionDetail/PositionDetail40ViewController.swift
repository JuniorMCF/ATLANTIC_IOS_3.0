import UIKit
import Alamofire
import SwiftyJSON
class PositionDetail40ViewController: UIViewController {

    @IBOutlet var titlePuestoLabel: Label!
    @IBOutlet var puestoLabel: Label!
    @IBOutlet var titleRanking: Label!
    @IBOutlet var detailRanking: Label!
    @IBOutlet var proximaFechaLabel: Label!
    @IBOutlet var remindButton: Button!
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var fechaModificacionLabel: Label!
    
    var torneo = Tournament()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        let fechaActual = Utils().getFechaActual()
        onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: torneo.nombre, promocionId: String(torneo.pomocion_id))
        titlePuestoLabel.setSubTitleViewLabelCenter(with: "Usted ocupa el puesto:")
        puestoLabel.setSubTitleViewLabel(with: "\(torneo.posicion)°")
        titleRanking.setSubTitleViewLabelCenter(with: "en el ranking")
        detailRanking.setSubTitleViewLabelCenter(with: "No se encuentra dentro del ranking de ganadores")
        proximaFechaLabel.setSubTitleViewLabelCenter(with: "Próxima fecha: "+torneo.fechaProximaTexto)
        remindButton.setRemindButton(with: "Crear recordatorio")

    
        let fecha = (torneo.fechaActualizacion as NSString).doubleValue
        let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")
        let txtFecha = dateFormatter.string(from: date)
        let txtHour = dateFormatter2.string(from: date)
        
        fechaModificacionLabel.setDateModify(with: "actualizado el \(txtFecha) a las \(txtHour) hrs")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
        // Do any additional setup after loading the view.
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showTerms()
    }
    
    /**
     Guarda la hora en que el usuario ingreso a la promocion
     */
    func onStart(clienteId: String, fechaIngreso: String, nombrePromocion: String, promocionId: String) {
        var dominioUrl = URL(string: Constants().urlBase+Constants().postAgregarActividadPromocion)
        dominioUrl = dominioUrl?.appending("clienteId", value: clienteId)
        dominioUrl = dominioUrl?.appending("fechaIngreso", value: fechaIngreso)
        dominioUrl = dominioUrl?.appending("nombrePromocion", value: nombrePromocion)
        dominioUrl = dominioUrl?.appending("promocionId", value: promocionId)
        
        let url = dominioUrl!.absoluteString
        
        AF.request(url,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON{(response) in
        switch response.result{
            
        case.success(let value):
                     let json = JSON(value)
                     print("statistics",json)
                     
                     //self.presentToast?("datos actualizados correctamente")

                    break
                case.failure(let error):
                   
                    print(error)
                    break
                }
                
            }
    }
    


}
