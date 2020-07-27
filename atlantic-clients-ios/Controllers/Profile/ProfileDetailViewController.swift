import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ProfileDetailViewController: UIViewController {
    //MARK: - ViewModel
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
    private var constraint : NSLayoutConstraint!
    @IBOutlet weak var addressText: UILabel!
    
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
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentToast = presentToast(response:)
    }
    /**
     Muestra un mensaje en pantalla
     */
    func presentToast(response:String){
        denyModify()
        let date = birthdateTextField.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateObj = dateFormatter.date(from: date)
        let fecha = dateObj!.millisecondsSince1970
        let datestring = Int64(fecha)

        appDelegate.usuario.fechaNac = String(datestring)
        appDelegate.usuario.celular = phoneTextField.text!
        appDelegate.usuario.email = emailTextField.text!
        appDelegate.usuario.direccion = addressTextField.text!
        self.showToast(message: response)
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
    - Parameters:
       - titles : titulo de todos los elementos
    */
    func showTitles(titles: DetailTitles) {
        let usuario = appDelegate.usuario
       
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
        addressText.text = usuario.direccion
        addressText.fontSizeScaleFamily(family: "Avenir-Medium", size: 15)
        saveButton.setRemindButton(with: titles.saveTitle)
    }
    /**
    Mostrar y ocultar vistas al aceptar la modificacion del perfil
     */
    func allowModify(){
        addressText.alpha = 0
        addressTextField.alpha = 1
        addressText.text = addressTextField.text!
        let usuario = appDelegate.usuario
        editButton.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        birthdateTextField.isUserInteractionEnabled =  true
        dniTextField.isUserInteractionEnabled =  false
        phoneTextField.isUserInteractionEnabled =  true
        emailTextField.isUserInteractionEnabled =  true
        addressTextField.isUserInteractionEnabled =  true
        saveButton.isUserInteractionEnabled =  true
        constraint.constant = 40
        constraint.isActive = true
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
        
        saveButton.alpha = 1.0
        
 
        
        birthdateTextField.setBorderBottom()
        phoneTextField.setBorderBottom()
        emailTextField.setBorderBottom()
        addressTextField.setBorderBottom()
        saveButton.isUserInteractionEnabled =  true
        
    }
    /**
    Mostrar y ocultar vistas al denegar la modificacion del perfil
     */
    func denyModify(){
        addressText.alpha = 1
        addressTextField.alpha = 0
        let usuario = appDelegate.usuario
        editButton.isUserInteractionEnabled = true
        nameTextField.isUserInteractionEnabled = false
        birthdateTextField.isUserInteractionEnabled = false
        dniTextField.isUserInteractionEnabled = false
        phoneTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        addressTextField.isUserInteractionEnabled = false
        saveButton.isUserInteractionEnabled = false
        //quitamos los underlines

        birthdateTextField.delBorderBottom()
        
        phoneTextField.delBorderBottom()
        emailTextField.delBorderBottom()
        addressTextField.delBorderBottom()
        
        constraint = self.saveButton.heightAnchor.constraint(equalToConstant: 0)
        constraint.isActive = true
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
        saveButton.alpha = 0.0
        
    }
    
    
    @IBAction func tapEditButton(_ sender: Any) {
        allowModify()
        
    }
    @IBAction func tapSaveButton(_ sender: Any) {
        
        viewModel.saveProfile(celular:phoneTextField.text!, direccion:addressTextField.text!, fechaNac:birthdateTextField.text!, email:emailTextField.text!, clienteId :appDelegate.usuario.clienteId)
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

