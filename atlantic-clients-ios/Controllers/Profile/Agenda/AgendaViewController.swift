//
//  AgendaViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import CarbonKit
class AgendaViewController: UIViewController {
        // Mark: - ViewModel
        
        private var viewModel: AgendaViewModelProtocol = AgendaViewModel()
        
        //Mark: - DataSource
        
        private var AgendaCollectionViewDD: AgendaCollectionViewDatasourceAndDelegate!
        
        // Mark: - Properties
        
        var agenda = Event()
        var items = [Event]()
        var tipo = ""
        
        var estimateWidth = 300.0
        var cellMarginSize = 16.0
        var carbonkit : ProfileAgendaViewController!
        var viewPager: UIView!
        var index:UInt!
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
            viewModel.actualizarLista = actualizarLista(eventoRegistroId: clienteId: index:)
            viewModel.presentToast = show(message:)
            viewModel.presentReloadData = reloadCarbonKit(eventos:)
            viewModel.removeItemEvent = removeItemEvent(index:)
        }
        func show(message:String){
            showToast(message: message)
        }
        func removeItemEvent(index:Int){
            for index in 0...items.count-1{
                if items[index].id == items[index].id{
                    items.remove(at:index )
                    break
                }
            }
            reloadCarbonKit(eventos: items)
        }
        func actualizarLista(eventoRegistroId:String,clienteId:String,index:Int){
            //
            viewModel.deleteData(eventoRegistroId: eventoRegistroId, clienteId: clienteId,index: index)
            
        }
        func presentReloadData(list:[Event]){
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  list,viewModel: viewModel, viewParent: self)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = self
            self.collectionView.reloadData()
            
        }
        
        func loadDatasources(datasource:BreakfastDatasources) {
           
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  items,viewModel: viewModel,viewParent: self)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = self
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
    
    func reloadCarbonKit(eventos:[Event]){
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  eventos,viewModel: viewModel, viewParent: self)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = self
            self.collectionView.reloadData()
        
        
            var tipoList = [String]()
            for data in eventos{
                tipoList.append(data.nombreTipo)
            }
        
        
            if(tipoList.count == 0){
                /*let carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : carbonkit)
                carbonTabSwipeNavigation.insert(intoRootViewController: carbonkit, andTargetView: viewPager)
                carbonTabSwipeNavigation.setIndicatorColor(.black)
                carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
                carbonTabSwipeNavigation.setSelectedColor(.black)
                carbonTabSwipeNavigation.toolbar.isTranslucent = true
                carbonTabSwipeNavigation.toolbar.shadow = true
                carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
                let screenSize: CGRect = UIScreen.main.bounds
                let screenWidth = Int(screenSize.width)
                let tam = screenWidth
                carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)*/
                
               //
                carbonkit.removeTabCarbonKit(index: Int(index))
            
            }else{
                
                carbonkit.reloadTabCarbonKit(index: Int(index))
                
            }
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
