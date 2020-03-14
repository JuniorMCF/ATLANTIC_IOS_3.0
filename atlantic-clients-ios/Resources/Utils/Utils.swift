//
//  Utils.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/5/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
import EventKit
import UIKit
class Utils{
    
    func getDia(weekDay:Int)->String{
        var txtDia = ""
        if(weekDay == 1){
            txtDia = "DOMINGO"
        }
        if(weekDay == 2){
            txtDia = "LUNES"
        }
        if(weekDay == 3){
            txtDia = "MARTES"
        }
        if(weekDay == 4){
            txtDia = "MIERCOLES"
        }
        if(weekDay == 5){
            txtDia = "JUEVES"
        }
        if(weekDay == 6){
            txtDia = "VIERNES"
        }
        if(weekDay == 7){
            txtDia = "SABADO"
        }
        return txtDia
    }
    func getMonth(month:String)->String{
        var txtMes = ""
        if(month == "01"){
            txtMes = "ENERO"
        }
        if(month == "02"){
            txtMes = "FEBRERO"
        }
        if(month == "03"){
            txtMes = "MARZO"
        }
        if(month == "04"){
            txtMes = "ABRIL"
        }
        if(month == "05"){
            txtMes = "MAYO"
        }
        if(month == "06"){
            txtMes = "JUNIO"
        }
        if(month == "07"){
            txtMes = "JULIO"
        }
        if(month == "08"){
            txtMes = "AGOSTO"
        }
        if(month == "09"){
            txtMes = "SETIEMBRE"
        }
        if(month == "10"){
            txtMes = "OCTUBRE"
        }
        if(month == "11"){
            txtMes = "NOVIEMBRE"
        }
        if(month == "12"){
            txtMes = "DICIEMBRE"
        }
        return txtMes
    }
    
    func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    
    func saveEvent(title:String, fecha: NSString){
        let fecha2 = fecha.doubleValue
        var date = Date(timeIntervalSince1970: TimeInterval(fecha2/1000))
        date = date.addingTimeInterval(60*60*8)
        let store = EKEventStore()
        store.requestAccess(to: .event, completion: {(granted, error) in
            if(!granted) { return}
            let event = EKEvent(eventStore: store)
            event.title = title
            event.startDate = date
            event.endDate = event.startDate.addingTimeInterval(5*60)
            event.calendar = store.defaultCalendarForNewEvents
            do {
                try store.save(event, span: .thisEvent, commit: true)
                
                print("Save data Successful")
            } catch{
                
            }
            
        })
    }
    

    public func timeAgoSince(_ date: Date) -> String {
      
        let calendar = Calendar.current
        let now = Date()
        
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        var components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
       
        
        //let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now!, options: [])
        
        if let year = components.year, year >= 2 {
            return "Hace \(year) años"
        }
        
        if let year = components.year, year >= 1 {
            return "Hace un año"
        }
        
        if let month = components.month, month >= 2 {
            return "Hace \(month) meses"
        }
        
        if let month = components.month, month >= 1 {
            return "Hace un mes"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "Hace \(week) semanas"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Hace una semana"
        }
        
        if let day = components.day, day >= 2 {
            return "Hace \(day) dias"
        }
        
        if let day = components.day, day >= 1 {
            return "Ayer"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "Hace \(hour) horas"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "Hace una hora"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "Hace \(minute) minutos"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "Hace un minuto"
        }
        
        if let second = components.second, second >= 3 {
            return "Hace \(second) segundos"
        }
        
        return "Justo ahora"
        
    }
}


extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}


extension UILabel{
    @IBInspectable var fontSizeScale: CGFloat{
        get{
            return self.fontSizeScale
        }set{
            var current_Size : CGFloat = 0.0
            current_Size = (UIScreen.main.bounds.width/320) //320*568 is my base
            let FinalSize : CGFloat = newValue * current_Size
            self.font = self.font.withSize(FinalSize)
        }
    }
    
}


extension UITextView{
    @IBInspectable var fontSizeScale: CGFloat{
        get{
            return self.fontSizeScale
        }set{
            var current_Size : CGFloat = 0.0
            current_Size = (UIScreen.main.bounds.width/320) //320*568 is my base
            let FinalSize : CGFloat = newValue * current_Size
            self.font = self.font!.withSize(FinalSize)
        }
    }
    
}


extension UITextField{
    @IBInspectable var fontSizeScale: CGFloat{
        get{
            return self.fontSizeScale
        }set{
            var current_Size : CGFloat = 0.0
            current_Size = (UIScreen.main.bounds.width/320) //320*568 is my base
            let FinalSize : CGFloat = newValue * current_Size
            
            self.font = .systemFont(ofSize: FinalSize)
            
        }
    }
    
}

extension UIButton{
    @IBInspectable var fontSizeScale: CGFloat{
        get{
            return self.fontSizeScale
        }set{
            var current_Size : CGFloat = 0.0
            current_Size = (UIScreen.main.bounds.width/320) //320*568 is my base
            let FinalSize : CGFloat = newValue * current_Size
            
            self.titleLabel?.font = .systemFont(ofSize: FinalSize)
            
        }
    }

}




extension UIView {

    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            let current_Size = (UIScreen.main.bounds.width/320)
            self.layer.cornerRadius = newValue * current_Size

            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }


    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
               shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
               shadowOpacity: Float = 0.4,
               shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    
    
  
    
}
extension UITextField{
    func setBorderBottom(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    func delBorderBottom(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}


extension UIViewController {

func showToast(message : String) {
    let large = CGFloat(message.count*10)
    print(large)
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - large/2, y: self.view.frame.size.height-self.view.frame.size.height/10, width: large, height: 35))
    toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    toastLabel.textColor = UIColor.black
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    toastLabel.font = UIFont(name: "IranSansMobile", size: 18)
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension UISlider{
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
    }
}
