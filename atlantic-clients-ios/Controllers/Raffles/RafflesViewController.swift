//
//  RafflesViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/7/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class RafflesViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: RafflesViewModelProtocol = RafflesViewModel()
    
    //Mark: - DataSource & Delegate
    
    private var rafflesTableViewDD: RafflesTableViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var category: [Sorteo] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var rafflesTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Sorteos", message: "Obteniendo sorteos ...")
        appDelegate.progressDialog.isHome = true
        
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {
        viewModel.loadDatasources = loadDatasources
        viewModel.presentRafflesCategory = presentRafflesCategory
    }
    
    func loadDatasources(datasource: [Sorteo]) {
        rafflesTableViewDD = RafflesTableViewDatasourceAndDelegate(items: datasource, viewModel: viewModel)
        rafflesTableView.dataSource = rafflesTableViewDD
        rafflesTableView.delegate = rafflesTableViewDD
        self.category = datasource
        self.rafflesTableView.reloadData()
    }
    
    func presentRafflesCategory(type: Sorteo) {
        let storyboard = UIStoryboard(name: "RafflesDream", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RafflesDreamID") as! RafflesDreamViewController
        viewController.sorteo = type
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
