//
//  AppDelegate.swift
//  atlantic-clients-ios
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var usuario = Usuario()
    var imagenes : [UIImage] = []
    
    var weekEvent = News()
    var promotionDay = PromotionDay()
    var orquesta = News()
    var benefitWeek = News()
    
    //cobros
    var cobros = [Cobros]()
    var sorteos = [Sorteo]()
    var window: UIWindow?
    //customProgress
    var progressDialog : CustomProgress!
    var customLogout: CustomLogout!
    var customEvent : CustomEvent!
    //switch
    var switchState : Bool!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

