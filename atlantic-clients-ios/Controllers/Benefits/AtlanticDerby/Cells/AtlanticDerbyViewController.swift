//
//  AtlanticDerbyViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AtlanticDerbyViewController: UIViewController {
    
    
    var benefit = Benefits()
    
    @IBOutlet var titleLabel: Label!
    @IBOutlet var fechaLabel: Label!
    @IBOutlet var pointsLabel: Label!
    @IBOutlet var seekBar: UISlider!
    @IBOutlet var puntosMinLabel: Label!
    @IBOutlet var recordingButton: Button!
    @IBOutlet var proxCarreraLabel: Label!
    
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var fechaActualizadaLabel: Label!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        let fechaActual = Utils().getFechaActual()
        onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: benefit.nombre, promocionId: String(benefit.promocion_id))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveRecordatory(_ sender: Any) {
        let fecha = (benefit.fecha as NSString)
        Utils().saveEvent(title: benefit.nombre, fecha: fecha,parent: self)
    }
    
    
    
    func bind(){
        titleLabel.setRafflesTitleGoldCenter(with: benefit.nombre)
        fechaLabel.setBenefitDetailTitleCenter(with: "Fecha: "+benefit.fechaTexto)
        pointsLabel.setBenefitDetailTitleCenter(with: "Usted tiene "+String(benefit.puntos)+" puntos")
        puntosMinLabel.setDateModify2(with: "¡Le faltan "+String(benefit.puntos_falta)+" puntos para participar en la carrera!")
        proxCarreraLabel.setBenefitDetailTitleCenter(with: "Próxima carrera:\n"+benefit.fechaProximaTexto)
        recordingButton.setRemindButton(with: "Crear recordatorio")
        terminosLabel.setRafflesSubUnderline(with: "Vér términos y condiciones")
        
    
        let ratio : CGFloat = 1.2
        let thumbImage : UIImage = UIImage(named: "ic_derby3x")!
        let size = CGSize( width: thumbImage.size.width * ratio, height: thumbImage.size.height * ratio )
        seekBar.setThumbImage(seekBar.imageWithImage(image: thumbImage, scaledToSize: size), for: .normal)
        
        
        seekBar.tintColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        
        //puntos derby
        let points = benefit.puntos
        let pointsF = benefit.puntos_falta
        if(pointsF == 0){
            seekBar.setValue(100, animated: false)
        }else{
            let temp = Float((points*100)/pointsF)
            seekBar.setValue(temp, animated: false)
        }
        //fecha y hora
        let fecha = (benefit.fechaActualizacion as NSString).doubleValue
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
        fechaActualizadaLabel.setDateModify(with: "Actualizado el "+txtFecha+" a las "+txtHour+" hrs")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showTerms()
    }

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
