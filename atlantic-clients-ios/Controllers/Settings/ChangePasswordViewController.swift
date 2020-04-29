//
//  RecoveryPasswordViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/14/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController,UITextFieldDelegate {

    var viewModel : ChangePasswordViewModelProtocol = ChangePasswordViewModel()
    
    var newPassword :String = ""
    var confirmNewPassword :String = ""
    
    var stateEye = 0
    var stateEye2 = 0
    var stateEye3 = 0
    
    @IBOutlet var eye1: UIButton!
    @IBOutlet var eye2: UIButton!
    @IBOutlet var eye3: UIButton!
    
    var condition1 = false
    var condition2 = false
    
    
    @IBOutlet var beforePasswordLabel: Label!
    @IBOutlet var beforePasswordTextField: TextField!
    @IBOutlet var newPasswordLabel: Label!
    @IBOutlet var newPasswordTextField: TextField!
    
    @IBOutlet var check1: UIButton!// 4 digitos
    @IBOutlet var check1Label: Label!
    @IBOutlet var check2: UIButton!// que contenga un numero
    @IBOutlet var check2Label: Label!
    
    @IBOutlet var repeatNewPasswordLabel: Label!
    @IBOutlet var repeatNewPasswordTextField: TextField!
    
    @IBOutlet var changePasswordButton: Button!
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bind(){
        viewModel.showTitles = showTitles(titles:)
        viewModel.showToast = show(message:)
        viewModel.backPressed = backPressed
    }
    func backPressed(){
        self.navigationController?.popViewController(animated: true)
       /* let storyBoard = UIStoryboard(name: "Settings", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SettingsID")
        self.navigationController?.pushViewController(viewController, animated: true)*/
    }
    func showTitles(titles:[String]){
        
        //tap gestures
        newPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        beforePasswordLabel.setSubTitleViewLabel(with: titles[0])
        beforePasswordTextField.setPassword(with: "" )
        check1Label.text = "4 Caracteres"
        check2Label.text = "Debe contener un número"
        newPasswordLabel.setSubTitleViewLabel(with: titles[1])
        newPasswordTextField.setPassword(with: "")
        repeatNewPasswordLabel.setSubTitleViewLabel(with: titles[2])
        repeatNewPasswordTextField.setPassword(with: "" )
        changePasswordButton.setFirstButton(with: titles[3])
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        var numbers = 0
        self.newPassword = newPasswordTextField.text!
        if(self.newPassword.count == 4){
            check1.setImage(UIImage(named: "ic_check_green"), for: .normal)
            check1Label.textColor = #colorLiteral(red: 0.5450980392, green: 0.7647058824, blue: 0.2901960784, alpha: 1)
            condition1 = true
        }else{
            check1.setImage(UIImage(named: "ic_equis"), for: .normal)
            check1Label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            condition1 = false
        }
        for data in self.newPassword{
            if(data.isNumber){
                numbers += 1
            }
        }
        if (numbers>0){
            check2.setImage(UIImage(named: "ic_check_green"), for: .normal)
            check2Label.textColor = #colorLiteral(red: 0.5450980392, green: 0.7647058824, blue: 0.2901960784, alpha: 1)
            condition2 = true
        }else{
            check2.setImage(UIImage(named: "ic_equis"), for: .normal)
            check2Label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            condition2 = false
        }
        
    }
    
    
    @IBAction func tapChangePassword(_ sender: Any) {
        viewModel.changePassword(beforePassword: beforePasswordTextField.text!, newPassword: newPasswordTextField.text!,confirmPassword: repeatNewPasswordTextField.text!,condition1: condition1,condition2: condition2)
        
    }
    
    func show(message:String){
        showToast(message: message)
    }
    
    @IBAction func eyePassword(_ sender: Any) {
        if(stateEye == 0){
            eye1.setImage(UIImage(named: "ic_eye_active"), for: .normal)
            stateEye = 1
            beforePasswordTextField.isSecureTextEntry = false
        }else{
            eye1.setImage(UIImage(named: "ic_visibility_off"), for: .normal)
            stateEye = 0
            beforePasswordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func eyeNewPassword(_ sender: Any) {
        if(stateEye2 == 0){
            eye2.setImage(UIImage(named: "ic_eye_active"), for: .normal)
            stateEye2 = 1
            newPasswordTextField.isSecureTextEntry = false
        }else{
            eye2.setImage(UIImage(named: "ic_visibility_off"), for: .normal)
            stateEye2 = 0
            newPasswordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func eyeConfirmPassword(_ sender: Any) {
        if(stateEye3 == 0){
            eye3.setImage(UIImage(named: "ic_eye_active"), for: .normal)
            stateEye3 = 1
            repeatNewPasswordTextField.isSecureTextEntry = false
        }else{
            eye3.setImage(UIImage(named: "ic_visibility_off"), for: .normal)
            stateEye3 = 0
            repeatNewPasswordTextField.isSecureTextEntry = true
        }
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
