import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class RafflesDreamViewController: UIViewController {
    private var rafflesDreamCollecionViewDD : RafflesDreamViewCollectionViewDatasourceAndDelegate!
    // Mark: - ViewModel
    
    private var viewModel: RafflesDreamViewModelProtocol = RafflesDreamViewModel()
    
    // Mark: - Properties
    
    var titles: [RafflesDreamTitles] = []
    var sorteo = Sorteo()
    // Mark: - Outlets
    var fotos = [Foto]()
    var posicion = 0
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var nextDateLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var reminderButton: Button!
    @IBOutlet weak var optionsTitleLabel: Label!
    @IBOutlet weak var optionsLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var necesaryPointsLabel: Label!

    
    
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    
    
    @IBOutlet var fechaActualizadaLabel: Label!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        let fechaIngreso = Utils().getFechaActual()
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaIngreso, nombrePromocion: sorteo.nombreSorteo, promocionId: String(sorteo.promocionId)) // guarda data para analitycs
        viewModel.viewDidLoad()
    }
    
    /**
    Crea un recordatorio en la agenda del telefono
     */
    
    @IBAction func createReminderButton(_ sender: Any) {
       
        let fecha = (sorteo.fecha as NSString)
        Utils().saveEvent(title: sorteo.nombreSorteo, fecha: fecha,parent: self)
    }
    /**
     Muestra la siguiente foto del Slider
     */
    
    @IBAction func rightCV(_ sender: Any) {
        if(posicion < fotos.count-1){
            let lastSection = collectionView.numberOfSections - 1

            let indexPath = IndexPath(row: posicion+1, section: lastSection)

            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            posicion += 1
        }
        
    }
    /**
    Muestra la foto anterior del Slider
    */
    @IBAction func leftCV(_ sender: Any) {
        if(posicion > 0){
            let lastSection = collectionView.numberOfSections - 1

            let indexPath = IndexPath(row: posicion-1, section: lastSection)

            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            posicion -= 1
        }
    }
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentCreateReminder = presentCreateReminder
        loadDatasources(datasource: sorteo.fotos)
        
    }
    /**
    Cargar la data traida desde el servidor y lo posiciona en un tableView.
     - Parameters:
        - datasource: Lista de fotos
    */
    func loadDatasources(datasource: [Foto]) {
        if(datasource.count == 1){
            pageControl.isUserInteractionEnabled = false
            pageControl.alpha = 0.0
            leftButton.isUserInteractionEnabled = false
            rightButton.isUserInteractionEnabled = false
            leftButton.alpha = 0.0
            rightButton.alpha = 0.0
        }
        
        
        rafflesDreamCollecionViewDD = RafflesDreamViewCollectionViewDatasourceAndDelegate(items:datasource, viewModel: viewModel, pageControl: self.pageControl,collectionView: collectionView)
        collectionView.dataSource =  rafflesDreamCollecionViewDD
        collectionView.delegate = rafflesDreamCollecionViewDD
        
        self.fotos = datasource
        self.collectionView.reloadData()
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - titles : titulo de todos los elementos
    */
    func showTitles(titles: RafflesDreamTitles) {
        
        if(sorteo.fotos[0].foto == "" || sorteo.fotos[0].foto.isEmpty){
            let image = UIImage(named: "casino")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = self.headerView.bounds
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.headerView.addSubview(imageView)
        }else{
           
            
        }
        
        
        
        titleLabel.setRafflesTitleGold(with: sorteo.nombreSorteo)
        nextDateLabel.setRafflesSubTitle(with: "Fecha:")
        dateLabel.setRafflesSub(with: sorteo.fechaTexto)
        reminderButton.setRemindButton(with: "Crear recordatorio")
        optionsTitleLabel.setRafflesSubTitle(with: "Hasta el momento tiene:")
        optionsLabel.setRafflesTitle(with: String(sorteo.opciones)+" opciones" )
        pointsLabel.setDateModify(with: "¡Le faltan \(sorteo.puntosFalta) puntos para una opción adicional!")
        necesaryPointsLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        necesaryPointsLabel.isUserInteractionEnabled = true
        necesaryPointsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
        let fecha = (sorteo.fechaActualizacion as NSString).doubleValue
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
        
        
        
        fechaActualizadaLabel.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showTerms()
    }
    func presentCreateReminder() {
        let storyboard = UIStoryboard(name: "Reminder", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ReminderID")
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: false, completion: nil)
    }
    
    /**
     retorna al viewController anterior
     */
    func dismisViewController() {
        dismiss(animated: true, completion: nil)
    }
}
