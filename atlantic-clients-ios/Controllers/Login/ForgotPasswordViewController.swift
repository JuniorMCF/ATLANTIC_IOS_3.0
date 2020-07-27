import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var viewModel: ForgotPasswordViewModelProtocol! = ForgotPasswordViewModel()
    
    @IBOutlet var documentType: Label!
    @IBOutlet var documentTextField: TextField!
    @IBOutlet var recoveryPasswordButton: Button!
    var celular = ""
    var clientId = ""
    var ventana = 0
    //dropdown
    @IBOutlet var dropdownButton: UIButton!
    @IBAction func dropdown(_ sender: Any) {
        if(estado == 0){
            estado = 1
            showDropdown()
        }else{
            estado = 0
            hideDropdown()
        }
    }
    
    //dropdown Items
    
    @IBOutlet var dropdownView: UIView!
    @IBOutlet var dni: UIButton!
    @IBOutlet var pasaporte: UIButton!
    @IBAction func dniButton(_ sender: Any) {
        dropdownButton.setTitle("DNI", for: .normal)
        //documentTextField.setDNIStyle3(with: "DNI")
        documentTextField.placeholder = "DNI"
        hideDropdown()
        estado = 0
        option = 0 // DNI
    }
    @IBAction func passportButton(_ sender: Any) {
        dropdownButton.setTitle("Pasaporte", for: .normal)
        documentTextField.placeholder = "Passasporte"
        
       // documentTextField.setDNIStyle3(with: "Passaporte")
        hideDropdown()
        estado = 0
        option = 1 // Pasaporte
    }
    var estado = 0
    var option = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var iconExpand: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Recuperar contraseña", message: "Enviando código de verificación...")
        estado = 0
        dropdownView.alpha = 0.0
        dropdownView.isUserInteractionEnabled = false
        dropdownView.addShadow()
        documentTextField.setBorderBottom()
        option = 0 // 0: DNI  1: Pasaporte
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = nil
        
       
        
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.showToast = show(message:)
        viewModel.presentForgotPassword = presentForgotPassword(celular:clienteId:)
        viewModel.presentRecoveryPassword = presentRecoveryPassword
    }
    
    /**
     Redirige a la pantalla de recuperar contraseña
     */
    func presentRecoveryPassword(){
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let navViewController = storyboard.instantiateViewController(withIdentifier: "RecoveryPasswordID") as! RecoveryPasswordViewController
        navViewController.clienteId = self.clientId
        navViewController.celular = self.celular
        self.navigationController?.pushViewController(navViewController, animated: false)
        
       
    }
    
    func showDropdown(){
        dropdownView.isUserInteractionEnabled = true
        dropdownView.alpha = 1.0
        dni.isUserInteractionEnabled = true
        dni.alpha = 1.0
        pasaporte.isUserInteractionEnabled = true
        pasaporte.alpha = 1.0
    }
    
    func hideDropdown(){
        dropdownView.isUserInteractionEnabled = false
        dropdownView.alpha = 0.0
        dni.isUserInteractionEnabled = false
        dni.alpha = 0.0
        pasaporte.isUserInteractionEnabled = false
        pasaporte.alpha = 0.0
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - data : titulos de todos los elementos
    */
    func showTitles(titles: ForgotPasswordTitles) {
        
        documentType.setTitleForgotViewLabel(with: titles.screenTitle)
        
        recoveryPasswordButton.setForgotButton(with: titles.recoveryPassword)
        
       // documentTextField.setDNIStyle3(with: "DNI")
        documentTextField.setBottomBorder(withColor: .black)
        documentTextField.textColor = .black
        documentTextField.attributedPlaceholder = NSAttributedString(string: "DNI",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        
    }
    /**
     Muestra un mensaje en pantalla
     */
    func show(message:String){
        showToast(message: message)
    }
    /**
     Muestra la pantalla para recuperar la contraseña
     */
    func presentForgotPassword(celular:String,clienteId:String){
        ventana = 1
       documentType.setTitleForgotViewLabel(with: "CÓDIGO DE VERIFICACIÓN")
        documentTextField.text = ""
        documentTextField.placeholder = "Código"
        dropdownButton.alpha = 0
        dropdownButton.isUserInteractionEnabled = false
        iconExpand.alpha = 0
        self.celular = celular
        self.clientId = clienteId
    }
    
    @IBAction func tapRecoveryPassword(_ sender: Any) {
        if(ventana == 0){
           viewModel.getPhone(dni: documentTextField.text!, tipo: option)
        }else {
            viewModel.verifyCode(code: documentTextField.text!, celular: celular, clienteId: clientId)
        }
        
    }
    @IBAction func onBackPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let navViewController = storyboard.instantiateViewController(withIdentifier: "LoginID")
        navViewController.modalPresentationStyle = .fullScreen
        present(navViewController, animated: false, completion: nil)
    }

}

