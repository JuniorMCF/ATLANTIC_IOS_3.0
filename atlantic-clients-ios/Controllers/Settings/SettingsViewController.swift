import UIKit

class SettingsViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Mark: - ViewModel
    var viewModel: SettingsViewModelProtocol! = SettingsViewModel()
    
    @IBOutlet weak var activeLabel: Label!
    @IBOutlet weak var changePasswordLabel: Label!
    @IBOutlet var switchActive: UISwitch!
    @IBOutlet var changePasswordView: UIView!

    /**
     Activa y desactiva las notificaciones del usuario
     */
    @IBAction func isCheckedSwitch(_ sender: Any) {
        let check = sender as! UISwitch
        if(check.isOn == true){
            viewModel.changeSettings(clienteId: appDelegate.usuario.clienteId, isActivo: true)
        }else{
            viewModel.changeSettings(clienteId: appDelegate.usuario.clienteId, isActivo: false)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        switchActive.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        if(appDelegate.usuario.configNotify == true){
            switchActive.isOn = true
        }else{
            switchActive.isOn = false
        }
        
        
        viewModel.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapChangePassword(_:)))

        changePasswordView.addGestureRecognizer(tap)

        changePasswordView.isUserInteractionEnabled = true
 
        
    }
    
    /**
     Redirige a la pantalla de cambiar contraseña.
     */
    
    @objc func tapChangePassword(_ sender: UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "ChangePassword", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordID")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    /**
     Inicializa el viewmodel.
     */
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
    }
    
    /**
     Proporciona estilo a los elementos de la vista.
     - Parameters:
        - titles : titulo de todos los elementos
     */
    func showTitles(titles: SettingsTitles) {
        
        activeLabel.setSubTitleViewLabel(with: titles.activeTitle)
        changePasswordLabel.setSubTitleViewLabel(with: titles.changePassword)
        
    }

}
