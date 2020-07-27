import UIKit

class NotifyViewController: UIViewController {
    // Mark: - ViewModel
    var viewModel: NotifyViewModelProtocol! = NotifyViewModel()
    //Mark: - DataSource
    private var agendaCollectionViewDD: NotifyDatasourceAndDelegate!
    // Mark: - Properties
    var agendaList = [Notify]()
    @IBOutlet var agendaCollectionView: UICollectionView!
    @IBOutlet weak var btnHideNotification: UIButton!
    @IBOutlet weak var notifyView: UIView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var  notifySelectId = ""
    var position = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Notificaciones", message: "Obteniendo notificaciones...")
        bind()
        viewModel.viewDidLoad()
    }
    /**
    Inicializa el viewmodel.
    */
    func bind(){
        viewModel.loadDatasources = loadDatasources(datasource:)
        viewModel.showTitles = showTitles(items:)
        viewModel.successHideNotify = successHideNotify
    }
    func showTitles(items: [Notify]){
        
    }
    /**
    Cargar la data traida desde el servidor y lo posiciona en un collectionview
     - Parameters:
        - datasource: lista de notificaciones
    */
    func loadDatasources(datasource: [Notify]) {
        agendaCollectionViewDD = NotifyDatasourceAndDelegate(items: datasource, viewModel: viewModel, parentView: self)
        agendaCollectionView.dataSource = agendaCollectionViewDD
        agendaCollectionView.delegate = agendaCollectionViewDD
        self.agendaList = datasource
        self.agendaCollectionView.reloadData()
    }
    
    
    @IBAction func hideNotify(_ sender: Any) {
        viewModel.hideNofity(clienteId: appDelegate.usuario.clienteId, notifySelectId: notifySelectId)
    }
    
    /**
    Muestra la opcion para ocultar la notificacion.
     */
    func showViewOption(posX:CGFloat, posY:CGFloat,notifySelectID: String,position:Int){
        self.notifyView.alpha = 1
        self.notifyView.isUserInteractionEnabled = true
        self.notifySelectId = notifySelectID
        self.position = position
        self.btnHideNotification.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self.btnHideNotification.titleLabel?.font.pointSize)!)
        
        self.btnHideNotification.frame = CGRect(x: posX - self.btnHideNotification.frame.width, y: posY - self.btnHideNotification.frame.height, width: self.btnHideNotification.frame.width, height: self.btnHideNotification.frame.height)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideNotifyView(sender:)))
        notifyView.isUserInteractionEnabled = true
        notifyView.addGestureRecognizer(tap)
        
    }
    
    @objc func hideNotifyView( sender: UITapGestureRecognizer){
        self.notifyView.alpha = 0
        self.notifyView.isUserInteractionEnabled = false
    }
    /**
    Actualiza la lista de notificaciones luego de remover una.
     */
    func successHideNotify(){
        self.notifyView.alpha = 0
        self.notifyView.isUserInteractionEnabled = false
        self.agendaCollectionViewDD.items.remove(at: position)
        self.agendaCollectionView.reloadData()
        self.position = -1
        print("success hide notification")
        
    }
    
    func errorHideNotify(){
        self.notifyView.alpha = 0
        self.notifyView.isUserInteractionEnabled = false
        print("error hide notification")
    }
    
}
