import UIKit

class PositionDetailViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: PositionDetailViewModelProtocol = PositionDetailViewModel()
    
    // Mark: - Properties
    
    var titles: [PositionDetailTitles] = []
    
    var tipo = ""
    var torneo = Tournament()
    // Mark: - Outlets
    
    @IBOutlet var nItem: UINavigationItem!
    @IBOutlet weak var positionTitleLabel: Label!
    @IBOutlet weak var positionLabel: Label!
    @IBOutlet weak var postTitleLabel: Label!
    @IBOutlet weak var winTitleLabel: Label!
    @IBOutlet weak var winLabel: Label!
    @IBOutlet weak var payTitle: Button!

    @IBOutlet var terminosLabel: Label!
    
    @IBOutlet var fechaActualizadaLabel: Label!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        let fechaActual = Utils().getFechaActual()
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: torneo.nombre, promocionId: String(torneo.pomocion_id))
        bind()
        viewModel.viewDidLoad()
    }
    

    @IBAction func tapPaymentsButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Payments", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PaymentsID") as! PaymentViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentPayments = presentPayments
        
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
    - Parameters:
       - titles : titulo de todos los elementos
    */
    func showTitles(titles: PositionDetailTitles) {
        nItem.title = torneo.nombre
        
        
        
        positionTitleLabel.setRafflesSubCenter(with: "Usted ocupa el puesto:")
        positionLabel.setPositionTitleGold(with: "\(torneo.posicion)°")
        postTitleLabel.setRafflesSubCenter(with: titles.postTitle)
        winTitleLabel.setAwardTitle2(with: titles.winTitle)
        postTitleLabel.setRafflesSubCenter(with: titles.postTitle)
        let pay = String(format: "%.0f", torneo.premio)
        winLabel.setAwardTitle(with: "$ \(pay)")

        
        payTitle.setRemindButton(with: titles.payTittle)
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
        
        fechaActualizadaLabel.setDateModify(with: "actualizado el \(txtFecha) a las \(txtHour) hrs")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url:"http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showTerms()
    }
    /**
     retorna a la vista de pagos
     */
    func presentPayments() {
        navigationController?.popToRootViewController(animated: true)
    }

}
