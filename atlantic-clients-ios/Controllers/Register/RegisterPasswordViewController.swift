import UIKit

class RegisterPasswordViewController: UIViewController {
    
    var viewModel: RegisterPasswordViewModelProtocol! = RegisterPasswordViewModel()
    
    // MARK: - IBOulets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var phoneTextField: TextField2!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var passwordSpecsLabel: Label!
    @IBOutlet weak var passwordConfirmTextField: TextField!
    @IBOutlet weak var registerButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        bind()
        viewModel.viewDidLoad()
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .next
        passwordConfirmTextField.delegate = self
        passwordConfirmTextField.returnKeyType = .done
    }
    
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.presentLogin = presentLogin
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - titles : titulo de todos los elementos
    */
    func showTitles(titles: RegisterPasswordTitles) {
        titleLabel.setTitleViewLabel(with: titles.screenTitle)
        phoneTextField.setRegisterStyle(with: titles.phoneNumberPlaceholder)
        passwordTextField.setPasswordStyle(with: titles.passwordPlaceholder)
        passwordSpecsLabel.setTitleCardLabel(with: titles.passwordSpecsTitle)
        passwordConfirmTextField.setPasswordStyle(with: titles.passwordConfirmPlaceholder)
        registerButton.setFirstButton(with: titles.registerButtonTitle)
    }
    
    /**
    Navegar a la pantalla de login
     */
    func presentLogin() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func tapRegister() {
        viewModel.tapRegister()
        
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}

extension RegisterPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            passwordConfirmTextField.becomeFirstResponder()
        } else if textField == passwordConfirmTextField {
            passwordConfirmTextField.resignFirstResponder()
        }
        return true
    }
}
