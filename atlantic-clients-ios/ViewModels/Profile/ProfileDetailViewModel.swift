//
//  ProfileDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 8/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct DetailTitles {
    var nameTitle: String = "Nombres"
    var nameText: String = "Leonardo"
    var lastNameTitle: String = "Apellidos"
    var lastNameText: String = "Del Castillo"
    var birthdateTitle: String = "Fecha de Nacimiento"
    var birthdateText: String = "08-06-1983"
    var dniTitle: String = "DNI"
    var dniText: String = "12345678"
    var phoneTitle: String = "Teléfono"
    var phoneText: String = "123-456-789"
    var emailTitle: String = "Correo Electronico"
    var emailText: String = "email@gmail.com"
    var addressTitle: String = "Dirección"
    var addressText: String = "Jr. Direccion - Las Vegas, Nevada"
    var saveTitle: String = "Guardar Información"
}

protocol ProfileDetailViewModelProtocol {
    
    // Inputs
    
    func viewDidLoad()
    
    // Outputs
    
    var showTitles: ((DetailTitles) -> Void)? { get set }
 
}

class ProfileDetailViewModel: ProfileDetailViewModelProtocol {
    
    var showTitles: ((DetailTitles) -> Void)?
    
    func viewDidLoad() {
        let titles = DetailTitles()
        showTitles?(titles)
    }
    
}
