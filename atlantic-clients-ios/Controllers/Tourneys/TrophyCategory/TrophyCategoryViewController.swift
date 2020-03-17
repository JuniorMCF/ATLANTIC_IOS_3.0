//
//  TrophyCategoryViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class TrophyCategoryViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: TrophyCategoryViewModelProtocol = TrophyCategoryViewModel()
    
    //Mark: - DataSource
    
    private var trophyCategoryTableViewDD: TrophyCategoryTableViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var trophyCategory: [Tournament] = []
    
    var tipo = ""
    // Mark: - Outlets
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet weak var trophyCategoryTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bind()
        viewModel.viewDidLoad(tipo:tipo,clienteId:appDelegate.usuario.clienteId)
    }
    
    func bind() {
        viewModel.loadDatasources = loadDatasources(datasource: )
        viewModel.presentTrophyCategory = presentTrophyCategory(tournament: )
        
    }
    
    func loadDatasources(datasource: [Tournament]) {
        trophyCategoryTableViewDD = TrophyCategoryTableViewDatasourceAndDelegate(items: datasource, viewModel: viewModel)
        trophyCategoryTableView.dataSource =  trophyCategoryTableViewDD
        trophyCategoryTableView.delegate = trophyCategoryTableViewDD
        

        terminosLabel.setRafflesSubUnderline(with: "términos y condiciones")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))


        self.trophyCategory = datasource
        self.trophyCategoryTableView.reloadData()
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "url")
        terminos.showProgress()
    }
    func presentTrophyCategory(tournament: Tournament) {
        if(tournament.concluido){
            if(tournament.posicion > 40){
                let storyboard = UIStoryboard(name: "PositionDetail40", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetail40ID") as! PositionDetail40ViewController
                viewController.modalPresentationStyle = .fullScreen
                viewController.torneo = tournament
                self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                let storyboard = UIStoryboard(name: "PositionDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetailID") as! PositionDetailViewController
                viewController.modalPresentationStyle = .fullScreen
                viewController.torneo = tournament
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
            return
        }else{
           //grandprix detail
            let storyboard = UIStoryboard(name: "TrophyLose", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "TrophyLoseID") as! TrophyLoseViewController
            viewController.torneo = tournament
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
            return
        }
    }
}
