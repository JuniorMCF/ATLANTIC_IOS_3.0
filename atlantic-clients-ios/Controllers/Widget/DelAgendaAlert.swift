import UIKit
import MaterialComponents.MaterialActivityIndicator

/**
Custom Alert view muestra una alerta con un estilo personalizado.
*/
class DelAgendaAlert: UIViewController {
    
    var viewParent : UIViewController!
    var titleP : String!
    var message : String!
    var agendaViewModel  :AgendaViewModelProtocol!
    var progressController : DelAgendaAlert!
    var isHome = false
    //variables para enviar
    var id = ""
    var eventoRegistroId = ""
    var clienteId = ""
    var acompanantes = 0
    var index = -1
    @IBOutlet var titleProgress: UITextView!
    @IBOutlet var messageProgress: UITextView!
    @IBOutlet var vContainer: UIView!
    @IBOutlet var ok: UIButton!
    @IBOutlet var cancel: UIButton!
    
    
    
    convenience init() {
        self.init(parent: UIViewController(),title: "", message: "",eventoRegistroId:"",clienteId:"",viewModel:AgendaViewModel(),index:-1)
    }
    
    /**
     Inicializacion del customAlert.
     - Parameters:
        - parent: ViewController donde se inflara el alert.
        - title: Titulo del alert.
        - message: Mensaje que se mostrara en el alert.
        - eventoRegistroId: id del evento en agenda
        - clienteId: id del cliente
        - index: indice donde se encuentra (Desayuno, almuerzo, etc)
     */

    init(parent: UIViewController,title: String, message: String ,eventoRegistroId:String,clienteId:String,viewModel:AgendaViewModelProtocol,index:Int){
        self.viewParent = parent
        self.titleP = title
        self.message = message
        self.eventoRegistroId = eventoRegistroId
        self.clienteId = clienteId
        self.agendaViewModel = viewModel
        self.index = index
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
        ok.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        cancel.setTitle("CANCELAR", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
    }
    /**
    Accion al dar click en Aceptar.
    */
    @IBAction func tapOk(_ sender: Any) {
        self.agendaViewModel.borrarAgenda(eventoRegistroId: self.eventoRegistroId, clienteId: self.clienteId,index:self.index)
        self.hideAlert()
       
    }
    /**
    Accion al dar click en Cancelar.
    */
    @IBAction func tapCancel(_ sender: Any) {
            self.hideAlert()
    }
    
    /**
    Mostrar el Alert en la pantalla.
    */
    func showAlert(){
        let storyboard = UIStoryboard(name: "DelAgenda", bundle: nil)
        progressController = (storyboard.instantiateViewController(withIdentifier: "delAgendaID") as! DelAgendaAlert)
       
        progressController.modalPresentationStyle = .overFullScreen
        
        viewParent.tabBarController?.view.addSubview(progressController.view)
       
        progressController.agendaViewModel = self.agendaViewModel
        progressController.viewParent = self.viewParent
        progressController.eventoRegistroId = self.eventoRegistroId
        progressController.clienteId = self.clienteId
        progressController.index = self.index
        self.progressController.titleProgress.text = self.titleP
        self.progressController.messageProgress.text = self.message
   
    }
    /**
    Ocultar alert.
    */
    func hideAlert(){
        
        self.view.removeFromSuperview()
      
    }


}
