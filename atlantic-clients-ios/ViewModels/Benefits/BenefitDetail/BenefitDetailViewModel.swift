//
//  BenefitDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct BenefitDetailTitles {
    
    var title: String = "Agenda 2019"
    var description: String = "Este martes 9 de noviembre, al sumar 100 puntos automáticamente usted puede canjear una útil agenda 2019 con cubierta de cuero. Comience a acumular puntos cada dia del nuevo año, con la ayuda de la agencia Atlantic City."
    var dateTitle: String = "Fecha:"
    var date: String = "9 de noviembre"
    var reminderTitle = "Crear Recordatorio"
    var pointsTitle: String = "Puntos Para canjear el regalo:"
    var points: String = "100 Puntos"
    var haveTitle: String = "Tiene:"
    var pointsSliderTitle: String = "0 Puntos"
    var message = "Usted todavia no ha empezado a acumular puntos."
    
}

protocol BenefitsDetailViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapCreateReminder()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((BenefitDetailTitles) -> Void)? { get set }
    var presentCreateReminder: (() -> Void)? { get set }
}

class BenefitsDetailViewModel: BenefitsDetailViewModelProtocol {

    var showTitles: ((BenefitDetailTitles) -> Void)?
    var presentCreateReminder: (() -> Void)?
    
    /**
        inicialia la vista
     */
    func viewDidLoad() {
        let titles = BenefitDetailTitles()
        showTitles?(titles)
    }
    
    /**
     crea recordatorio
     */
    func tapCreateReminder() {
        presentCreateReminder?()
    }
}
