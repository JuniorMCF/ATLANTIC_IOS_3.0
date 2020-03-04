//
//  TrophyDetailViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/10/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class TrophyDetailViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: TrophyDetailViewModelProtocol = TrophyDetailViewModel()
    
    //Mark: - DataSource & Delegate
    
    private var TrophyDetailCollectionViewDD: TrophyDetailCollectionViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var positions: [Positions] = []
    
    var torneo = Tournament()
    // Mark: - Outlets
    
    @IBOutlet weak var stateLabel: Label!
    @IBOutlet weak var positionLabel: Label!
    @IBOutlet weak var positionTitleLabel: Label!
    @IBOutlet weak var pointsTitleLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var positionView: UIView!
    
    @IBOutlet weak var titlePositionLabel: Label!
    @IBOutlet weak var titleNameLabel: Label!
    @IBOutlet weak var titlePointsLabel: Label!
    @IBOutlet weak var titleAwardsLabel: Label!
    
    @IBOutlet weak var positionsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        
        positionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPositionView)))

        bind()
        viewModel.viewDidLoad()
    }
    
    @objc private func tapPositionView() {
        viewModel.tapPosition()
    }
    
    func prepare() {
        // Flow Promotions
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: view.frame.width - 24, height: 60.0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 8
        positionsCollectionView.collectionViewLayout = flow
    }
    
    func bind() {
        
        viewModel.showTitles = showTitles(titles: )
        viewModel.loadDatasources = loadDatasources
        viewModel.presentPositionDetail = presentPositionDetail
    }
    
    func showTitles(titles: TrophyDetailTitles) {
        
        stateLabel.setCategorySubTitle(with: titles.stateTitle)
        positionLabel.setCategoryTitle(with: titles.position)
        positionTitleLabel.setCategorySubTitle(with: titles.positionTitle)
        pointsTitleLabel.setCategorySubTitle(with: titles.pointsTitle)
        pointsLabel.setCategoryTitle(with: titles.points)
        
        titlePositionLabel.setCategorySubTitle(with: titles.titlePosition)
        titleNameLabel.setCategorySubTitle(with: titles.titleName)
        titlePointsLabel.setCategorySubTitle(with: titles.titlePoints)
        titleAwardsLabel.setCategorySubTitle(with: titles.titleAwards)
    }
    
    func loadDatasources(datasource: PositionsDatasource) {
        TrophyDetailCollectionViewDD = TrophyDetailCollectionViewDatasourceAndDelegate(items: datasource.items, viewModel: viewModel)
        positionsCollectionView.dataSource = TrophyDetailCollectionViewDD
        self.positions = datasource.items
        self.positionsCollectionView.reloadData()
    }
    
    func presentPositionDetail() {
        let storyboard = UIStoryboard(name: "PositionDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetailID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }


}
