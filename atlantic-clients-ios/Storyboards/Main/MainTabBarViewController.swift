//
//  MainTabBarViewController.swift
//  clients-ios
//
//  Created by Jhona on 8/12/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizableViewControllers = []
        self.moreNavigationController.navigationBar.topItem?.title = "Más"
        self.moreNavigationController.tabBarItem = UITabBarItem(title: "Más", image: UIImage(named: "icon-more"), tag: 0)
       
      
        
       
        
       /* if let tabItems = self.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            DispatchQueue.main.async(execute: {
                           let tabItem = tabItems[0]
                           tabItem.badgeValue = "100"
                           tabItem.badgeColor = UIColor.red
            })
            
        }*/
       
    }
}
