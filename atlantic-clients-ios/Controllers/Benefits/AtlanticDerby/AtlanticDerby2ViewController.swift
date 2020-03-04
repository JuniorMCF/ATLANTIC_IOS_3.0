//
//  AtlanticDerby2ViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AtlanticDerby2ViewController: UIViewController {

    private var ad2CollectionViewDD: AD2CollectionViewDelegateAndDatasource!
    
    var viewModel: AtlanticDerby2ViewModelProtocol! = AtlanticDerby2ViewModel()
    
    var benefit = Benefits()
    
    @IBOutlet var AD2CollectionView: UICollectionView!
    @IBOutlet var fechaLabel: Label!
    @IBOutlet var titleLabel: Label!
    
    @IBOutlet var proximaCarreraLabel: Label!
    
    @IBOutlet var recordatorioButton: Button!
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var fechaModificacionLabel: Label!
    override func viewDidLoad() {
        super.viewDidLoad()
        AD2CollectionView.layer.cornerRadius = 20
        AD2CollectionView.backgroundColor = .gray
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bind(){
        
        viewModel.loadDataSources = loadDatasources(datasources:)
        viewModel.presentTitles = presentTitles(data:)
    }
    func presentTitles(data:[String]){
        fechaLabel.setBenefitDetailTitleCenter(with: "¡Pronto tendrá mas opciones de ganar!")
        titleLabel.setBenefitDetailTitleCenter(with: "Carrera")
        proximaCarreraLabel.setSubTitleViewLabelCenter(with: "Próxima carrera:\n Carrera diamante a las 22:00hrs")
        recordatorioButton.setRemindButton(with: "Crear recordatorio")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        fechaModificacionLabel.setSubTitleViewLabel(with: "actualizado el 28/12/19 a las 09:00 hrs")
    }
    
    func loadDatasources(datasources: [String]) {
        ad2CollectionViewDD = AD2CollectionViewDelegateAndDatasource(items: datasources,
                                                                     viewModel:viewModel)
        AD2CollectionView.dataSource = ad2CollectionViewDD
        AD2CollectionView.delegate = ad2CollectionViewDD
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
