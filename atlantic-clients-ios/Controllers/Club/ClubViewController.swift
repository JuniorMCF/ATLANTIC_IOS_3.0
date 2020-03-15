//
//  ClubViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/7/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class ClubViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: ClubViewModelProtocol = ClubViewModel()
    
    //Mark: - DataSource
    
    private var clubTableViewDD: ClubTableViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    @IBOutlet weak var clubTableView: UITableView!
    
    var category: [ClubCategory] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        let tabHeight = self.parent?.tabBarController?.tabBar.frame.size.height
        clubTableView.rowHeight = ((self.parent?.view.frame.height)! - tabHeight! - height ) / 3
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {
        viewModel.loadDatasources = loadDatasources
        viewModel.presentClubCategory = presentClubCategory
    }
    
    func loadDatasources(datasource: ClubDatasources) {
        clubTableViewDD = ClubTableViewDatasourceAndDelegate(items: datasource.items, viewModel: viewModel)
        clubTableView.dataSource = clubTableViewDD
        clubTableView.delegate = clubTableViewDD
        self.category = datasource.items
        self.clubTableView.reloadData()
    }
    
    func presentClubCategory(type: ClubCategoryTypes) {
        switch type {
            case .sorteo:
                let storyboard = UIStoryboard(name: "Raffles", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "RafflesID")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            case .beneficios:
                let storyboard = UIStoryboard(name: "Benefits", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "BenefitsID")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            case .torneos:
                let storyboard = UIStoryboard(name: "Tourneys", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TourneysID")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
            return
        }
    }

}
