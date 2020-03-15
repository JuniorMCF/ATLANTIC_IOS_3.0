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
    @IBOutlet var changePasswordView: UIView!

    @IBAction func isCheckedSwitch(_ sender: Any) {
        let check = sender as! UISwitch
        if(check.isOn == true){
            viewModel.changeSettings(clienteId: appDelegate.usuario.clienteId, isActivo: true)
        }else{
            viewModel.changeSettings(clienteId: appDelegate.usuario.clienteId, isActivo: false)
        }
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        if(appDelegate.usuario.configNotify == true){
            switchActive.isOn = true
        }else{
            switchActive.isOn = false
        }
        
        
        viewModel.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapChangePassword(_:)))

        changePasswordView.addGestureRecognizer(tap)

        changePasswordView.isUserInteractionEnabled = true
 
        
    }
    @objc func tapChangePassword(_ sender: UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "ChangePassword", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordID")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
    }
    
    func showTitles(titles: SettingsTitles) {
        
        activeLabel.setSubTitleViewLabel(with: titles.activeTitle)
        changePasswordLabel.setSubTitleViewLabel(with: titles.changePassword)
        
    }

}
