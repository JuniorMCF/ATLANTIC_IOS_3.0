//
//  AppDelegate.swift
//  atlantic-clients-ios
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import UserNotifications
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var usuario = Usuario()
    var imagenes : [UIImage] = []
    
    var weekEvent = News()
    var promotionDay = PromotionDay()
    var eventDetailPreview = EventDetailPreview()
    var orquesta = News()
    var benefitWeek = News()
    var gcmMessageIDKey = "gcm.message_id"
    //cobros
    var cobros = [Cobros]()
    var sorteos = [Sorteo]()
    var window: UIWindow?
    //customProgress
    var progressDialog : CustomProgress!
    var customLogout: CustomLogout!
    var customEvent : CustomEvent!
    var delAgenda : DelAgenda!
    var initDate : String!
    var tabBarController : MainTabBarViewController!
    var clubController : ClubViewController!
    //switch
    var navigationController : UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initDate = Utils().getFechaActual()
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        Messaging.messaging().delegate = self as MessagingDelegate
        application.registerForRemoteNotifications()
       
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        initDate = Utils().getFechaActual()
        tabBarController.checkNotifications()
        if(clubController != nil){
            clubController.reloadData()
        }
        print("app foreground")
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        var finished = false
        var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);
        bgTask = application.beginBackgroundTask(withName:"MyBackgroundTask", expirationHandler: {() -> Void in
            if bgTask != UIBackgroundTaskIdentifier.invalid {
                // Do something to stop our background task or the app will be killed
                finished = true
            }
        })
     
        
        if(!Constants().getLogin()){
            // Indicate that it is complete
            application.endBackgroundTask(bgTask)
            bgTask = UIBackgroundTaskIdentifier.invalid
            return
        }
        let queue = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)

        let finishDate = Utils().getFechaActual()
        var dominioUrl = URL(string: Constants().urlBase+Constants().postAgregarIngreso)
        
        dominioUrl = dominioUrl?.appending("clienteId", value: usuario.clienteId)
        dominioUrl = dominioUrl?.appending("fechaIngreso", value: initDate)
        dominioUrl = dominioUrl?.appending("fechaSalida", value: finishDate)
        
        
        let url = dominioUrl!.absoluteString
        
      
            AF.request(url ,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON(queue : queue){response in
            
                  print(response)
             
            }
        
        
    
        

    
        
    }

    
    
   
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
       // If you are receiving a notification message while your app is in the background,
       // this callback will not be fired till the user taps on the notification launching the application.
       // TODO: Handle data of notification

       // With swizzling disabled you must let Messaging know about the message, for Analytics
       // Messaging.messaging().appDidReceiveMessage(userInfo)

       // Print message ID.
       if let messageID = userInfo[gcmMessageIDKey] {
         print("Message ID: \(messageID)")
       }
       // Print full message.
        Constants().saveNotify(isActive: true)
       print(userInfo)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
     
     if let message = userInfo["gcm.notification.message"] {
           print("Message : \(message)")
        
         }
     
        if UIApplication.shared.applicationState == .active {
            print("app en foreground")
            let body = userInfo["body"] as? String ?? ""
            
            if(!body.isEmpty){
                if(Int(body)! < 5){
                    var position = 0
                             if(Int(body) == 0){
                                 position = 1
                             }
                             if(Int(body) == 1 || Int(body) == 2 || Int(body) == 3){
                                 position = 2
                                if(clubController != nil){
                                    clubController.reloadData()
                                }
                             }
                             if(Int(body) == 4){
                                 position = 3
                             }
                            Constants().saveBody(isActive: true, key: "body"+body)
                             
                             if let items = tabBarController.tabBar.items as NSArray? {
                                 let tabItem = items.object(at: position) as! UITabBarItem
                                 tabItem.badgeValue = " "
                                 tabItem.badgeColor = UIColor.init(red: 251/255, green: 204/255, blue: 52/255, alpha: 1)
                             }
                         }
                         
                     }
       }
     
        if UIApplication.shared.applicationState == .background {
            print("app en background")
            let body = userInfo["body"] as! String
                    
            print("body"+body)
                    
            Constants().saveBody(isActive: true, key: "body"+body)
            
        }

     //self.notification()
      // Print full message.
     print(userInfo)
     
        
     completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
}




@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    //print("notificacion llego 1 \(userInfo)")
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    
    if UIApplication.shared.applicationState == .active { // In iOS 10 if app is in foreground do nothing.
        print("app en foreground")
       /* let tipo = userInfo["tipo"] as! String
        let notification = userInfo["notification"] as! String
        if(tipo == "L"){
            let data = userInfo["text"] as! String
            self.dataNotification = data
        }else if (tipo == "I" || tipo == "E"){
            
            self.notificationId = notification
           // self.navigationController.pushViewController(vc!, animated: true)
        }
        self.tipo = tipo
        let rootViewController = self.window!.rootViewController as! UINavigationController
        
         
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeView") as? HomeVC
         
         rootViewController.pushViewController(vc!, animated: true)*/
        completionHandler([.alert, .badge, .sound])
    }
    if UIApplication.shared.applicationState == .background { // If app is not active you can show banner, sound and badge.
        print("app en minimizado")
      /*  let userId = userInfo["gcm.notification.userId"] as! String
          let message = userInfo["gcm.notification.message"] as! String
          let messageId = userInfo["gcm.message_id"] as! String
          let name = userInfo["gcm.notification.name"] as! String
          let json = JSON(userInfo["aps"])
          let alert = json["alert"].dictionary
          let body = alert!["body"]!.stringValue
          let title = alert!["title"]!.stringValue*/


         /*  let tipo = userInfo["tipo"] as! String
            let notification = userInfo["notification"] as! String
            if(tipo == "L"){
                let data = userInfo["text"] as! String
                self.dataNotification = data
            }else if (tipo == "I" || tipo == "E"){
                
                self.notificationId = notification
               // self.navigationController.pushViewController(vc!, animated: true)
            }
            self.tipo = tipo
            let rootViewController = self.window!.rootViewController as! UINavigationController
            
             
             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeView") as? HomeVC
             
             rootViewController.pushViewController(vc!, animated: true)*/
          
          // Change this to your preferred presentation option
          completionHandler([.alert, .badge, .sound])
        
        
    }
    

    //print(userInfo[""])
  
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    
    print("notificacion llego 2 \(userInfo)")
    
    
    // Print full message.
   // print(userInfo)
    
   /* let userId = userInfo["gcm.notification.userId"] as! String
       let message = userInfo["gcm.notification.message"] as! String
       let messageId = userInfo["gcm.message_id"] as! String
       let name = userInfo["gcm.notification.name"] as! String
       let json = JSON(userInfo["aps"])
       let alert = json["alert"].dictionary
       let body = alert!["body"]!.stringValue
       let title = alert!["title"]!.stringValue*/

     
       
       //print("save data")
    //aca enviamos al hacer click
    

    completionHandler()
  }
    
    
}

extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        
      let tokenPush = fcmToken
      print("Firebase registration token: \(fcmToken)")
        

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("messagin \(messaging)  remoteMessage \(remoteMessage)")
    }
}


extension ViewController: UNUserNotificationCenterDelegate {

    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

        completionHandler([.alert, .badge, .sound])
    }

    

}

