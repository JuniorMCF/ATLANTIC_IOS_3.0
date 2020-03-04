//
//  AllBenefitsViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/14/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class AllBenefitsViewController: UIViewController {
    
    private var allBenefitsCollecionViewDD : AllBenefitsCollectionViewDelegateAndDatasource!
    // Mark: - ViewModel
    
    private var viewModel: AllBenefitsViewModelProtocol = AllBenefitsViewModel()
    
    // Mark: - Properties
    
    var titles: [AllBenefitsTitles] = []
    var fotos = [Foto]()
    
    var benefit = Benefits()
    // Mark: - Outlets
    var posicion = 0
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var underLineView: UIView!
    @IBOutlet var tabBar: UINavigationItem!
    @IBOutlet weak var dateSwapLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var reminderButton: Button!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var awardTitleLabel: Label!
    @IBOutlet var puntosLabel: Label!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        viewModel.viewDidLoad()
    }
    
    @IBAction func rightCV(_ sender: Any) {
        if(posicion < fotos.count-1){
            let lastSection = collectionView.numberOfSections - 1

            let indexPath = IndexPath(row: posicion+1, section: lastSection)

            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            posicion += 1
        }
        
    }
    
    @IBAction func leftCV(_ sender: Any) {
        if(posicion > 0){
            let lastSection = collectionView.numberOfSections - 1

            let indexPath = IndexPath(row: posicion-1, section: lastSection)

            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            posicion -= 1
        }
    }
    

    func bind() {
        viewModel.showTitles = showTitles(titles: )
        loadDatasources(datasource:benefit)
        
    }
    func loadDatasources(datasource: Benefits) {
        allBenefitsCollecionViewDD = AllBenefitsCollectionViewDelegateAndDatasource(items:datasource.fotos, viewModel: viewModel, pageControl: self.pageControl,collectionView: collectionView)
        collectionView.dataSource =  allBenefitsCollecionViewDD
        collectionView.delegate = allBenefitsCollecionViewDD
        
        self.fotos = datasource.fotos
        self.collectionView.reloadData()
    }
    
    func showTitles(titles: AllBenefitsTitles) {
        if(benefit.nombre == "Domingos Regalones" || benefit.nombre == "Martes Regalones"){
            tabBar.title = benefit.nombre
            dateSwapLabel.setRafflesTitleGold(with: benefit.nombre)
            dateLabel.setBenefitDetailTitle(with: "Fecha: "+titles.dateSwap)
            underLineView.alpha = 1.0
            reminderButton.setRemindButton(with: titles.reminderTitle)
            
            //transformar el formato de fecha  dd/MM/yy    y   la hora  hh:mm
            pointsLabel.setRafflesSubUnderline(with: "Vér terminos y condiciones")
            
            let fecha = (benefit.fechaActualizacion as NSString).doubleValue
            let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"
            dateFormatter.locale = NSLocale.current
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            dateFormatter2.locale = NSLocale.current
            dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")
            let txtFecha = dateFormatter.string(from: date)
            let txtHour = dateFormatter2.string(from: date)
            
            
            
            awardTitleLabel.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
            
            
        }else{
            tabBar.title = "Beneficios"
            dateSwapLabel.setRafflesTitleGoldCenter(with: benefit.nombre)
            dateLabel.setBenefitDetailTitleCenter(with: "Fecha: "+titles.dateSwap)
            underLineView.alpha = 0.0
            reminderButton.setRemindButton(with: titles.reminderTitle)
            
            
            //transformar el formato de fecha  dd/MM/yy    y   la hora  hh:mm
            pointsLabel.setRafflesSubUnderline(with: "Vér terminos y condiciones")
            awardTitleLabel.setDateModify(with: "actualizado el "+benefit.fecha+" a las ")
        }
        
        
    }

}
