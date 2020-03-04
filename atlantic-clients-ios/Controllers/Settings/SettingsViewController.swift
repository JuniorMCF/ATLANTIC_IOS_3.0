//
//  SettingsViewController.swift
//  clients-ios
//
//  Created by Jhona on 8/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModelProtocol! = SettingsViewModel()
    
    @IBOutlet weak var activeLabel: Label!
    @IBOutlet weak var changePasswordLabel: Label!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.viewDidLoad()
        
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
    }
    
    func showTitles(titles: SettingsTitles) {
        activeLabel.setSubTitleViewLabel(with: titles.activeTitle)
        changePasswordLabel.setSubTitleViewLabel(with: titles.changePassword)
    }

}
