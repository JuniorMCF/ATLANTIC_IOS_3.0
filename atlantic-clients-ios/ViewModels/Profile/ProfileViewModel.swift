//
//  ProfileViewModel.swift
//  clients-ios
//
//  Created by Jhona on 8/1/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct ProfileTitles {
    
    var userName: String = "Leonardo Del Castillo"
    var profilePlaceHolder: String = "Mi perfil"
    var diaryPlaceHolder: String = "Mi agenda"
    var contactPlaceHolder: String = "Notificaciones"
    var settingsPlaceHolder: String = "Configuración"
    var termsPlaceHolder: String = "Términos y políticas de privacidad"
    var logOutPlaceHolder: String = "Cerrar sesión"
    
}

protocol ProfileViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    func tapProfile()
    func tapSettings()
    func tapLogOut()
    func pushNotify()
    func pushAgenda()
    // Outputs
    
    var showTitles: ((ProfileTitles) -> Void)? { get set }
    var pushProfileDetail: (() -> Void)? { get set }
    var pushSettings: (() -> Void)? { get set }
    var presentLogin: (() -> Void)? { get set }
    var presentNotify: (()->Void)?{get set}
    var presentAgenda: (()->Void)?{get set}
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var showTitles: ((ProfileTitles) -> Void)?
    var pushProfileDetail: (() -> Void)?
    var pushSettings: (() -> Void)?
    var presentLogin: (() -> Void)?
    var presentNotify: (()->Void)?
    var presentAgenda: (()->Void)?
    
    func viewDidLoad() {
        let titles = ProfileTitles()
        showTitles?(titles)
    }
    
    /**
     abre los detalles de la cuenta
     */
    func tapProfile() {
        pushProfileDetail?()
    }
    /**
     abre opciones adicionales
     */
    func tapSettings() {
        pushSettings?()
    }
    
    /**
     cierra la cuenta activa
     */
    func tapLogOut() {
        presentLogin?()
    }
    
    /**
        muestra las opciones de las notificaciones
     */
    func pushNotify(){
        presentNotify?()
    }
    /**
     muestra la agenda del cliente
     */
    func pushAgenda() {
        presentAgenda?()
    }
}

