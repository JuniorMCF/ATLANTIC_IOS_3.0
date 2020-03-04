//
//  ReminderViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct ReminderTitles {
    
    var reminderTitle: String = "¿Permitir que Atlantic City cree recordatorios en calendar?"
    var acceptTitle = "ACEPTAR"
    var declineTitle = "RECHAZAR"
    
}

protocol ReminderViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapAccept()
    func tapDecline()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((ReminderTitles) -> Void)? { get set }
    var dismisViewController: (() -> Void)? { get set }
}

class ReminderViewModel: ReminderViewModelProtocol {
    
    
    var showTitles: ((ReminderTitles) -> Void)?
    var dismisViewController: (() -> Void)?
    
    func viewDidLoad() {
        let titles = ReminderTitles()
        showTitles?(titles)
    }
    
    func tapAccept() {
        dismisViewController?()
    }
    
    func tapDecline() {
        dismisViewController?()
    }
}
