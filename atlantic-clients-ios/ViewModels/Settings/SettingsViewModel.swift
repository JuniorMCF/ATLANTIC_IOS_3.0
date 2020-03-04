//
//  SettingsViewModel.swift
//  clients-ios
//
//  Created by Jhona on 8/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct SettingsTitles {
    
    var activeTitle: String = "Activar / Desactivar"
    var changePassword: String = "Cambiar Contraseña"
    
}

protocol SettingsViewModelProtocol {
    
    //Inputs
    
    func viewDidLoad()
    
    //Outputs
    
    var showTitles: ((SettingsTitles) -> Void)? { get set }
    
}

class SettingsViewModel: SettingsViewModelProtocol {
    
    var showTitles: ((SettingsTitles) -> Void)?
    
    func viewDidLoad() {
        let titles = SettingsTitles()
        showTitles?(titles)
    }
    
}
