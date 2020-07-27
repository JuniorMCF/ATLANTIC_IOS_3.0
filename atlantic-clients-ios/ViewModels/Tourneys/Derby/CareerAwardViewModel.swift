//
//  CareerAwardViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/14/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct CareerAwardTitles {
    
    var title: String = "¡Ha Ganado!"
    var date: String = "1er puesto - carrera oro"
    var hour: String = "50$"
    var resultsTitle: String = "Resultados:"
    var postfi1: String = "1er puesto"
    var postfi2: String = "2er puesto"
    var postfi3: String = "3er puesto"
    var paymentsTitle: String = "IR A MIS COBROS"
    
    var nextCarrer: String = "Proxima carrera:"
    var categoryCarrer: String = "Carrera Diamante a las 22:00 hrs"
    var reminderTitle: String = "Crea Recordatorio"
    
}

protocol CareerAwardViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapPayments()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((CareerAwardTitles) -> Void)? { get set }
    var presentPayments: (() -> Void)? { get set }
    
}

class CareerAwardViewModel: CareerAwardViewModelProtocol {
    
    var showTitles: ((CareerAwardTitles) -> Void)?
    var presentPayments: (() -> Void)?
    
    /**
     muestra los titulos de los premios
     */
    func viewDidLoad() {
        let titles = CareerAwardTitles()
        showTitles?(titles)
    }
    /**
     muestra los pagos
     */
    func tapPayments() {
        presentPayments?()
    }
}
