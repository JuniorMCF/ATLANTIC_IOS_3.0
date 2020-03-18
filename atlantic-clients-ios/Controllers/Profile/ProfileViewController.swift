//
//  ProfileViewController.swift
//  clients-ios
//
//  Created by Jhona on 8/1/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModelProtocol! = ProfileViewModel()
    
    // MARK: - IBOulets

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileLabel: Label!
    @IBOutlet weak var diaryView: UIView!
    @IBOutlet weak var diaryLabel: Label!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var contactLabel: Label!
    @IBOutlet weak var separatorView: View!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsLabel: Label!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsLabel: Label!
    @IBOutlet weak var logOutView: UIView!
    @IBOutlet weak var logOutLabel: Label!
 
    var customLogout : CustomLogout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapProfile)))
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSettings)))
        logOutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLogOut)))
        contactView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapNotify)))
        diaryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAgenda)))
        
        bind()
        viewModel.viewDidLoad()
        
        separatorView.addSelectBorder(toSide: .Bottom, withColor: UIColor(white: 0.3, alpha: 1).cgColor, andThickness: 1, positionX: 0, positionY: 0, widthLayer: view.frame.width - 64)
        
    }
    
    @objc private func tapProfile() {
        viewModel.tapProfile()
    }
    
    @objc private func tapSettings() {
        viewModel.tapSettings()
    }
    
    @objc private func tapLogOut() {
        appDelegate.customLogout = CustomLogout(parent: self,title: "Atlantic", message: "¿Desea cerrar sesión?",tipo:"profileLogout")
        appDelegate.customLogout.showProgress()
    }
    @objc private func tapNotify(){
        viewModel.pushNotify()
    }
    @objc private func tapAgenda(){
        viewModel.pushAgenda()
    }
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.pushProfileDetail = pushProfileDetail
        viewModel.pushSettings = pushSettings
        viewModel.presentLogin = presentLogin
        viewModel.presentNotify = presentNotify
        viewModel.presentAgenda = presentAgenda
    }
    
    func showTitles(titles: ProfileTitles) {
        profileLabel.setSubTitleViewLabel(with: titles.profilePlaceHolder)
        diaryLabel.setSubTitleViewLabel(with: titles.diaryPlaceHolder)
        contactLabel.setSubTitleViewLabel(with: titles.contactPlaceHolder)
        settingsLabel.setSubTitleViewLabel(with: titles.settingsPlaceHolder)
        termsLabel.setSubTitleViewLabel(with: titles.termsPlaceHolder)
        logOutLabel.setSubTitleViewLabel(with: titles.logOutPlaceHolder)
        
    }
    
    func pushProfileDetail() {
        let storyBoard = UIStoryboard(name: "ProfileDetail", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ProfileDetailID")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func pushSettings() {
        let storyBoard = UIStoryboard(name: "Settings", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SettingsID")
        self.navigationController?.pushViewController(viewController, animated: true)
        
//        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsID")
//        present(viewController, animated: false, completion: nil)
    }
    func presentNotify(){
        let storyBoard = UIStoryboard(name: "Notify", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "NotifyID")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func presentLogin() {
     
        /*if let destinationViewController = self.navigationController?.viewControllers
            
            .filter(
                
                {$0.classForCoder == LoginViewController.self})
            
            .first {
            
            self.navigationController?.popToViewController(destinationViewController, animated: false)
            
            
        }*/
    //    appDelegate.navigationController = self.navigationController
        
      //  self.navigationController!.viewControllers.removeAll()
        /*let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginID")
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.makeKeyAndVisible()*/
       /*viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)*/
        
        
    }
    func presentAgenda(){
        let storyBoard = UIStoryboard(name: "ProfileAgenda", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ProfileAgendaID")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }


}
