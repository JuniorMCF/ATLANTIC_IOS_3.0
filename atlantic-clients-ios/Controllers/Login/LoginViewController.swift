import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginViewModelProtocol! = LoginViewModel()
    var progressController : CustomProgress!
    // MARK: - IBOulet
    var state = false
    @IBOutlet var titleLabel: Label!
    @IBOutlet var dniTextField: TextField!
    @IBOutlet var passwordTextField: TextField!
    @IBOutlet var loginButton: Button!
    @IBOutlet var newUserButton: Button!
    @IBOutlet var forgotPasswordButton: Button!
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var terminosButton: Button!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var estadoTerminos = false
    var splash : SplashLoginViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Login", message: "Iniciando Sesión ...")
        appDelegate.progressDialog.isHome = false
        splash = SplashLoginViewController(parent: self)
        loginButton.frame.size = CGSize(width:200 ,height:15)
        terminosButton.frame.size = CGSize(width: 18 , height: 18)
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        addTapGesture()
        bind()
        viewModel.viewDidLoad()
        if(Constants().getLogin()){
            splash.showSplash()
            viewModel.isLoggin()
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.dniTextField.text = ""
        self.passwordTextField.text = ""
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if(state){
            self.showToast(message: "Usuario registrado con exito")
        }
        
    }
    /**
    Inicializar Viewmodel.
     */
    
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.presentOnboarding = presentOnboarding
        viewModel.presentRegister = presentRegister
        viewModel.presentForgotPassword = presentForgotPassword
        viewModel.changeTerminos = changeTerminos(estado:)
        viewModel.showToastMessage = showToastMessage(message:)
        viewModel.presentSetData = presentSetData(user: password:)
    }
    
    /**
    Coloca datos en el campo usuario y password.
    - Parameters:
        - user: usuario del cliente
        - password: password del cliente
    */
    
    func presentSetData(user:String,password:String){
        dniTextField.text = user
        passwordTextField.text = password
    }
    /**
    *Dar estilo a todos los elementos de la pantalla
    */
    func showTitles(titles: LoginTitles) {
        titleLabel.setTitleViewLabel(with: titles.screenTitle)
        dniTextField.setDNIStyle(with: titles.dniPlaceholder)
        passwordTextField.setPasswordStyle(with: titles.passwordPlaceholder)
        loginButton.setFirstButton(with: titles.buttonTitle)
        newUserButton.setLinkButton(with: titles.newUserPlaceholder)
        forgotPasswordButton.setLinkButton(with: titles.forgotPasswordTitle)
        terminosLabel.setLinkLabel(with: "Acepto los términos y condiciones")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTerms)))
    }

    /**
    *Muestra los terminos y condiciones en pantalla
    */
    @objc func showTerms(){
            let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones.pdf")
            terminos.showTerms()
        }
    
    /**
    *Loguea al usuario y redirigue a la pantalla principal
    */
    func presentOnboarding() {
        splash.hideSplash()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainID")
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    /**
    *Muestra un mensaje en la pantalla
    */
    func showToastMessage(message:String){
        self.showToast(message: message)
    }
    
    /**
     *Redirige a la pantalla de registro
     */
    func presentRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: Bundle.main)
        let navViewController = storyboard.instantiateViewController(withIdentifier: "RegisterID")
        navViewController.modalPresentationStyle = .overCurrentContext
        self.navigationController?.pushViewController(navViewController, animated: true)
        //present(navViewController, animated: true, completion: nil)
    }
    /**
    *Redirige a la pantalla de recuperar password
    */
    func presentForgotPassword(){
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let navViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordID")
        
        self.navigationController?.pushViewController(navViewController, animated: true)
    }
 
    
    
    
    @IBAction func tapLogin() {
        let dni = dniTextField.text!
        let password = passwordTextField.text!
        
        viewModel.tapLogin(dni: dni,password: password,terminos: estadoTerminos)
    }
    
  
    @IBAction func tapTerminos(_ sender: Any) {
        viewModel.tapTerminos(estado:estadoTerminos)
    }
  
    @IBAction func tapNewUser() {
        viewModel.tapNewUSer()
    }
    
    @IBAction func tapForgotPassword() {
        viewModel.tapForgotPassword()
    }
    
    /**
    *Marca / desmarca el checkbutton de terminos y condiciones
    */
    func changeTerminos(estado:Bool){
        estadoTerminos = estado
        if(estadoTerminos == true){
            terminosButton.setImage(UIImage(named: "checked_checkbox"), for: .normal)
            
        }else{
            terminosButton.setImage(UIImage(named: "unchecked_checkbox"), for: .normal)
        }
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
