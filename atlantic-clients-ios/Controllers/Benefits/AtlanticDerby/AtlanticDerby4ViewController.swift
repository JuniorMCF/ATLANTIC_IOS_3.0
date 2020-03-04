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
    override func viewDidLoad() {
        super.viewDidLoad()
        AD4CollectionView.backgroundColor = .white
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bind(){
        
        viewModel.loadDataSources = loadDatasources(datasources:)
        viewModel.presentTitles = presentTitles(data:)
    }
    func presentTitles(data:[String]){
        titleLabel.setRafflesTitleGoldCenter(with: "¡Ya puedes participar en la carrera!")
       
        carreraLabel.setSubTitleViewLabelCenter(with: "Carrera prueba")
        terminosLabel.setSubTitleViewLabelCenter(with: "Ver términos y condiciones")
        fechaModificacionLabel.setSubTitleViewLabelCenter(with: "actualizado el 28/12/19 a las 09:00 hrs")
    }
    
    func loadDatasources(datasources: [String]) {
        ad4CollectionViewDD = AD4CollectionViewDelegateAndDatasource(items: datasources,
                                                                     viewModel:viewModel)
        AD4CollectionView.dataSource = ad4CollectionViewDD
        AD4CollectionView.delegate = ad4CollectionViewDD
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
