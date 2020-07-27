import UIKit
import MaterialComponents.MaterialActivityIndicator
/**
 Progress dialog custom, muestra mensajes en pantalla.
 */
class CustomProgress: UIViewController {
    
    var viewParent : UIViewController!
    var titleP : String!
    var message : String!
    var progressController : CustomProgress!
    var isHome = false
    @IBOutlet weak var titleProgress: UITextView!
    @IBOutlet weak var messageProgress: UILabel!
    @IBOutlet weak var vProgress: UIView!
    @IBOutlet weak var vContainer: UIView!
    
    convenience init() {
        self.init(parent: UIViewController(),title: "", message: "")
    }
    /**
     Inicializaacion del customprogress
     - Parameters:
        - parent: Viewcontroller donde se inflara la vista
        - message : Mensaje a mostrar en el custom progress
        - title : Titulo del custom progress
     */
    init(parent: UIViewController,title: String, message: String) {
        self.viewParent = parent
        self.titleP = title
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /**
     Configuracion inicial del customprogress
     */
    override func viewDidLoad() {
        super.viewDidLoad()
       let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [UIColor.init(red: 115/255, green: 88/255, blue: 88/255, alpha: 1)]
        activityIndicator.radius = 30.0
        activityIndicator.strokeWidth = 6
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: self.vProgress.frame.width, height: self.vProgress.frame.height)
        vContainer.layer.cornerRadius = 10.0
       vProgress.addSubview(activityIndicator)
       activityIndicator.startAnimating()
    }
    
 

    /**
     Muestra el progress en pantalla.
     */
    func showProgress(){
        let storyboard = UIStoryboard(name: "CustomProgress", bundle: nil)
        progressController = (storyboard.instantiateViewController(withIdentifier: "customProgress") as! CustomProgress)
        if(isHome){
            progressController.modalPresentationStyle = .overCurrentContext
            
        }
        else{
            progressController.modalPresentationStyle = .overFullScreen
        }
        self.isHome = false
   
        
        progressController.isHome = isHome
        viewParent.navigationController?.present(progressController, animated: false, completion: {
            self.progressController.titleProgress.text = self.titleP
            self.progressController.messageProgress.text = self.message
        })
    }
    
    /**
    *Oculta el progress en pantalla.
    */
    func hideProgress(){
        if(progressController != nil){
            progressController.dismiss(animated: false, completion: nil)
        }
        
    }
    
    

}
