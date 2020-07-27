import UIKit

class TrophyLoseViewController: UIViewController {
    // Mark: - ViewModel
    
    private var viewModel: TrophyLoseViewModelProtocol = TrophyLoseViewModel()
    
    //Mark: - DataSource & Delegate
    
    private var trophyLoseCollectionViewDD: TrophyLoseCollectionViewDatasourceAndDelegate!
    
    
    @IBOutlet var nItem: UINavigationItem!
    
    @IBOutlet var trophyLoseCollectionView: UICollectionView!
    // Mark: - Properties
    var torneo = Tournament()
    
    @IBOutlet var fechaLabel: Label!
  
    @IBOutlet var puestoLabel: Label!
    
    @IBOutlet var posicionLabel: Label!
    
    @IBOutlet var puntosLabel: Label!
    @IBOutlet weak var faltanLabel: Label!
    
    
    @IBOutlet var PuestoTitle: Label!
    @IBOutlet var NombreTitle: Label!
    @IBOutlet var puntosTitle: Label!
    @IBOutlet var PremioLabel: Label!
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var FechaActualizacionLabel: Label!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var category: [TournamentTable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: torneo.nombre, message: "Obteniendo Posiciones ...")
        bind()
        
        let fechaActual = Utils().getFechaActual()
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: torneo.nombre, promocionId: String(torneo.pomocion_id))
        
        viewModel.viewDidLoad(promocionId: String(torneo.pomocion_id))
        presentTitles(data: torneo)
    }
    
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.loadDatasources = loadDatasources
    }
    
    
    /**
    Notifica al viewmodel para traer la  data de torneos desde el webservice
     - Parameters:
        - data: Objeto tournament
    */
    
    func presentTitles(data:Tournament){
        nItem.title = torneo.nombre
        PuestoTitle.text = "Puesto"
        NombreTitle.text = "Nombre"
        puntosTitle.text = "Puntos"
        PremioLabel.text = "Premio"
        let fecha = (torneo.fechaActualizacion as NSString).doubleValue
        let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")
        
        let txtFecha = dateFormatter.string(from: date)
        let txtHour = dateFormatter2.string(from: date)
        
        FechaActualizacionLabel.setDateModify(with: "actualizado el \(txtFecha) a las \(txtHour) hrs")
        
        
        
        fechaLabel.setSubTitleViewLabelCenterGray(with: "Fecha "+torneo.fechaTexto+"")
        puestoLabel.setSubTitleViewLabelCenterGray(with: "Usted ocupa el puesto")
        puntosLabel.setSubTitleViewLabelCenterGray(with: "Tiene hasta el momento "+String(torneo.puntaje)+" puntos")
        posicionLabel.setSubTitleViewLabelCenterLarge(with: ""+String(torneo.posicion)+"°")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        
       
        
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))

    }
    
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showTerms()
    }
    
    /**
    Cargar la data traida desde el servidor y lo posiciona en un tableView.
     - Parameters:
        - datasource: Lista de torneos
    */
    func loadDatasources(datasource: [TournamentTable]) {
        
        if(torneo.posicion > 1 ){
                let puesto = torneo.posicion - 1
            let puntosFalta = datasource[puesto - 1].puntaje - torneo.puntaje
                faltanLabel.alpha = 1
            faltanLabel.setSubTitleViewLabelCenterGray(with: "le faltan " + String(puntosFalta) + " para llegar al puesto " + String(puesto))
                   
               }else{
                   faltanLabel.alpha = 0
               }
        
        trophyLoseCollectionViewDD = TrophyLoseCollectionViewDatasourceAndDelegate(items: datasource, viewModel: viewModel,pos: self.torneo.posicion)
        trophyLoseCollectionView.dataSource = trophyLoseCollectionViewDD
        trophyLoseCollectionView.delegate = trophyLoseCollectionViewDD
        self.category = datasource
        self.trophyLoseCollectionView.reloadData()
        
        if(datasource.count > 1){
            if(torneo.posicion < 1){
                let puesto = torneo.posicion - 1
                let puntosFalta = datasource[puesto - 1].puntaje - torneo.puntaje
                faltanLabel.setSubTitleViewLabelCenterGray(with: "Le faltan "+String(puntosFalta)+" puntos para llegar al puest " + String(puesto))
                faltanLabel.alpha = 1
            }
            else{
                faltanLabel.alpha = 0
            }
        }
    }

}
