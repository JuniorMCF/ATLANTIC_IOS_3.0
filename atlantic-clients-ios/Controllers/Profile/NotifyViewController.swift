//
//  AgendaViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/26/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class NotifyViewController: UIViewController {
    var viewModel: NotifyViewModelProtocol! = NotifyViewModel()
    private var agendaCollectionViewDD: NotifyDatasourceAndDelegate!
    
    var agendaList = [Notify]()
    @IBOutlet var agendaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bind(){
        viewModel.loadDatasources = loadDatasources(datasource:)
        viewModel.showTitles = showTitles(items:)
    }
    func showTitles(items: [Notify]){
        
    }
    
    
    func loadDatasources(datasource: [Notify]) {
        agendaCollectionViewDD = NotifyDatasourceAndDelegate(items: datasource, viewModel: viewModel)
        agendaCollectionView.dataSource = agendaCollectionViewDD
        agendaCollectionView.delegate = agendaCollectionViewDD
        self.agendaList = datasource
        self.agendaCollectionView.reloadData()
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
