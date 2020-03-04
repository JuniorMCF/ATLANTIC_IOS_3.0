//
//  AtlanticDerby3ViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation

protocol AtlanticDerby3ViewModelProtocol{
    //funciones de entrada
     func viewDidLoad()
    
    //variables de salida
    var loadDataSources:(([String])->Void)?{get set}
    var presentTitles:(([String])->Void)?{get set}
    
}
class AtlanticDerby3ViewModel : AtlanticDerby3ViewModelProtocol{
    var loadDataSources: (([String]) -> Void)?
    var presentTitles: (([String]) -> Void)?

    
    func viewDidLoad(){
        let list = ["ic_coup_1","ic_coup_2","ic_coup_3"]
        loadDataSources?(list)
        presentTitles?(list)
    }
}
