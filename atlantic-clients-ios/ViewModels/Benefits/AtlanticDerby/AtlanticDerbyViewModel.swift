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

