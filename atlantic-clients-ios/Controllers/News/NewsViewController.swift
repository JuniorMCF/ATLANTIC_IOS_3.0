//
//  NewsViewController.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    //
    
    public var imagesDaylies = News()
    public var imagesEvents = News()
    public var imagesGifts = News()
    var tutorialController : TutorialVC!
    private var promotionsCollectionViewDD: PromotionsCollectionViewDelegateAndDatasource!
    private var newsCollectionViewDD: NewsCollectionViewDelegateAndData!
    var viewModel: NewsViewModelProtocol! = NewsViewModel()
    
    // MARK: - IBOulets
    
    @IBOutlet weak var promotionsPageControl: UIPageControl!
    @IBOutlet weak var promotionsCollectionView: UICollectionView!
    @IBOutlet weak var dailyPromotionsLabel: Label!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var eventsLabel: Label!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var giftsLabel: Label!
    @IBOutlet weak var giftsCollectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Noticias", message: "Obteniendo noticias ...")
        appDelegate.progressDialog.isHome = true
        
        super.viewDidLoad()
        definesPresentationContext = true
        //imagenes iniciales
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingID") as! OnBoardingViewController
        viewController.containerParent = self
        viewController.modalPresentationStyle = .overFullScreen
        
        present(viewController, animated: false, completion: nil)
        
       bind()
        viewModel.viewDidLoad(clienteId:appDelegate.usuario.clienteId,nivelId:appDelegate.usuario.nivel)
         
        if let items = self.tabBarController?.tabBar.items as NSArray? {
            let tabItem = items.object(at: 3) as! UITabBarItem
            tabItem.badgeValue = " "
            tabItem.badgeColor = UIColor.init(red: 251/255, green: 204/255, blue: 52/255, alpha: 1)
        }
        
    }
    
    func showTutorial(){
        let showCasePrincipal = BubbleShowCase(target: view, arrowDirection: .upAndDown)
        showCasePrincipal.color = UIColor.init(red: 130/255, green: 110/255, blue: 78/255, alpha: 1)
        showCasePrincipal.titleText = "Bienvenido (a)"
        showCasePrincipal.margins = 30
        showCasePrincipal.controller = self
        showCasePrincipal.descriptionText = "Descubra todo lo que puede realizar en ATLANTIC CITY INFO para móviles"
        showCasePrincipal.show()
              
              let showCaseOnNavBar1 =  BubbleShowCase(tabBar: tabBarController!.tabBar, index: 0, label: "tabBar")
              showCaseOnNavBar1.titleText = ""
              showCaseOnNavBar1.textColor = UIColor.black
              showCaseOnNavBar1.controller = self
              showCaseOnNavBar1.position = 1
              showCaseOnNavBar1.descriptionText = "Conozca las promociones y eventos próximos"
              showCaseOnNavBar1.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
              
              let showCaseOnNavBar2 =  BubbleShowCase(tabBar: tabBarController!.tabBar, index: 1, label: "tabBar2")
              showCaseOnNavBar2.titleText = ""
              showCaseOnNavBar2.textColor = UIColor.black
              showCaseOnNavBar2.controller = self
              showCaseOnNavBar2.position = 2
              showCaseOnNavBar2.descriptionText = "¡Consulte la información actualizada de sus cobros!"
              showCaseOnNavBar2.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
              
              let showCaseOnNavBar3 =  BubbleShowCase(tabBar: tabBarController!.tabBar, index: 2, label: "tabBar3")
              showCaseOnNavBar3.titleText = ""
              showCaseOnNavBar3.textColor = UIColor.black
              showCaseOnNavBar3.controller = self
              showCaseOnNavBar3.position = 3
              showCaseOnNavBar3.descriptionText = "Encuentre promociones, beneficios y torneos"
              showCaseOnNavBar3.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
              
              let showCaseOnNavBar4 =  BubbleShowCase(tabBar: tabBarController!.tabBar, index: 3, label: "tabBar4")
              showCaseOnNavBar4.titleText = ""
              showCaseOnNavBar4.textColor = UIColor.black
              showCaseOnNavBar4.controller = self
              showCaseOnNavBar4.position = 4
              showCaseOnNavBar4.descriptionText = "Revise nuestros eventos del mes"
              showCaseOnNavBar4.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
              
              let showCaseOnNavBar5 =  BubbleShowCase(tabBar: tabBarController!.tabBar, index: 4, label: "tabBar5")
              showCaseOnNavBar5.titleText = ""
              showCaseOnNavBar5.textColor = UIColor.black
              showCaseOnNavBar5.controller = self
              showCaseOnNavBar5.position = 5
              showCaseOnNavBar5.descriptionText = "Desde aquí configure sus datos personales"
              showCaseOnNavBar5.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
              
              
              showCasePrincipal.concat(bubbleShowCase: showCaseOnNavBar1)
              showCaseOnNavBar1.concat(bubbleShowCase: showCaseOnNavBar2)
              showCaseOnNavBar2.concat(bubbleShowCase: showCaseOnNavBar3)
              showCaseOnNavBar3.concat(bubbleShowCase: showCaseOnNavBar4)
              showCaseOnNavBar4.concat(bubbleShowCase: showCaseOnNavBar5)
        
        
           // addSubview(viewController2.view)
        
    }
    
    func prepareCollectionViews() {
        // Flow Promotions
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: 400, height: promotionsCollectionView.frame.height)
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        
        // Flow Promotions
        let flow2 = UICollectionViewFlowLayout()
        flow2.itemSize = CGSize(width: 100, height: dailyCollectionView.frame.height)
        flow2.scrollDirection = .horizontal
        flow2.minimumInteritemSpacing = 8
        flow2.minimumLineSpacing = 8

        promotionsCollectionView.collectionViewLayout = flow
        promotionsCollectionView.collectionViewLayout.invalidateLayout()
        dailyCollectionView.collectionViewLayout = flow2
        dailyCollectionView.collectionViewLayout.invalidateLayout()
        
        eventsCollectionView.collectionViewLayout = flow2
        eventsCollectionView.collectionViewLayout.invalidateLayout()
        
        giftsCollectionView.collectionViewLayout = flow2
        giftsCollectionView.collectionViewLayout.invalidateLayout()
        
        
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.loadDatasources = loadDatasources(datasources:)
    }
    
    func loadDatasources(datasources: NewsDatasources) {
        promotionsCollectionViewDD = PromotionsCollectionViewDelegateAndDatasource(items: datasources.promotions,pageControl: promotionsPageControl)
        promotionsCollectionView.dataSource = promotionsCollectionViewDD
        promotionsCollectionView.delegate = promotionsCollectionViewDD
        
        imagesDaylies = datasources.dailys
        imagesEvents = datasources.events
        imagesGifts = datasources.gifts
        
        //News
        newsCollectionViewDD = NewsCollectionViewDelegateAndData(dailyPromotions: datasources.dailys, eventWeeks: datasources.events, giftsWeeks: datasources.gifts)
        newsCollectionViewDD.dailyCollectionView = dailyCollectionView
        newsCollectionViewDD.giftsCollectionView = giftsCollectionView
        newsCollectionViewDD.eventsCollectionView = eventsCollectionView
        newsCollectionViewDD.parentController = self
        
        dailyCollectionView.dataSource = newsCollectionViewDD
        dailyCollectionView.delegate = newsCollectionViewDD
        
        giftsCollectionView.dataSource = newsCollectionViewDD
        giftsCollectionView.delegate = newsCollectionViewDD
        
        eventsCollectionView.dataSource = newsCollectionViewDD
        eventsCollectionView.delegate = newsCollectionViewDD
        
        dailyPromotionsLabel.text = datasources.dailys.title
        eventsLabel.text = datasources.events.title
        giftsLabel.text =  datasources.gifts.title
        
    }
    
    func showTitles(titles: NewsTitles) {
        
        dailyPromotionsLabel.setSubTitleViewLabel(with: imagesDaylies.title)
        eventsLabel.setSubTitleViewLabel(with: imagesEvents.title)
        giftsLabel.setSubTitleViewLabel(with: imagesGifts.title)
    }
    
    
}

