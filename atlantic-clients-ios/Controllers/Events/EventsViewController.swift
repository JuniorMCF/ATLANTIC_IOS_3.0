//
//  EventsViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/3/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import CarbonKit

class EventsViewController: UIViewController, CarbonTabSwipeNavigationDelegate {
    
    var viewModel: EventsViewModelProtocol! = EventsViewModel()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var items = EventDetailPreview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Eventos", message: "Obteniendo eventos ...")
        
        bind()
        viewModel.viewDidLoad()
        
        
    }
    func bind(){
        viewModel.showTitles = showTitles(titles:)
        
    }
    
    func showTitles(titles:EventDetailPreview){
        items = titles
        if(titles.tipoList.count == 0){
            let carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = false
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)

            
        }else{
            var keys = [String]()
            for data in titles.tipoList{
                keys.append(data)
            }
            let carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : keys, delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = false
            
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth/titles.tipoList.count
            print(tam)
            for i in 0...titles.tipoList.count-1 {
                carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: i)
            }
            
        }
        
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "BreakfastID") as! BreakfastViewController
        if(items.list.count>0){
            screen.items = items.list[Int(index)]
        }
        //screen.tipo = items[Int(index)].tipo
        return screen
    }

}
