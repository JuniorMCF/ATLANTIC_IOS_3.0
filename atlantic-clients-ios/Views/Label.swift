//
//  Label.swift
//  clients-ios
//
//  Created by Jhona on 7/16/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    //MARK: - Initializer
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public Functions
    
    public func setTitleViewLabel(with setText: String) {
        textColor = .white
        
        font = UIFont(name: "HelveticaNeue-Bold", size: 18)!
        text = setText
        textAlignment = .center
        //numberOfLines   = 0
    }
    public func setTitleForgotViewLabel(with setText: String) {
        textColor = .black
        
        font = UIFont(name: "Avenir-Roman", size: 18)!
        text = setText
        textAlignment = .left
        //numberOfLines   = 0
    }
    
    public func setSubTitleViewLabel(with setText: String) {
        textColor   = .black
        text        = setText
        font = UIFont(name: "Avenir-Medium", size: 15)!
    }
    public func setSubTitleViewLabelCenter(with setText: String) {
        textColor   = .black
        text        = setText
        font = UIFont(name: "Avenir-Medium", size: 15)!
        textAlignment = .center
    }
    public func setSubTitleViewLabelCenterLarge(with setText: String) {
        textColor   = .black
        text        = setText
        font = UIFont(name: "Avenir-Medium", size: 22)!
        textAlignment = .center
    }
    
    public func setLinkLabel(with setText: String) {
        textColor = .white
        font = UIFont(name: "Avenir-Medium", size: 15)!
        textAlignment = .left
        attributedText = NSAttributedString(string: setText, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
    }
    
    public func setTitleCardLabel(with setText: String) {
        textColor   = .gray
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 15)!
        textAlignment = .center
    }
    
    public func setTitleProfileLabel(with setText: String) {
        textColor   = .gray
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 15)!
    }
    
    public func setDinnerTitle(with setText: String) {
        textColor = .white
        font = UIFont(name: "Avenir-Black", size: 23)!
        text = setText
        textAlignment = .center
        //numberOfLines   = 0
    }
    
    public func setDinnerSubTitle(with setText: String) {
        textColor   = .white
        text        = setText
        font = UIFont(name: "Avenir-Black", size: 13)!
        textAlignment = .center
    }
    
    public func setDetailTitle(with setText: String) {
        textColor = .black
        font = UIFont(name: "Avenir-Black", size: 16)!
        text = setText
        textAlignment = .left
        //numberOfLines   = 0
    }

    
    public func setDetailSubTitle(with setText: String) {
        textColor   = .black
        text        = setText
        font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        textAlignment = .left
    }
    public func setDetailSubTitleCenter(with setText: String) {
        textColor   = .black
        text        = setText
        font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        textAlignment = .center
    }
    
    public func setDetailSub(with setText: String) {
        textColor   = .black
        text        = setText
        font = UIFont(name: "HelveticaNeue", size: 15)!
        textAlignment = .left
    }
    
    public func setClubTitle(with setText: String) {
        textColor   = .white
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 17)!
    }
    public func setClubTitle2(with setText: String) {
        textColor   = .white
        text        = setText
        font = UIFont(name: "HelveticaNeue-Bold", size: 18)!
        textAlignment = .left
    }
    
    public func setRafflesTitleGold(with setText: String) {
        textColor   = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 28)!
        textAlignment = .left
    }
    public func setRafflesTitle(with setText: String) {
        textColor   = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 28)!
        textAlignment = .left
    }
    public func setRafflesTitleGoldCenter(with setText: String) {
        textColor   = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 28)!
        textAlignment = .center
    }
    
    public func setRafflesSubTitle(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 13)!
        textAlignment = .left
    }
    public func setDateModify(with setText: String) {
        textColor   = .gray
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 12)!
        textAlignment = .center
    }
    public func setDateModify2(with setText: String) {
        textColor   = .gray
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 15)!
        textAlignment = .center
    }
    public func setRafflesSubTitleCenter(with setText: String) {
       textColor   = .black
       text        = setText
       font        = UIFont(name: "Avenir-Medium", size: 13)!
       textAlignment = .center
    
   }
    
    public func setRafflesSub(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 15)!
        textAlignment = .left
    }
    public func setRafflesSubCenter(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 15)!
        textAlignment = .center
    }
    public func setRafflesSubUnderline(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 13)!
        textAlignment = .center
        let textRange = NSMakeRange(0, setText.count)
        let attributedText = NSMutableAttributedString(string: setText)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value:NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed

        self.attributedText = attributedText
    }
    
    public func setCategoryTitle(with setText: String) {
        textColor   = .white
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 25)!
        textAlignment = .center
        
    }
    
    public func setCategorySubTitle(with setText: String) {
        textColor   = .white
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 13)!
        textAlignment = .center
    }
    
    public func setCategoryPoints(with setText: String) {
        textColor   = .white
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 13)!
    }
    
    public func setBenefitDetailTitle(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 20)!
        textAlignment = .left
    }
    public func setBenefitDetailTitleCenter(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 20)!
        textAlignment = .center
    }
    
    public func setmessageSub(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 13)!
        textAlignment = .center
    }
    
    public func setCareerTitle(with setText: String) {
        textColor = .gray
        font = UIFont(name: "Avenir-Black", size: 23)!
        text = setText
        textAlignment = .center
        //numberOfLines   = 0
    }
    
    public func setCareerSub(with setText: String) {
        textColor   = .gray
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 13)!
        textAlignment = .center
    }
    
    public func setCareerSubTitle(with setText: String) {
        textColor   = .black
        text        = setText
        font        = UIFont(name: "Avenir-Medium", size: 17)!
        textAlignment = .center
    }
    
    public func setAwardTitle(with setText: String) {
        textColor = .black
        font = UIFont(name: "Avenir-Black", size: 23)!
        text = setText
        textAlignment = .center
        //numberOfLines   = 0
    }
    
    public func setPositionTitleGold(with setText: String) {
        textColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        font = UIFont(name: "Avenir-Black", size: 50)!
        text = setText
        textAlignment = .center
        //numberOfLines   = 0
    }
    public func setPositionTitle(with setText: String) {
        textColor = .black
           font = UIFont(name: "Avenir-Black", size: 50)!
           text = setText
           textAlignment = .center
           //numberOfLines   = 0
       }
    
    
}
