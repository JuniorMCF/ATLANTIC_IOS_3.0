//
//  PaymentViewController.swift
//  clients-ios
//
//  Created by Jhona on 7/31/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    // Mark: - ViewModel
    
    private var viewModel: PaymentsViewModelProtocol = PaymentsViewModel()
    
    //Mark: - DataSource
    
    private var paymentsTableViewDD: PaymentsTableViewDelegateAndDatasource!
    
    // Mark: - Properties
    
    @IBOutlet weak var paymentSearchBar: UISearchBar!
    @IBOutlet weak var paymentsTableView: UITableView!
    
    var payments: [Cobros] = []
    var currentPaymentsArray: [Cobros] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Cobros", message: "Obteniendo cobros ...")
        appDelegate.progressDialog.isHome = true
        
        bind()
        viewModel.viewDidLoad()
        addTapGesture()
        paymentSearchBar.delegate = self
        paymentSearchBar.placeholder = "Buscar"
    }
    
    func bind() {
        viewModel.loadDatasources = loadDatasources(datasource:)
        viewModel.reloadDatasource = loadDatasources(datasource:)
    }
    
    func loadDatasources(datasource:[Cobros]) {
        paymentsTableViewDD = PaymentsTableViewDelegateAndDatasource(items: datasource)
        paymentsTableView.dataSource = paymentsTableViewDD
        self.payments = datasource
        self.paymentsTableView.reloadData()
    }
    
    func reloadDatasource(datasource: [Cobros]) {
        self.payments = datasource
        self.paymentsTableView.reloadData()
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension PaymentViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchText)
    }
    
}
