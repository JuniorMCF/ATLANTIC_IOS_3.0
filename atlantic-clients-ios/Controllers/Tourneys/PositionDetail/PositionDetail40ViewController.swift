//
//  PositionDetail40ViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/27/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let terminos = Terminos(parent: self, url: "url")
        terminos.showProgress()
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
