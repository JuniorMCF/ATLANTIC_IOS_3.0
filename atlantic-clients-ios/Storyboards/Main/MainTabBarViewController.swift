//
//  MainTabBarViewController.swift
//  clients-ios
//
//  Created by Jhona on 8/12/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.customizableViewControllers = []
        self.moreNavigationController.navigationBar.topItem?.title = "Más"
        self.moreNavigationController.tabBarItem = UITabBarItem(title: "Más", image: UIImage(named: "icon-more"), tag: 0)
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.tabBarController = self
            }
            
        }
        appDelegate.tabBarController = self
       
       
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
     
        print("Selected item")
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        let tabBarIndex = self.selectedIndex
        
        tabBarController.selectedIndex = tabBarIndex
        let navController = tabBarController.selectedViewController as! UINavigationController
        navController.popToRootViewController(animated: false)
        
        
        if(tabBarIndex == 1 ){
            Constants().saveBody(isActive: false, key: "body0")
            viewController.tabBarItem.badgeValue = nil;
        }
        if(tabBarIndex == 3 ){
            Constants().saveBody(isActive: false, key: "body4")
            viewController.tabBarItem.badgeValue = nil;
        }
        
    }
    
    
    func checkNotifications(){
        var position = 0
        let body0 = Constants().getBody(key: "body0")
        let body1 = Constants().getBody(key: "body1")
        let body2 = Constants().getBody(key: "body2")
        let body3 = Constants().getBody(key: "body3")
        let body4 = Constants().getBody(key: "body4")
        
        if(body0){
            position = 1
            if let items = self.tabBar.items as NSArray? {
                let tabItem = items.object(at: position) as! UITabBarItem
                tabItem.badgeValue = " "
                tabItem.badgeColor = UIColor.init(red: 251/255, green: 204/255, blue: 52/255, alpha: 1)
            }
        }
        if(body1 || body2 || body3){
            position = 2
            if let items = self.tabBar.items as NSArray? {
                let tabItem = items.object(at: position) as! UITabBarItem
                tabItem.badgeValue = " "
                tabItem.badgeColor = UIColor.init(red: 251/255, green: 204/255, blue: 52/255, alpha: 1)
            }
        }
        if(body4){
            position = 3
            if let items = self.tabBar.items as NSArray? {
                let tabItem = items.object(at: position) as! UITabBarItem
                tabItem.badgeValue = " "
                tabItem.badgeColor = UIColor.init(red: 251/255, green: 204/255, blue: 52/255, alpha: 1)
            }
        }
        
            
        
        
    }
}
