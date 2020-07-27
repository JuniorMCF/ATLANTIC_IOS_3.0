import UIKit

class AtlanticDerby2ViewController: UIViewController {

    private var ad2CollectionViewDD: AD2CollectionViewDelegateAndDatasource!
    
    var viewModel: AtlanticDerby2ViewModelProtocol! = AtlanticDerby2ViewModel()
    
    var benefit = Benefits()
    
    @IBOutlet var AD2CollectionView: UICollectionView!
    @IBOutlet var fechaLabel: Label!
    @IBOutlet var titleLabel: Label!
    
    @IBOutlet var proximaCarreraLabel: Label!
    
    @IBOutlet var recordatorioButton: Button!
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var fechaModificacionLabel: Label!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        AD2CollectionView.layer.cornerRadius = 25
        AD2CollectionView.backgroundColor =  #colorLiteral(red: 0.8431372549, green: 0.8470588235, blue: 0.862745098, alpha: 1)
        bind()
        let fechaActual = Utils().getFechaActual()
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: benefit.nombre, promocionId: String(benefit.promocion_id))
        viewModel.viewDidLoad()
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind(){
        
        viewModel.loadDataSources = loadDatasources(datasources:)
        viewModel.presentTitles = presentTitles(data:)
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - data : titulos de todos los elementos
    */
    func presentTitles(data:[String]){
        fechaLabel.setBenefitDetailTitleCenter(with: "¡Pronto tendrá más oportunidades de ganar!")
        titleLabel.setBenefitDetailTitleCenter(with: benefit.nombre)
        proximaCarreraLabel.setSubTitleViewLabelCenter(with: "Próxima carrera:\n"+benefit.fechaProximaTexto)
        recordatorioButton.setRemindButton(with: "Crear recordatorio")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        
        let fecha = (benefit.fechaActualizacion as NSString).doubleValue
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
        
        fechaModificacionLabel.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showTerms()
    }
    
    /**
     Carga la tabla de posiciones de la carrera
     - Parameters:
        - datasources: lista de posiciones
     */
    func loadDatasources(datasources: [Puestos]) {
        ad2CollectionViewDD = AD2CollectionViewDelegateAndDatasource(items: datasources,
                                                                     viewModel:viewModel)
        AD2CollectionView.dataSource = ad2CollectionViewDD
        AD2CollectionView.delegate = ad2CollectionViewDD
        //data = datasources

    }

  

}
