//
//  LoginViewController.swift
//  clients-ios
//
//  Created by Jhona on 7/16/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginViewModelProtocol! = LoginViewModel()
    var progressController : CustomProgress!
    // MARK: - IBOulet

    @IBOutlet var titleLabel: Label!
    @IBOutlet var dniTextField: TextField!
    @IBOutlet var passwordTextField: TextField!
    @IBOutlet var loginButton: Button!
    @IBOutlet var newUserButton: Button!
    @IBOutlet var forgotPasswordButton: Button!
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var terminosButton: Button!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var estadoTerminos = false
    var splash : SplashLoginViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Login", message: "Iniciando Sesión ...")
        appDelegate.progressDialog.isHome = false
        splash = SplashLoginViewController(parent: self.parent!)
        loginButton.frame.size = CGSize(width:200 ,height:15)
        terminosButton.frame.size = CGSize(width: 18 , height: 18)
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        addTapGesture()
        bind()
        viewModel.viewDidLoad()
        if(Constants().getLogin()){
            splash.showSplash()
            viewModel.isLoggin()
        }
        
        
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.presentOnboarding = presentOnboarding
        viewModel.presentRegister = presentRegister
        viewModel.presentForgotPassword = presentForgotPassword
        viewModel.changeTerminos = changeTerminos(estado:)
       
        viewModel.presentSetData = presentSetData(user: password:)
    }
    func presentSetData(user:String,password:String){
        dniTextField.text = user
        passwordTextField.text = password
    }
    
    func showTitles(titles: LoginTitles) {
        titleLabel.setTitleViewLabel(with: titles.screenTitle)
        dniTextField.setDNIStyle(with: titles.dniPlaceholder)
        passwordTextField.setPasswordStyle(with: titles.passwordPlaceholder)
        loginButton.setFirstButton(with: titles.buttonTitle)
        newUserButton.setLinkButton(with: titles.newUserPlaceholder)
        forgotPasswordButton.setLinkButton(with: titles.forgotPasswordTitle)
        terminosLabel.setLinkLabel(with: "Acepto los términos y condiciones")
    }
    
    func presentOnboarding() {
        splash.hideSplash()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: false)
        
        
    }
    
    func presentRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let navViewController = storyboard.instantiateViewController(withIdentifier: "NavRegisterID")
        navViewController.modalPresentationStyle = .fullScreen
        present(navViewController, animated: false, completion: nil)
    }
    func presentForgotPassword(){
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let navViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordID")
        navViewController.modalPresentationStyle = .fullScreen
        self.present(navViewController, animated: false)
    }
    
    // MARK: - Private Functions

    
    
    
    @IBAction func tapLogin() {
        let dni = dniTextField.text!
        let password = passwordTextField.text!
        
        viewModel.tapLogin(dni: dni,password: password,terminos: estadoTerminos)
    }
    @IBAction func tapTerminos(_ sender: Any) {
        viewModel.tapTerminos(estado:estadoTerminos)
    }
    
    @IBAction func tapNewUser() {
        viewModel.tapNewUSer()
    }
    
    @IBAction func tapForgotPassword() {
        viewModel.tapForgotPassword()
    }
    
    func changeTerminos(estado:Bool){
        estadoTerminos = estado
        if(estadoTerminos == true){
            terminosButton.setImage(UIImage(named: "checked_checkbox"), for: .normal)
            
        }else{
            terminosButton.setImage(UIImage(named: "unchecked_checkbox"), for: .normal)
        }
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
