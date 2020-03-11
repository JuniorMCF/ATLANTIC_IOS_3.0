//
//  AgendaViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/10/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
protocol AgendaViewModelProtocol {
    
    // Inputs
    func viewDidLoad()

    func didEventSelected(event:Event)
    // Outputs
    
    var showTitles: ((ProfileTitles) -> Void)? { get set }
    var presentEventDetail:((Event)->Void)? {get set}
    var loadDatasources: ((BreakfastDatasources) -> Void)?{get set}
}

class AgendaViewModel: AgendaViewModelProtocol {
    
    var showTitles: ((ProfileTitles) -> Void)?
    var presentEventDetail:((Event)->Void)?
    var loadDatasources: ((BreakfastDatasources) -> Void)?
    
    func viewDidLoad() {
        let datasources = BreakfastDatasources()
        loadDatasources?(datasources)
    }
  
    func didEventSelected(event:Event){
        presentEventDetail?(event)
    }
    
}
