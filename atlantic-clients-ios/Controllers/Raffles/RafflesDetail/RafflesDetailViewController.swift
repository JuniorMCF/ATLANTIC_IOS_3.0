import UIKit

class RafflesDetailViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: RafflesDetailViewModelProtocol = RafflesDetailViewModel()
    
    // Mark: - Properties
    
    var titles: [RafflesDetailTitles] = []
    var sorteo = Sorteo()
    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var nextDateLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var reminderButton: Button!
    @IBOutlet weak var optionsTitleLabel: Label!
    @IBOutlet weak var optionsLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var necesaryPointsLabel: Label!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.viewDidLoad()
    }
    /**
    Notifica al viewmodel para crear un recordatorio en la agenda del telefono
    */
    @IBAction func createReminderButton(_ sender: Any) {
        viewModel.tapCreateReminder()
    }
    
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentCreateReminder = presentCreateReminder

    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - titles : titulo de todos los elementos
    */
    func showTitles(titles: RafflesDetailTitles) {
        //esta vista no se infla
        titleLabel.setRafflesTitle(with: sorteo.nombreSorteo)
        nextDateLabel.setRafflesSubTitle(with: "Fecha:")
        dateLabel.setRafflesSub(with: sorteo.fecha)
        reminderButton.setRemindButton(with: "Crear recordatorio")
        optionsTitleLabel.setRafflesSubTitle(with: titles.optionsTitle)
        optionsLabel.setRafflesTitle(with: titles.options)
        pointsLabel.setRafflesSubTitle(with: titles.points)
        necesaryPointsLabel.setRafflesSub(with: titles.necesaryPoints)
    }
    
    /**
     Muestra la vista para guardar los recordatorios
     */
    func presentCreateReminder() {
        let storyboard = UIStoryboard(name: "Reminder", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ReminderID")
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: false, completion: nil)
    }
    
    /**
    retorna al viewController anterior
    */
    func dismisViewController() {
        dismiss(animated: true, completion: nil)
    }
}
