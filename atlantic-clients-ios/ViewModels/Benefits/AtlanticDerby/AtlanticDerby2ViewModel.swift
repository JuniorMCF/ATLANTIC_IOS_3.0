//
//  AtlanticDerby2ViewModel.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/21/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import UIKit

protocol AtlanticDerby2ViewModelProtocol{
    //funciones de entrada
     func viewDidLoad()
    
    //variables de salida
    var loadDataSources:(([Puestos])->Void)?{get set}
    var presentTitles:(([String])->Void)?{get set}
    
}
class AtlanticDerby2ViewModel : AtlanticDerby2ViewModelProtocol{
    var loadDataSources: (([Puestos]) -> Void)?
    var presentTitles: (([String]) -> Void)?

    
    func viewDidLoad(){
        let list = ["ic_coup_1","ic_coup_2","ic_coup_3"]
        let puesto = Puestos()
        var puestos = [Puestos]()
        puesto.foto = "ic_coup_1"
        puesto.puesto = "1er Puesto"
        puestos.append(puesto)
        let puesto2 = Puestos()
        puesto2.foto = "ic_coup_2"
        puesto2.puesto = "2do Puesto"
        puestos.append(puesto2)
        let puesto3 = Puestos()
        puesto3.foto = "ic_coup_3"
        puesto3.puesto = "3er Puesto"
        puestos.append(puesto3)

        loadDataSources?(puestos)
        presentTitles?(list)
    }
}
