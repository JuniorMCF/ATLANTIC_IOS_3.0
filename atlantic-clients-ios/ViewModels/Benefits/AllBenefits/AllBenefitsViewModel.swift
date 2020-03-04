//
//  AllBenefitsViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/14/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct AllBenefitsTitles {
    
    var dateSwapTitle: String = "Fecha de canje"
    var dateSwap: String = "21 de noviembre"
    var reminderTitle = "Crear Recordatorio"
    var pointsTitle: String = "Hasta este momento usted"
    var points: String = "4900 PUNTOS"
    var awardSubTitle: String = "Ha ganado $40 dólares"
    var lackTitle: String = "Le faltan:"
    var lackPoints: String = "3100 PUNTOS"
    var lackAward: String = "Para ganar $60 dólares"
    var ticketTitle = "SOLICITE SU TICKET DE CANJE"
    
}

protocol AllBenefitsViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((AllBenefitsTitles) -> Void)? { get set }
}

class AllBenefitsViewModel: AllBenefitsViewModelProtocol {
    
    var showTitles: ((AllBenefitsTitles) -> Void)?
    
    func viewDidLoad() {
        let titles = AllBenefitsTitles()
        showTitles?(titles)
    }
}
