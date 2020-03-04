//
//  ForgotPasswordViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/1/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation


struct ForgotPasswordTitles {
    
    var screenTitle: String = "Elija su tipo de documento"
    var dniPlaceholder: String = "DNI"
    var recoveryPassword : String = "Continuar"
    
}

protocol ForgotPasswordViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()

    func tapForgotPassword()
    // Outputs
    
    var showTitles: ((ForgotPasswordTitles) -> Void)? { get set }

    var presentForgotPassword:(()->Void)?{get set}
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    
  
    var showTitles: ((ForgotPasswordTitles) -> Void)?

    var presentForgotPassword: (() -> Void)?
    
    func viewDidLoad() {
        let titles = ForgotPasswordTitles()
        showTitles?(titles)
    }
    
    func tapForgotPassword() {
        
    }

}
