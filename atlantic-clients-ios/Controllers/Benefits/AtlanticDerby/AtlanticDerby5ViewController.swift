//
//  AtlanticDerby5ViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AtlanticDerby5ViewController: UIViewController {
   
    
    var viewModel: AtlanticDerby5ViewModelProtocol! = AtlanticDerby5ViewModel()
    
    var benefit = Benefits()
    
    
    @IBOutlet var navBar: UINavigationItem!
    @IBOutlet var titleLabel: Label!
    
    @IBOutlet var proximaCarreraLabel: Label!
    
    @IBOutlet var recordatorioButton: Button!
    
    @IBOutlet var terminosLabel: Label!
    
    @IBOutlet var fechaModificadaLabel: Label!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bind(){
        viewModel.presentTitles = presentTitles(data:)
    }
    func presentTitles(data:[String]){
        navBar.title = "Atlantic Derby"
        if(!(benefit.fechaActualizacion.isEmpty || benefit.fechaActualizacion == "")){//diferente de null or empty
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
            
            fechaModificadaLabel.setDateModify(with: "actualizado el \(txtFecha) a las \(txtHour) hrs")
           
        }else{
            fechaModificadaLabel.setDateModify(with: "")
        }

        titleLabel.setRafflesTitleGoldCenter(with: benefit.nombre)
       
        proximaCarreraLabel.setSubTitleViewLabelCenterLarge(with: "Próxima carrera: \(benefit.fechaProximaTexto)")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones") // abrir un webview
        recordatorioButton.setRemindButton(with: "Crear recordatorio")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))

        
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
