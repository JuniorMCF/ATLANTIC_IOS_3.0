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

class Utils{
    
    
    
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
        print(date)
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
        print(now)
        
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
