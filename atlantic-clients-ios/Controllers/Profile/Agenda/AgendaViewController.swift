//
//  AgendaViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController {
        // Mark: - ViewModel
        
        private var viewModel: AgendaViewModelProtocol = AgendaViewModel()
        
        //Mark: - DataSource
        
        private var AgendaCollectionViewDD: AgendaCollectionViewDatasourceAndDelegate!
        
        // Mark: - Properties
        
        var breakfast: [Breakfast] = []
        var items = [Event]()
        var tipo = ""
        
        var estimateWidth = 300.0
        var cellMarginSize = 16.0
        
        // MARK: - IBoulets
        
        @IBOutlet weak var collectionView: UICollectionView!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var progress :CustomProgress!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.register(UINib(nibName: "AgendaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AgendaCellID")
            // SetupGrid view
            self.setupGridView()
            progress = CustomProgress(parent: self, title: "Eventos", message: "Obteniendo eventos ...")
            progress.isHome = true
            progress.showProgress()
            bind()
            viewModel.viewDidLoad()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            self.setupGridView()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        func setupGridView() {
            let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
            flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        }

        func bind() {
            viewModel.loadDatasources = loadDatasources(datasource:)
            viewModel.presentEventDetail = presentEventDetail(item:)
        }
        
        func loadDatasources(datasource:BreakfastDatasources) {
           
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  items,viewModel: viewModel)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = AgendaCollectionViewDD
            self.breakfast = datasource.items
            self.collectionView.reloadData()
            progress.hideProgress()
            
        }
        func presentEventDetail(item:Event){
            let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailID") as! EventsDetailViewController
            viewController.event = item
            viewController.tipo = "0"
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
        }

    }

    extension AgendaViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = self.calculateWith()
            return CGSize(width: width, height: width/3)
        }
        
        func calculateWith() -> CGFloat {
            let estimatedWidth = CGFloat(estimateWidth)
            let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
            
            let margin = CGFloat(cellMarginSize * 2)
            let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
            return width
        }
    }
    extension AgendaViewController: UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            viewModel.didEventSelected(event: items[indexPath.row])
        }
    }
