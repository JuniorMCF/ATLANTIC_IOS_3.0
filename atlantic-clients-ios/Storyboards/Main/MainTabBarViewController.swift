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
        
    }
}
