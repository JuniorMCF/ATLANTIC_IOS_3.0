//
//  RegisterViewController.swift
//  clients-ios
//
//  Created by Jhona on 7/26/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class RegisterDocumentViewController: UIViewController {
    
    var viewModel: RegisterDocumentViewModelProtocol! = RegisterViewModel()
    
    // MARK: - IBOulets
    
    @IBOutlet weak var titleLabel: Label!
    
    @IBOutlet var docNumberTextField: TextField!
    @IBOutlet weak var docNumberLabel: Label!
    @IBOutlet weak var nextButton: Button!
    
    let pickerData: [String] = ["DNI", "Pasaporte", "Carnet de extranjeria"]
    

    @IBAction func onBackLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        
        let thePicker = UIPickerView()
       
        thePicker.dataSource = self
        thePicker.delegate = self
        
        
        
        
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.pushRegisterPassword = pushRegisterPassword
    }
    
    func showTitles(titles: RegisterDocumentTitles) {
        titleLabel.setTitleViewLabel(with: titles.screenTitle)
        docNumberLabel.setClubTitle2(with: titles.docNumberTitle)
        docNumberTextField.setDNIStyle2(with: "")
        nextButton.setFirstButton2(with: titles.nextButtonTitle)
        
    
    }
    
    func pushRegisterPassword() {
        let storyBoard = UIStoryboard(name: "RegisterPassword", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RegisterPasswordID")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapNext(_ sender: Any) {
        let dni = docNumberTextField.text!
        viewModel.tapNext(dni: dni)
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
}

extension RegisterDocumentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
}
