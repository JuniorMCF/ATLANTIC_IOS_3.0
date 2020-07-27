import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    var viewModel: RecoveryPasswordViewModelProtocol! = RecoveryPasswordViewModel()
    
    @IBOutlet var titleLabel: Label!
    @IBOutlet var passwordTextField: TextField!
    @IBOutlet var repeatPasswordLabel: Label!
    @IBOutlet var repeatPasswordTextField: TextField!
    @IBOutlet var ContinueButton: Button!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var clienteId : String!
    var celular : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Recuperar contraseña", message: "Guardando cambios...")
       
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /**
    Inicializa el viewmodel.
    */
    func bind(){
        viewModel.showTitles = showTitles(data: )
        viewModel.showToast = show(message: )
        viewModel.passwordRecovery = passwordRecovery
    }
    override func viewWillDisappear(_ animated: Bool) {
    //    self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - data : titulos de todos los elementos
    */
    func showTitles(data:[String]){
       // titleLabel.setClubTitle(with: data[0])
        //passwordTextField.setPasswordStyle(with: data[1])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: data[1],
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.textColor = .black
        passwordTextField.setBottomBorder(withColor: .black)
        //repeatPasswordLabel.setClubTitle(with: data[2])
        repeatPasswordLabel.textColor = .black
     
        //repeatPasswordTextField.setPasswordStyle(with: data[3])
        repeatPasswordLabel.textColor = .black
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: data[3],
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        repeatPasswordTextField.setBottomBorder(withColor: .black)
        ContinueButton.setFirstButton(with: data[4])
    }
    /**
     Muestra un mensaje en pantalla
     */
    func show(message:String){
        showToast(message: message)
    }
    
    
    @IBAction func tapNext(_ sender: Any) {
        viewModel.recoveryPassword(clienteId: self.clienteId,password1: passwordTextField.text!,password2: repeatPasswordTextField.text!)
    }

    func passwordRecovery(){
        self.navigationController?.popToRootViewController(animated: false)
    }
    

}
