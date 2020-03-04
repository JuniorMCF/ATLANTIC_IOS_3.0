//
//  View.swift
//  clients-ios
//
//  Created by Jhona on 8/3/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

import UIKit

class View: UIView {
    
    func addCornerRadius(radius: Float) {
        //layer.borderWidth = 1
        //layer.borderColor = UIColor(red:0, green:0, blue:0, alpha: 0.12).cgColor
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        clipsToBounds = true
    }
    
    //MARK: - Initializer
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
}

//MARK: - Public Functions
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addSelectBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat, positionX: CGFloat, positionY: CGFloat, widthLayer: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: positionX, y: positionY, width: widthLayer, height: thickness); break
        case .Bottom: border.frame = CGRect(x: positionX, y: positionY, width: widthLayer, height: thickness); break
        }
        
        self.layer.insertSublayer(border, at: 1)
    }
    
}
