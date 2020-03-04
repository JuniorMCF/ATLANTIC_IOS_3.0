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
    override func viewDidLoad() {
        super.viewDidLoad()
        AD3CollectionView.layer.cornerRadius = 20
        AD3CollectionView.backgroundColor = .gray
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bind(){
        
        viewModel.loadDataSources = loadDatasources(datasources:)
        viewModel.presentTitles = presentTitles(data:)
    }
    func presentTitles(data:[String]){
        titleLabel.setRafflesTitleGoldCenter(with: "¡Ha ganado!")
        puestoLabel.setSubTitleViewLabelCenter(with: "1er puesto-carrera oro")
        gananciaLabel.setSubTitleViewLabelCenter(with: "$50")
        resultadoTitle.setRafflesSubTitleCenter(with: "Resultados:")
        
        cobrosButton.setRemindButton(with: "IR A MIS COBROS")
        proximaCarreraLabel.setSubTitleViewLabelCenter(with: "Próxima carrera:\n Carrera diamante 12:00hrs")
       
       
        recordatorioButton.setRemindButton(with: "Crear recordatorio")
       
        terminosLabel.setSubTitleViewLabelCenter(with: "Ver términos y condiciones")
        fechaActualizacionLabel.setSubTitleViewLabelCenter(with: "actualizado el 28/12/19 a las 09:00 hrs")
    }
    
    func loadDatasources(datasources: [String]) {
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
