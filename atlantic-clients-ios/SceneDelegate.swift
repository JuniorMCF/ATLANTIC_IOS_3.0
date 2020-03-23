//
//  SceneDelegate.swift
//  atlantic-clients-ios
//
//  Created by admin on 1/30/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import Alamofire
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var initDate : String!
    var usuario : Usuario!
    var clubController : ClubViewController!
    var tabBarController : MainTabBarViewController!
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        initDate = Utils().getFechaActual()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        initDate = Utils().getFechaActual()
        if(tabBarController != nil){
            tabBarController.checkNotifications()
        }
        if(clubController != nil){
            clubController.reloadData()
        }
        print("app foreground")
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        if(!Constants().getLogin()){
            return
        }
        print(usuario.clienteId)
        let queue = DispatchQueue(label: "com.test.api", qos: .background, attributes: .concurrent)

        let finishDate = Utils().getFechaActual()
        var dominioUrl = URL(string: Constants().urlBase+Constants().postAgregarIngreso)
        
        dominioUrl = dominioUrl?.appending("clienteId", value: usuario.clienteId)
        dominioUrl = dominioUrl?.appending("fechaIngreso", value: initDate)
        dominioUrl = dominioUrl?.appending("fechaSalida", value: finishDate)
        
        
        let url = dominioUrl!.absoluteString
        
        //Constants().postAgregarIngreso
        
            
        AF.request(url ,method: .post,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON(queue: queue){response in
            
                print(response)
           
            }
        
        print("background scene")
    }


}

