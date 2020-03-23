//
//  ProfileAgendaViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/28/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import CarbonKit

class ProfileAgendaViewController: UIViewController , CarbonTabSwipeNavigationDelegate {
    
    var viewModel : ProfileAgendaViewModelProtocol = ProfileAgendaViewModel()
    var items : EventDetailPreview!
    var keys = [String]()
    @IBOutlet weak var searchAgend: UISearchBar!
    @IBOutlet var viewPager: UIView!
    var carbonTabSwipeNavigation : CarbonTabSwipeNavigation!
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
        items = EventDetailPreview()
        if #available(iOS 13.0, *) {
        
            searchAgend.searchBarStyle = .default
            searchAgend.searchTextField.backgroundColor = UIColor.white
            searchAgend.searchTextField.layer.borderColor = UIColor.black.cgColor
            
            searchAgend.searchTextField.textColor = .black
            
            
            
            let glassIconView = searchAgend.searchTextField.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .gray
        }
        
        
    }
    func bind(){
        viewModel.showTitles = showTitles(titles:)
    }
    
    func showTitles(titles:EventDetailPreview){

        items = titles		
        if(titles.tipoList.count == 0){
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)

            
        }else{
            
            for data in titles.tipoList{
                let encontrado = buscarEnLista(element: data, lista: keys)
                if(!encontrado){
                    keys.append(data)
                }
                 //keys.append(data)
                
            }
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : keys, delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            
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
    func buscarEnLista(element:String,lista:[String])->Bool{
        for data in lista{
            if element == data {
                return true
            }
        }
        return false
    }
    
    func removeTabCarbonKit(index:Int){
        
        items.list.remove(at: Int(carbonTabSwipeNavigation.currentTabIndex))
        keys.remove(at: Int(carbonTabSwipeNavigation.currentTabIndex))
        carbonTabSwipeNavigation.view.removeFromSuperview()
        if(keys.count == 0){
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)

            
        }else{
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : keys, delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth/items.tipoList.count
            print(tam)
            for i in 0...items.tipoList.count-1 {
                carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: i)
            }
        }
       //carbonTabSwipeNavigation.setCurrentTabIndex(0, withAnimation: false)
       // self.viewDidLoad()
    }
    func reloadTabCarbonKit(index:Int){
        
        if(keys.count == 0){
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)

            
        }else{
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : keys, delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth/items.tipoList.count
            print(tam)
            for i in 0...items.tipoList.count-1 {
                carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: i)
            }
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "AgendaID") as! AgendaViewController
        if(keys.count>0){
            screen.items = items.list[Int(index)]
            screen.carbonkit = self
            screen.viewPager = viewPager
            screen.index = index
        }
        return screen
    }

}

