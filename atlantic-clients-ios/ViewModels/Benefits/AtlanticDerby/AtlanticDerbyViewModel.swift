//
//  AtlanticDerbyViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/20/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import UIKit

protocol AtlanticDerbyViewModelProtocol{
    //funciones de entrada
     func viewDidLoad()
    
    //variables de salida
    var loadDataSources:(()->Void)?{get set}
}
class AtlanticDerbyViewModel : AtlanticDerbyViewModelProtocol{
    var loadDataSources: (() -> Void)?
    

    
    func viewDidLoad(){
        
    }
}

