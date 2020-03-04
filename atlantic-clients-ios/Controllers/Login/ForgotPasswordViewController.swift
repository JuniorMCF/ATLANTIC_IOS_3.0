//
//  ForgotPasswordViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/1/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var viewModel: ForgotPasswordViewModelProtocol! = ForgotPasswordViewModel()
    
    @IBOutlet var documentType: Label!
    @IBOutlet var documentTextField: TextField!
    @IBOutlet var recoveryPasswordButton: Button!

    //dropdown
    @IBOutlet var dropdownButton: UIButton!
    @IBAction func dropdown(_ sender: Any) {
        
    }
    //dropdown Items
    
    @IBOutlet var dropdownView: UIView!
    @IBOutlet var dni: UIButton!
    @IBOutlet var pasaporte: UIButton!
    @IBAction func dniButton(_ sender: Any) {
        
    }
    @IBAction func passportButton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles:)
       
    }
    
    func showTitles(titles: ForgotPasswordTitles) {
        
        documentType.setTitleForgotViewLabel(with: titles.screenTitle)

        recoveryPasswordButton.setForgotButton(with: titles.recoveryPassword)
        
        
        
        
    }
    
    @IBAction func tapRecoveryPassword(_ sender: Any) {
        
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

