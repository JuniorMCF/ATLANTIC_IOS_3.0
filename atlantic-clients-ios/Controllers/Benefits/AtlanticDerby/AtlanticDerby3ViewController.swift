//
//  AtlanticDerby3ViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AtlanticDerby3ViewController: UIViewController {
    private var ad3CollectionViewDD: AD3CollectionViewDelegateAndDatasource!
    
    var viewModel: AtlanticDerby3ViewModelProtocol! = AtlanticDerby3ViewModel()

    
    var benefit = Benefits()
    
    @IBOutlet var titleLabel: Label!
    @IBOutlet var puestoLabel: Label!
    @IBOutlet var gananciaLabel: Label!
    
    
    @IBOutlet var cobrosButton: Button!
    @IBOutlet var proximaCarreraLabel: Label!
    
    
    @IBOutlet var recordatorioButton: Button!
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var fechaActualizacionLabel: Label!
 
    @IBOutlet var resultadoTitle: Label!
    
    @IBOutlet var AD3CollectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        AD3CollectionView.layer.cornerRadius = 25
        AD3CollectionView.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.862745098, alpha: 1)
        bind()
        let fechaActual = Utils().getFechaActual()
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: benefit.nombre, promocionId: String(benefit.promocion_id))
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bind(){
        
        viewModel.loadDataSources = loadDatasources(datasources:)
        viewModel.presentTitles = presentTitles(data:)
    }
    func presentTitles(data:[String]){
        
        titleLabel.setRafflesTitleGoldCenter(with: "¡Ha ganado!")
        puestoLabel.setSubTitleViewLabelCenterLarge(with: String(benefit.posicion)+"º puesto - "+benefit.nombre)
        if(benefit.tipoMoneda == "dólares"){
            gananciaLabel.setSubTitleViewLabelCenterLarge(with: "$ "+String(Int(benefit.premio)))
        }else if (benefit.tipoMoneda == "soles"){
            gananciaLabel.setSubTitleViewLabelCenterLarge(with: "S/ "+String(Int(benefit.premio)))
        }
        //gananciaLabel.setSubTitleViewLabelCenterLarge(with: "$50")
        resultadoTitle.setSubTitleViewLabelCenterLarge(with: "Resultados:")
        
        cobrosButton.setRemindButton(with: "IR A MIS COBROS")
        proximaCarreraLabel.setSubTitleViewLabelCenter(with: "Próxima carrera:\n"+benefit.fechaProximaTexto)
       
       
        recordatorioButton.setRemindButton(with: "Crear recordatorio")
       
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        
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
        
        fechaActualizacionLabel.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showProgress()
    }
    func loadDatasources(datasources: [Puestos]) {
        ad3CollectionViewDD = AD3CollectionViewDelegateAndDatasource(items: datasources,
                                                                     viewModel:viewModel)
        AD3CollectionView.dataSource = ad3CollectionViewDD
        AD3CollectionView.delegate = ad3CollectionViewDD
        //data = datasources

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
