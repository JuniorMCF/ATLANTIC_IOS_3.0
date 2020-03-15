//
//  Button.swift
//  clients-ios
//
//  Created by Jhona on 7/16/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//
import UIKit

class Button: UIButton {
    
    //MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public Functions
    
    public func setFirstButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 17)!
        fontSizeScale = 17
        backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        cornerRadius = 20.0
      //  layer.cornerRadius = 20.0
    }
    
    public func setFirstButton3(with title: String) {
           setTitle(title, for: .normal)
           setTitleColor(.white, for: .normal)
           
           fontSizeScaleFamily(family: "HelveticaNeue-Bold", size: 12)
           backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
           self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
           layer.cornerRadius = 0.0
    }
    
    public func setFirstButton2(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 17)!
        backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        layer.cornerRadius = 20.0
    }
    public func setForgotButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        self.sizeToFit()
        layer.cornerRadius = 15.0
    }
    public func setSkipButton(){
        frame.size.height = 35
        frame.size.width = 35
       // backgroundColor = .white
        //self.sizeToFit()
        //layer.cornerRadius = frame.width/2*/
    }
    
    public func setOnBoardButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.gray, for: .normal)
        layer.cornerRadius = 8.0
    }
    
    public func setLinkButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)!
        fontSizeScale = 12
        titleLabel?.textAlignment = .left
        titleLabel?.attributedText = NSAttributedString(string: title, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        backgroundColor = .none
        
    }
    public func setLinkButton2(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)!
        titleLabel?.textAlignment = .right
        fontSizeScale = 12
        titleLabel?.attributedText = NSAttributedString(string: title, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        backgroundColor = .none
        
    }
    
    public func setSecondButton(with title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir-Medium", size: 18)!
        setTitleColor(.white, for: .normal)
        backgroundColor  = .gray
        layer.cornerRadius = 8.0
    }
    
    public func setHourButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir-Black", size: 11)!
        backgroundColor = .gray
        layer.cornerRadius = 8.0
        setImage(UIImage(named: "icon-events"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 4, left: 30, bottom: 4, right: 8)
        tintColor = .white
        semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
    }
        
    public func setRemindButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 15.0
        
        fontSizeScaleFamily(family: "HelveticaNeue-Bold", size: 17)
        backgroundColor  = #colorLiteral(red: 0.6941176471, green: 0.07450980392, blue: 0.1843137255, alpha: 1)
    }
    public func setRemindButton2(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 0
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)!
        backgroundColor  = #colorLiteral(red: 0.6941176471, green: 0.07450980392, blue: 0.1843137255, alpha: 1)
    }
    
    
    public func setWitheButton(with title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)!
        backgroundColor  = .white
        layer.cornerRadius = 8.0
    }
}
