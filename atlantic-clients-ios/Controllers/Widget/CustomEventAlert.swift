import UIKit
import MaterialComponents.MaterialActivityIndicator
/**
Custom Alert view muestra una alerta con un estilo personalizado.
*/
class CustomEventAlert: UIViewController {
    
    var viewParent : UIViewController!
    var titleP : String!
    var message : String!
    var eventDetailViewModel :EventDetailViewModelProtocol =   EventDetailViewModel()
    var progressController : CustomEventAlert!
    var isHome = false
    //variables para enviar
    var id = ""
    var horarioId = ""
    var acompanantes = 0
    @IBOutlet var titleProgress: UITextView!
    @IBOutlet var messageProgress: UITextView!
    @IBOutlet var vContainer: UIView!
    @IBOutlet var ok: UIButton!
    @IBOutlet var cancel: UIButton!
    var tipo = ""
    
    convenience init() {
        self.init(parent: UIViewController(),title: "", message: "")
    }
    /**
    Inicializacion del customAlert.
     - Parameters:
        - parent: ViewController donde se inflara la vista.
        - title: Titulo del alert.
        - message: Mensaje que mostrara el alert.
     */
    init(parent: UIViewController,title: String, message: String ){
        self.viewParent = parent
        self.titleP = title
        self.message = message
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
        let parent = self.viewParent as! EventsDetailViewController
        parent.viewModel.saveData?()
        self.hideProgress()
        //
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
        let storyboard = UIStoryboard(name: "CustomEvent", bundle: nil)
        progressController = (storyboard.instantiateViewController(withIdentifier: "customEvent") as! CustomEventAlert)
       
        progressController.modalPresentationStyle = .overFullScreen
        
        viewParent.tabBarController?.view.addSubview(progressController.view)
       
        
        progressController.viewParent = self.viewParent
       // viewParent.view.addSubview(progressController.view)
        self.progressController.titleProgress.text = self.titleP
        self.progressController.messageProgress.text = self.message
       /* viewParent.navigationController?.present(progressController, animated: false, completion: {
            self.progressController.titleProgress.text = self.titleP
            self.progressController.messageProgress.text = self.message
        })*/
    }
    /**
    Ocultar el alert.
    */
    func hideProgress(){
        
        self.view.removeFromSuperview()
      
        //progressController.dismiss(animated: false, completion: nil)
    }
    
    

}