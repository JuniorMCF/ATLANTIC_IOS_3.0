//
//  RecoveryPasswordViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/8/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    var viewModel: RecoveryPasswordViewModelProtocol! = RecoveryPasswordViewModel()
    
    @IBOutlet var titleLabel: Label!
    @IBOutlet var passwordTextField: TextField!
    @IBOutlet var repeatPasswordLabel: Label!
    @IBOutlet var repeatPasswordTextField: TextField!
    @IBOutlet var ContinueButton: Button!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bind(){
        viewModel.showTitles = showTitles(data: )
        viewModel.showToast = show(message: )
    }
    func showTitles(data:[String]){
        titleLabel.setClubTitle(with: data[0])
        passwordTextField.setPasswordStyle(with: data[1])
        repeatPasswordLabel.setClubTitle(with: data[2])
        repeatPasswordTextField.setPasswordStyle(with: data[3])
        ContinueButton.setFirstButton(with: data[4])
    }
    func show(message:String){
        showToast(message: message)
    }
    
    
    @IBAction func tapNext(_ sender: Any) {
        viewModel.recoveryPassword(clienteId: appDelegate.usuario.clienteId,password1: passwordTextField.text!,password2: repeatPasswordTextField.text!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
