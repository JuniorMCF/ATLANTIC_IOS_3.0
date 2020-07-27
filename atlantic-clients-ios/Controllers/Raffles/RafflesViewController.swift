import UIKit

class RafflesViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: RafflesViewModelProtocol = RafflesViewModel()
    
    //Mark: - DataSource & Delegate
    
    private var rafflesTableViewDD: RafflesTableViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var category: [Sorteo] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var rafflesTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Sorteos", message: "Obteniendo sorteos ...")
        bind()
        viewModel.viewDidLoad()
    }
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.loadDatasources = loadDatasources
        viewModel.presentRafflesCategory = presentRafflesCategory
    }
    /**
    Cargar la data traida desde el servidor y lo posiciona en un tableView.
    */
    func loadDatasources(datasource: [Sorteo]) {
        rafflesTableViewDD = RafflesTableViewDatasourceAndDelegate(items: datasource, viewModel: viewModel)
        rafflesTableView.dataSource = rafflesTableViewDD
        rafflesTableView.delegate = rafflesTableViewDD
        self.category = datasource
        self.rafflesTableView.reloadData()
    }
    /**
    Redirige al sorteo seleccionado
    - Parameters:
       - type: sorteo seleccionado
    */
    func presentRafflesCategory(type: Sorteo) {
        let storyboard = UIStoryboard(name: "RafflesDream", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RafflesDreamID") as! RafflesDreamViewController
        viewController.sorteo = type
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
