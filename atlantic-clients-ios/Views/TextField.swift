//
//  TextField.swift
//  clients-ios
//
//  Created by Jhona on 7/16/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

enum TextFieldType {
    
    case withIcon
    case withOutIcon
    
}

class TextField: UITextField {
    
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
    let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 5)
    
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
         lineLayer.backgroundColor = UIColor(red:255, green:255, blue:255, alpha: 1.0).cgColor
        layer.addSublayer(lineLayer)
    }
    
    // MARK: - Public functions
    
    public func setDNIStyle(with placeHolder: String) {
        //DNI
        textColor = .white
        font = UIFont(name: "HelveticaNeue-Bold", size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        keyboardType = .numberPad
        autocorrectionType = .no
        returnKeyType = .next
        borderStyle = .none
        
        
        //Reducir
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let iconView = UIImageView(frame: CGRect(x: 15, y: 0, width: 15, height: 15))
        let icon = UIImage(named: "ic_usuario")
        iconView.tintColor = .white
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    public func setDNIStyle2(with placeHolder: String) {
        //DNI
        textColor = .white
        
        font = UIFont(name: "HelveticaNeue-Bold", size: 17)!
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        keyboardType = .numberPad
        autocorrectionType = .no
        returnKeyType = .next
        borderStyle = .none
        
        //Reducir
    }
    
    public func setDNI2Style(with placeHolder: String) {
           //DNI
           textColor = .black
           attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
           keyboardType = .numberPad
           autocorrectionType = .no
           returnKeyType = .next
           borderStyle = .none
           
           
           //Reducir
       }
       
    
    
    
    public func setPasswordStyle(with placeHolder: String) {
        //Password
        textColor = .white
        font = UIFont(name: "HelveticaNeue-Bold", size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        keyboardType = .alphabet
        isSecureTextEntry = true
        returnKeyType = .done
        borderStyle = .none
        
        //Reducir
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let iconView = UIImageView(frame: CGRect(x: 15, y: 0, width: 15, height: 15))
        let icon = UIImage(named: "ic_password")
        iconView.tintColor = .white
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
}
