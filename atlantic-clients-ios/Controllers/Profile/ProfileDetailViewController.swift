//
//  ProfileDetailViewController.swift
//  clients-ios
//
//  Created by Jhona on 8/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
class ProfileDetailViewController: UIViewController {
    
    var viewModel: ProfileDetailViewModelProtocol! = ProfileDetailViewModel()
    
    //MARK: - IBOulets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var nameTextField: TextFieldDetails!
    @IBOutlet weak var birthdateLabel: Label!
    @IBOutlet weak var birthdateTextField: TextFieldDetails!
    @IBOutlet weak var dniLabel: Label!
    @IBOutlet weak var dniTextField: TextFieldDetails!
    @IBOutlet weak var phoneLabel: Label!
    @IBOutlet weak var phoneTextField: TextFieldDetails!
    @IBOutlet weak var emailLabel: Label!
    @IBOutlet weak var emailTextField: TextFieldDetails!
    @IBOutlet weak var addressLabel: Label!
    @IBOutlet weak var addressTextField: TextFieldDetails!
    @IBOutlet weak var saveButton: Button!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        denyModify()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2;
        profileImageView.clipsToBounds = true;
        nameTextField.delegate = self
        birthdateTextField.delegate = self
        dniTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        
        nameTextField.returnKeyType = .next

        birthdateTextField.returnKeyType = .next
        dniTextField.returnKeyType = .next
        phoneTextField.returnKeyType = .next
        emailTextField.returnKeyType = .next
        addressTextField.returnKeyType = .done
        
        addTapGesture()
        
        bind()
        viewModel.viewDidLoad()
        
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
    }
    
    func showTitles(titles: DetailTitles) {
        let usuario = appDelegate.usuario
        let dominio = "https://wsclienteapp.azurewebsites.net/admin/upload/fotos/"
        AF.request(dominio + usuario.clienteId + ".JPEG").responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                self.profileImageView.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        
        nameLabel.setTitleProfileLabel(with: titles.nameTitle)
        nameTextField.setTextFieldStyle(with: usuario.nombre)
        birthdateLabel.setTitleProfileLabel(with: titles.birthdateTitle)
        let fechaNac = (usuario.fechaNac as NSString).doubleValue
        let date = Date(timeIntervalSince1970: TimeInterval(fechaNac/1000.0))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let txtFecha = dateFormatter.string(from: date)
        
        birthdateTextField.setTextFieldStyle(with: txtFecha)
        dniLabel.setTitleProfileLabel(with: titles.dniTitle)
        dniTextField.setTextFieldStyle(with: usuario.dni)
        phoneLabel.setTitleProfileLabel(with: titles.phoneTitle)
        phoneTextField.setTextFieldStyle(with: usuario.celular)
        emailLabel.setTitleProfileLabel(with: titles.emailTitle)
        emailTextField.setTextFieldStyle(with: usuario.email)
        addressLabel.setTitleProfileLabel(with: titles.addressTitle)
        addressTextField.setTextFieldStyle(with: usuario.direccion)
        saveButton.setRemindButton(with: titles.saveTitle)
    }
    func allowModify(){
        editButton.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = true
        birthdateTextField.isUserInteractionEnabled =  true
        dniTextField.isUserInteractionEnabled =  true
        phoneTextField.isUserInteractionEnabled =  true
        emailTextField.isUserInteractionEnabled =  true
        addressTextField.isUserInteractionEnabled =  true
        saveButton.isUserInteractionEnabled =  true
        saveButton.alpha = 1.0
    }
    func denyModify(){
        nameTextField.isUserInteractionEnabled = false
        birthdateTextField.isUserInteractionEnabled = false
        dniTextField.isUserInteractionEnabled = false
        phoneTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        addressTextField.isUserInteractionEnabled = false
        saveButton.isUserInteractionEnabled = false
        saveButton.alpha = 0.0
    }
    
    @IBAction func tapEditButton(_ sender: Any) {
        allowModify()
        
    }
    @IBAction func tapSaveButton(_ sender: Any) {
        //viewModel.saveProfile()
    }
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}

extension ProfileDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == birthdateTextField {
            birthdateTextField.becomeFirstResponder()
        } else if textField == dniTextField {
            dniTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == addressTextField {
            addressTextField.becomeFirstResponder()
        }
        return true
    }
}
