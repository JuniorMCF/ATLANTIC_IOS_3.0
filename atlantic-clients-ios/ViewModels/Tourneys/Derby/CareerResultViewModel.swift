//
//  CareerResultViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/14/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct CareerResultTitles {
    
    var title: String = "Carrera Oro"
    var date: String = "fecha: 02 de Enero"
    var hour: String = "18:00 Hrs"
    var resultsTitle: String = "resultados:"
    var postfi1: String = "1er puesto"
    var postfi2: String = "2er puesto"
    var postfi3: String = "3er puesto"
    var nextCarrer: String = "Proxima carrera:"
    var categoryCarrer: String = "Carrera Diamante a las 22:00 hrs"
    var reminderTitle: String = "Crea Recordatorio"
    
}

protocol CareerResultViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapCareerAward()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((CareerResultTitles) -> Void)? { get set }
    var presentCareerAward: (() -> Void)? { get set }
    
}

class CareerResultViewModel: CareerResultViewModelProtocol {
    
    var showTitles: ((CareerResultTitles) -> Void)?
    var presentCareerAward: (() -> Void)?
    
    /**
     muestra los resultados de las carreras
     */
    func viewDidLoad() {
        let titles = CareerResultTitles()
        showTitles?(titles)
    }
    
    /**
     muestra los premios de las carreras
     */
    func tapCareerAward() {
        presentCareerAward?()
    }
    
}
