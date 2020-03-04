//
//  RafflesDreamViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct RafflesDreamTitles {
    
    var rafflesTitle: String = "Sorteo De Tus Sueños"
    var nextDate: String = "Próxima fecha:"
    var date: String = "5 y 6 Diciembre"
    var reminderTitle = "Crear Recordatorio"
    var optionsTitle: String = "Hasta este momento tiene:"
    var options: String = "250 opciones"
    var points: String = "Tiene 60 000 Puntos"
    var necesaryPoints = "¡Le faltan 258 puntos para una opcion adicional!"
    
}

protocol RafflesDreamViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapCreateReminder()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((RafflesDreamTitles) -> Void)? { get set }
    var presentCreateReminder: (() -> Void)? { get set }
}

class RafflesDreamViewModel: RafflesDreamViewModelProtocol {

    var showTitles: ((RafflesDreamTitles) -> Void)?
    var presentCreateReminder: (() -> Void)?
    
    func viewDidLoad() {
        let titles = RafflesDreamTitles()
        showTitles?(titles)
    }
    
    func tapCreateReminder() {
        presentCreateReminder?()
    }

}
