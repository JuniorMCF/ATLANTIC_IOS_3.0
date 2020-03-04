//
//  AtlanticDerbyViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
    }
    func bind(){
        titleLabel.setRafflesTitleGoldCenter(with: "Carrera de oro")
        fechaLabel.setRafflesSubTitleCenter(with: "Fecha: 10 de Diciembre 08:00 AM")
        pointsLabel.setRafflesSubTitleCenter(with: "Usted tiene 150 puntos")
        puntosMinLabel.setRafflesSubTitleCenter(with: "Le faltan 30 puntos para participar en la carrera")
        proxCarreraLabel.setBenefitDetailTitleCenter(with: "Próxima carrera:\n Jueves 16 de enero Hora: 2.00pm")
        recordingButton.setRemindButton(with: "Crear recordatorio")
        terminosLabel.setRafflesSubTitleCenter(with: "Vér términos y condiciones")
        fechaActualizadaLabel.setRafflesSubTitleCenter(with: "Actualizado el 28/02/20 a las 9:00 pm")
        seekBar.setThumbImage(UIImage(named: "ic_derby"), for: .normal)
        seekBar.tintColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        seekBar.trackRect(forBounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        
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
