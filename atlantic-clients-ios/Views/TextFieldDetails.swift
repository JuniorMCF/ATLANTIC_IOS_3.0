//
//  TextFieldDetails.swift
//  clients-ios
//
//  Created by Jhona on 8/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class TextFieldDetails: UITextField {
    
    //MARK: - Initializer
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
public func setTextFieldStyle(with setText: String) {
    text = setText
    fontSizeScaleFamily(family: "Avenir-Medium", size: 15)
    autocorrectionType = .no
    borderStyle = .none
}
}

