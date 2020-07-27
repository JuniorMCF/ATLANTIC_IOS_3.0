import UIKit

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModelProtocol! = ProfileViewModel()
    
    // MARK: - IBOulets

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileLabel: Label!
    @IBOutlet weak var diaryView: UIView!
    @IBOutlet weak var diaryLabel: Label!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var contactLabel: Label!
    @IBOutlet weak var separatorView: View!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsLabel: Label!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsLabel: Label!
    @IBOutlet weak var logOutView: UIView!
    @IBOutlet weak var logOutLabel: Label!
 
    var customLogout : CustomLogoutAlert!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapProfile)))
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSettings)))
        logOutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLogOut)))
        contactView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapNotify)))
        diaryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAgenda)))
        termsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerms)))
        bind()
        viewModel.viewDidLoad()
        
        separatorView.addSelectBorder(toSide: .Bottom, withColor: UIColor(white: 0.3, alpha: 1).cgColor, andThickness: 1, positionX: 0, positionY: 0, widthLayer: view.frame.width - 64)
        
    }
    @objc private func tapTerms(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones.pdf")
        terminos.showTerms()
    }
    
    @objc private func tapProfile() {
        viewModel.tapProfile()
    }
    
    @objc private func tapSettings() {
        viewModel.tapSettings()
    }
    
    @objc private func tapLogOut() {
        appDelegate.customLogout = CustomLogoutAlert(parent: self,title: "Atlantic", message: "¿Desea cerrar sesión?",tipo:"profileLogout")
        appDelegate.customLogout.showProgress()
    }
    @objc private func tapNotify(){
        viewModel.pushNotify()
    }
    @objc private func tapAgenda(){
        viewModel.pushAgenda()
    }
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.pushProfileDetail = pushProfileDetail
        viewModel.pushSettings = pushSettings
        viewModel.presentLogin = presentLogin
        viewModel.presentNotify = presentNotify
        viewModel.presentAgenda = presentAgenda
    }
    /**
    Proporciona estilo a los elementos de la vista.
    - Parameters:
       - titles : titulo de todos los elementos
    */
    func showTitles(titles: ProfileTitles) {
        profileLabel.setSubTitleViewLabel(with: titles.profilePlaceHolder)
        diaryLabel.setSubTitleViewLabel(with: titles.diaryPlaceHolder)
        contactLabel.setSubTitleViewLabel(with: titles.contactPlaceHolder)
        settingsLabel.setSubTitleViewLabel(with: titles.settingsPlaceHolder)
        termsLabel.setSubTitleViewLabel(with: titles.termsPlaceHolder)
        logOutLabel.setSubTitleViewLabel(with: titles.logOutPlaceHolder)
        
    }
    /**
     Dirige hacia la pantalla de perfil
     */
    func pushProfileDetail() {
        let storyBoard = UIStoryboard(name: "ProfileDetail", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ProfileDetailID")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    /**
    Dirige hacia la pantalla de configuracion
    */
    func pushSettings() {
        let storyBoard = UIStoryboard(name: "Settings", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SettingsID")
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    /**
    Dirige hacia la pantalla de notificaciones
    */
    func presentNotify(){
        let storyBoard = UIStoryboard(name: "Notify", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "NotifyID")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    /**
    Dirige hacia la pantalla de login
    */
    func presentLogin() {
     
        /*if let destinationViewController = self.navigationController?.viewControllers
            
            .filter(
                
                {$0.classForCoder == LoginViewController.self})
            
            .first {
            
            self.navigationController?.popToViewController(destinationViewController, animated: false)
            
            
        }*/
    //    appDelegate.navigationController = self.navigationController
        
      //  self.navigationController!.viewControllers.removeAll()
        /*let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginID")
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.makeKeyAndVisible()*/
       /*viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)*/
        
        
    }
    /**
    Dirige hacia la pantalla de agenda
    */
    func presentAgenda(){
        let storyBoard = UIStoryboard(name: "ProfileAgenda", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ProfileAgendaID")
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }


}
