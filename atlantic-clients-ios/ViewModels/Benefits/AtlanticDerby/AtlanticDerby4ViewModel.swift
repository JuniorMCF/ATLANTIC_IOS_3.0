//
//  AtlanticDerby4ViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
protocol AtlanticDerby4ViewModelProtocol{
    //funciones de entrada
     func viewDidLoad()
    
    //variables de salida
    var loadDataSources:(([String])->Void)?{get set}
    var presentTitles:(([String])->Void)?{get set}
    
}
class AtlanticDerby4ViewModel : AtlanticDerby4ViewModelProtocol{
    var loadDataSources: (([String]) -> Void)?
    var presentTitles: (([String]) -> Void)?

    
    func viewDidLoad(){
        let list = ["1er puesto: $50","2do puesto: $20","3er puesto: $10"]
        
        loadDataSources?(list)
        presentTitles?(list)
    }
}
