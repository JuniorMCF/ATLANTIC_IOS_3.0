import UIKit

class RegisterSucessViewController: UIViewController {

    var viewModel: RegisterSucessViewModelProtocol! = RegisterSucessViewModel()
    
 
    @IBOutlet var titleLabel: Label!
    @IBOutlet var dniTextField: TextField!
    @IBOutlet var passwordTextField: TextField!
    @IBOutlet var advertenciaTextArea: UITextView!
    @IBOutlet var confirmPasswordTextField: TextField!
    @IBOutlet var registerButton: Button!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    var dni = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Registro", message: "Registrando usuario...")
        bind()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bind(){
        viewModel.pushRegisterUser = pushRegisterUser(response: )
        viewModel.showToast = show(response:)
        viewModel.showTitles = showTitles(data:)
    }
    func showTitles(data:[String]){
        titleLabel.setTitleViewLabel(with: data[0])
        dniTextField.setDNIStyleSucessRegister(with: data[1])
        passwordTextField.setPasswordStyleRegisterSuccess(with: data[2])
        advertenciaTextArea.text = data[3]
        advertenciaTextArea.textColor = UIColor.white
        confirmPasswordTextField.setPasswordStyle(with: data[4])
        registerButton.setFirstButton(with: "Registrarse")
    }
    func show(response:String){
        self.showToast(message: response)
    }
    func pushRegisterUser(response:String){
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginID") as! LoginViewController
        viewController.state = true
      
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func tapRegisterUser(_ sender: Any) {
        viewModel.registerUser(dni:dni , number: dniTextField.text!, password: passwordTextField.text!, repeatpass: confirmPasswordTextField.text!)
        
    }
    
  

}
