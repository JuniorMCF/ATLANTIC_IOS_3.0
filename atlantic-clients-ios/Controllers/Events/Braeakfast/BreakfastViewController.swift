//
//  BreakfastViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/3/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class BreakfastViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: BreakfastViewModelProtocol = BreakfastViewModel()
    
    //Mark: - DataSource
    
    private var BreakfastCollectionViewDD: BreakfastCollectionViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var breakfast: [Breakfast] = []
    var items = [Event]()
    var tipo = ""
    
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    // MARK: - IBoulets
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        // SetupGrid view
        self.setupGridView()
        
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
        BreakfastCollectionViewDD = BreakfastCollectionViewDatasourceAndDelegate(items:  items)
        collectionView.dataSource = BreakfastCollectionViewDD
        collectionView.delegate = self
        self.breakfast = datasource.items
        self.collectionView.reloadData()
    }
    func presentEventDetail(item:Event){
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailID") as! EventsDetailViewController
        viewController.event = item
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension BreakfastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
}
extension BreakfastViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didBreakfastSelected(items[indexPath.row])
    }
}
