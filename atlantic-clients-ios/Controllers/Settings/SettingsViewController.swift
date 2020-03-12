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
    @IBOutlet var switchActive: UISwitch!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.viewDidLoad(clienteId: String(appDelegate.usuario.clienteId), isActivo: false)
        
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
    }
    
    func showTitles(titles: SettingsTitles) {
        let estadoSwitch = appDelegate.switchState
        activeLabel.setSubTitleViewLabel(with: titles.activeTitle)
        changePasswordLabel.setSubTitleViewLabel(with: titles.changePassword)
        
    }

}
