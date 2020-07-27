import UIKit

class RegisterDocumentViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel: RegisterDocumentViewModelProtocol! = RegisterViewModel()
    
    // MARK: - IBOulets
    
    @IBOutlet weak var titleLabel: Label!
    
    @IBOutlet var docNumberTextField: TextField!
    @IBOutlet weak var docNumberLabel: Label!
    @IBOutlet weak var nextButton: Button!
    
    let pickerData: [String] = ["DNI", "Pasaporte", "Carnet de extranjeria"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func onBackLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Registro", message: "Validando datos...")
        
        addTapGesture()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
            
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        
        let thePicker = UIPickerView()
       
        thePicker.dataSource = self
        thePicker.delegate = self
        
        bind()
        viewModel.viewDidLoad()
    }
    
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.pushRegisterPassword = pushRegisterPassword
        viewModel.showToast = toast(message:)
    }
    /**
    Mostrar un mensaje en pantalla.
    */
    func toast(message:String){
         self.showToast(message: message)
    }
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - titles : tituloss de todos los elementos
    */
    func showTitles(titles: RegisterDocumentTitles) {
        titleLabel.setTitleViewLabel(with: titles.screenTitle)
        docNumberLabel.setClubTitle2(with: titles.docNumberTitle)
        docNumberTextField.setDNIStyle2(with: "")
        nextButton.setFirstButton2(with: titles.nextButtonTitle)
        
    
    }
    
    /**
     Retornar a la pantalla de password
     */
    
    func pushRegisterPassword(dni:String) {
        let storyBoard = UIStoryboard(name: "Register", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RegisterSuccessID") as! RegisterSucessViewController
        viewController.dni = dni
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
