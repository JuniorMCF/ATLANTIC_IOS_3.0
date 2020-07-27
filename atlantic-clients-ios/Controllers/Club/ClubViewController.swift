import UIKit

class ClubViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: ClubViewModelProtocol = ClubViewModel()
    
    //Mark: - DataSource
    
    private var clubTableViewDD: ClubTableViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    @IBOutlet weak var clubTableView: UITableView!
    
    var category: [ClubCategory] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.clubController = self
            }
            
        }
        appDelegate.clubController = self
        let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        let tabHeight = self.parent?.tabBarController?.tabBar.frame.size.height
        clubTableView.rowHeight = ((self.parent?.view.frame.height)! - tabHeight! - height ) / 3
        bind()
        viewModel.viewDidLoad()
    }
    
    
    func reloadData(){
        clubTableViewDD.items.removeAll()
        clubTableView.reloadData()
        bind()
        viewModel.viewDidLoad()
    }
    
    /**
     Inicializar el viewmodel
     */
    func bind() {
        viewModel.loadDatasources = loadDatasources
        viewModel.presentClubCategory = presentClubCategory
    }
    
    /**
     Cargar la data traida desde el servidor y lo posiciona en un tableView.
     */
    func loadDatasources(datasource: ClubDatasources) {
        clubTableViewDD = ClubTableViewDatasourceAndDelegate(items: datasource.items, viewModel: viewModel)
        clubTableView.dataSource = clubTableViewDD
        clubTableView.delegate = clubTableViewDD
        self.category = datasource.items
        self.clubTableView.reloadData()
    }
    
    /**
     Redirige a los diferentes ViewControllers deacuerdo a donde se haya dado click (Sorteo/Beneficios/Torneos)
     - Parameters:
        - type: categoria seleccionada
     */
    func presentClubCategory(type: ClubCategoryTypes) {
        switch type {
            case .sorteo:
                Constants().saveBody(isActive: false, key: "body1")
                let indexPath = IndexPath(item: 0, section: 0)
                let cell = clubTableView.cellForRow(at: indexPath) as! ClubTableViewCell
                cell.icNotify.alpha = 0
                self.checkNotify()
                let storyboard = UIStoryboard(name: "Raffles", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "RafflesID")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            case .beneficios:
                Constants().saveBody(isActive: false, key: "body2")
                let indexPath = IndexPath(item: 1, section: 0)
                let cell = clubTableView.cellForRow(at: indexPath) as! ClubTableViewCell
                cell.icNotify.alpha = 0
                self.checkNotify()
                let storyboard = UIStoryboard(name: "Benefits", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "BenefitsID")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
                return
            case .torneos:
                Constants().saveBody(isActive: false, key: "body3")
                let indexPath = IndexPath(item: 2, section: 0)
                let cell = clubTableView.cellForRow(at: indexPath) as! ClubTableViewCell
                cell.icNotify.alpha = 0
                self.checkNotify()
                let storyboard = UIStoryboard(name: "Tourneys", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TourneysID")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
            return
        }
    }
    
    /**
    Verifica si hay un nuevo Sorteo, Beneficio, Torneo y muestra un icono en caso afirmativo
     */
    func checkNotify(){
        let body1 = Constants().getBody(key: "body1")
        let body2 = Constants().getBody(key: "body2")
        let body3 = Constants().getBody(key: "body3")
        
        if(!body1 && !body2 && !body3){
            self.tabBarItem.badgeValue = nil
            self.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = nil
           
        }
    }

}
