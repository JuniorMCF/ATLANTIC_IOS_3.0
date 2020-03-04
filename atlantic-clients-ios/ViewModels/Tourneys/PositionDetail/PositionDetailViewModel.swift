//
//  PositionDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/10/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct PositionDetailTitles {
    
    var positionTitle: String = "Usted está en el:"
    var position: String = "1er"
    var postTitle: String = "puesto en el ranking"
    var winTitle: String = "Ha ganado"
    var win: String = "$ 1000"
    var payTittle: String = "IR A MIS COBROS"
    
}

protocol PositionDetailViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapPayments()
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((PositionDetailTitles) -> Void)? { get set }
    var presentPayments: (() -> Void)? { get set }
    
}

class PositionDetailViewModel: PositionDetailViewModelProtocol {
    
    var showTitles: ((PositionDetailTitles) -> Void)?
    var presentPayments: (() -> Void)?
    
    func viewDidLoad() {
        let titles = PositionDetailTitles()
        showTitles?(titles)
        
    }
    
    func tapPayments() {
        presentPayments?()
    }
    

    
}
