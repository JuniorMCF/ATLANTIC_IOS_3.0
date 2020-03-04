//
//  TextField2.swift
//  clients-ios
//
//  Created by Jhona on 7/26/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class TextField2: UITextField {
    
    //MARK: - Variables
    
    var isLineDecoratorAdded = false
    
    
    //MARK: - Initializer
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Pading Placeholder textfield
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //MARK: - Private Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLineDecoratorAdded {
            addBottonLine()
            isLineDecoratorAdded = !isLineDecoratorAdded
        }
        
    }
    
    private func addBottonLine() {
        let lineLayer = CALayer()
        layer.masksToBounds = true
        lineLayer.frame = CGRect(x: 0,
                                 y: self.bounds.height - 1,
                                 width: self.frame.width,
                                 height: 1.0)
        lineLayer.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.5).cgColor
        layer.addSublayer(lineLayer)
    }
    
    // MARK: - Public functions
    
    public func setRegisterStyle(with placeHolder: String) {
        //DNI
        placeholder = placeHolder
        keyboardType = .numberPad
        autocorrectionType = .no
        returnKeyType = .next
        borderStyle = .none
    }
}
