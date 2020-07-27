import UIKit
import Alamofire
import SwiftyJSON
class TourneyViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: TourneyViewModelProtocol = TourneyViewModel()
    
    //Mark: - DataSource & Delegate
    
    private var tourneyTableViewDD: TourneyTableViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var category: [TournamentDetails] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var tourneyTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Torneos", message: "Obteniendo torneos ...")
        bind()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Torneos", message: "Obteniendo torneos ...")
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.loadDatasources = loadDatasources
        viewModel.presentTourneyCategory = presentTourneyCategory
        viewModel.presentGranPrixDetail = presentGranPrixDetail
    }
    
    /**
    Cargar la data traida desde el servidor y lo posiciona en un collectionview
     - Parameters:
        - datasource: objeto TournamentDetails
    */
    func loadDatasources(datasource: [TournamentDetails]) {
        tourneyTableViewDD = TourneyTableViewDatasourceAndDelegate(items: datasource, viewModel: viewModel)
        tourneyTableView.dataSource = tourneyTableViewDD
        tourneyTableView.delegate = tourneyTableViewDD
        self.category = datasource
        self.tourneyTableView.reloadData()
    }
    
    /**
     Dirigirse a la pantalla de categorias de torneos, detalle de torneos
     - Parameters:
        - tipo: tipo de torneo
        - isList : es una lista de torneos? (true / false)
     */
    func presentTourneyCategory(tipo:String,isList:Bool) {
        
        switch isList {
        case true:
            let storyboard = UIStoryboard(name: "TrophyCategory", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "TrophyCategoryID") as! TrophyCategoryViewController
            viewController.tipo = tipo

            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: false)
            return

        case false:
            /*
             si no es lista hay 2 posibilidades que haya concluido y o no
             */
            
            viewModel.didSelectGranPrix(tipo: tipo, id: String(self.appDelegate.usuario.clienteId))
            
        }
    }
    /**
    Dirigirse a la pantalla de categorias de torneos, detalle de torneos
    */
    func presentGranPrixDetail(torneos:[Tournament]){
        
        let tournament = torneos[0]
        if(tournament.concluido){
            if(tournament.posicion > 40){
                let storyboard = UIStoryboard(name: "PositionDetail40", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetail40ID") as! PositionDetail40ViewController
                viewController.torneo = tournament
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
            }else{
                let storyboard = UIStoryboard(name: "PositionDetail", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PositionDetailID") as! PositionDetailViewController
                
                viewController.torneo = tournament
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            
            return
        }else{
           //grandprix detail
            let storyboard = UIStoryboard(name: "TrophyLose", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "TrophyLoseID") as! TrophyLoseViewController
            viewController.torneo = tournament
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
            return
        }
        
    }
    
}
