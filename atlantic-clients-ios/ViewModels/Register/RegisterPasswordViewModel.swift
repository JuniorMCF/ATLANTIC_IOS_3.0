//
//  RegisterPasswordViewModel.swift
//  clients-ios
//
//  Created by Jhona on 7/25/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct RegisterPasswordTitles {
    
    var screenTitle: String = "ÚNASE A NUESTRA GRAN FAMILIA"
    var phoneNumberPlaceholder: String = "Número de celular"
    var passwordPlaceholder: String = "Ingrese una clave"
    var passwordSpecsTitle: String = "Su clave debe tener como máximo 4 dígitos, pueden ser números y letras."
    var passwordConfirmPlaceholder: String = "Repita su clave"
    var registerButtonTitle: String = "Registrarse"
    
}

protocol RegisterPasswordViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapRegister()
    
    // Outputs
    
    var showTitles: ((RegisterPasswordTitles) -> Void)? { get set }
    var presentLogin: (() -> Void)? { get set }
}

class RegisterPasswordViewModel: RegisterPasswordViewModelProtocol {
    
    var presentLogin: (() -> Void)?
    var showTitles: ((RegisterPasswordTitles) -> Void)?
    
    func viewDidLoad() {
        let titles = RegisterPasswordTitles()
        showTitles?(titles)
    }
    /**
     Ingresa al registro
     */
    func tapRegister() {
        presentLogin?()
    }
 

}

