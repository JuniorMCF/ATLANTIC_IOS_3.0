//
//  AtlanticDerby4ViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AtlanticDerby4ViewController: UIViewController {

    private var ad4CollectionViewDD: AD4CollectionViewDelegateAndDatasource!
    
    var viewModel: AtlanticDerby4ViewModelProtocol! = AtlanticDerby4ViewModel()

    var benefit = Benefits()
    
    @IBOutlet var titleLabel: Label!
    
    @IBOutlet var carreraLabel: Label!
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var fechaModificacionLabel: Label!
    
    @IBOutlet var AD4CollectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        AD4CollectionView.backgroundColor = .white
        bind()
        let fechaActual = Utils().getFechaActual()
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: benefit.nombre, promocionId: String(benefit.promocion_id))
        viewModel.viewDidLoad(nombre: benefit.nombre)
        
    }
    func bind(){
        viewModel.loadDataSources = loadDatasources(datasources:)
        viewModel.presentTitles = presentTitles(data:)
    }
    func presentTitles(data:[String]){
        titleLabel.setRafflesTitleGoldCenter(with: "¡Ya puedes participar en la carrera!")
       
        carreraLabel.setSubTitleViewLabelCenter(with: benefit.nombre)
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
        
        fechaModificacionLabel.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))

    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showProgress()
    }
    func loadDatasources(datasources: [String]) {
        ad4CollectionViewDD = AD4CollectionViewDelegateAndDatasource(items: datasources,viewModel:viewModel)
        AD4CollectionView.dataSource = ad4CollectionViewDD
        AD4CollectionView.delegate = ad4CollectionViewDD
    }

}
