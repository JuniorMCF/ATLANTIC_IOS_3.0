import UIKit
import MaterialComponents.MaterialActivityIndicator

/**
 Custom Alert view muestra una alerta con un estilo personalizado.
 */

class CustomLogoutAlert: UIViewController {
    
    var viewParent : UIViewController!
    var titleP : String!
    var message : String!
    var progressController : CustomLogoutAlert!
    var isHome = false

    @IBOutlet var titleProgress: UITextView!
    @IBOutlet var messageProgress: UITextView!
    @IBOutlet var vContainer: UIView!
    @IBOutlet var ok: Button!
    @IBOutlet var cancel: Button!
    var tipo = ""
    
    convenience init() {
        self.init(parent: UIViewController(),title: "", message: "",tipo: "")
    }

    /**
    Inicializacion del customAlert.
     - Parameters:
        - parent: ViewController donde se inflara la vista.
        - title: Titulo del alert.
        - message: Mensaje que mostrara el alert.
        - tipo: Estilo del alert.
     */
    init(parent: UIViewController,title: String, message: String,tipo:String) {
        self.viewParent = parent
        self.titleP = title
        self.message = message
        self.tipo = tipo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /**
    Configuracion inicial del CustomAlert.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
       let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [UIColor.init(red: 115/255, green: 88/255, blue: 88/255, alpha: 1)]
        activityIndicator.radius = 30.0
        activityIndicator.strokeWidth = 6
        vContainer.layer.cornerRadius = 10.0
        activityIndicator.startAnimating()
        ok.setTitle("ACEPTAR", for: .normal)
        ok.setTitleColor(.white, for: .normal)
        ok.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        ok.layer.cornerRadius = 15.0
        cancel.setTitle("CANCELAR", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        cancel.layer.cornerRadius = 15.0
    }
    
    /**
     Accion al dar click en Aceptar.
     */
    @IBAction func tapOk(_ sender: Any) {
        print(self.tipo)
        Constants().saveLogin(isLogin: false)
        Constants().saveUsername(username: "")
        Constants().savePassword(password: "")
        Constants().saveTerminos(terminoState: false)
        
        if let destinationViewController = self.viewParent.parent?.navigationController?.viewControllers
            
            .filter(
                
                {$0.classForCoder == LoginViewController.self})
            
            .first {
            
            self.viewParent.parent?.navigationController?.popToViewController(destinationViewController, animated: false)
            
        }
        
        
    }
    /**
    Accion al dar click en cancelar..
    */
    @IBAction func tapCancel(_ sender: Any) {
            self.hideProgress()
    }
    
    /**
    Mostrar el Alert en la pantalla.
    */
    
    func showProgress(){
        let storyboard = UIStoryboard(name: "CustomLogout", bundle: nil)
        progressController = (storyboard.instantiateViewController(withIdentifier: "customLogout") as! CustomLogoutAlert)
       
        progressController.modalPresentationStyle = .overFullScreen
        progressController.viewParent = self.viewParent
        viewParent.tabBarController?.view.addSubview(progressController.view)
        
        self.progressController.titleProgress.text = self.titleP
        self.progressController.messageProgress.text = self.message
     
    }
    /**
    Ocultar el alert.
    */
    func hideProgress(){
        self.view.removeFromSuperview()
    }
    
    

}
