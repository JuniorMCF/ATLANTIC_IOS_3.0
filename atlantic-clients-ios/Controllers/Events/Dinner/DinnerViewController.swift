
import UIKit

class DinnerViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: DinnerViewModelProtocol = DinnerViewModel()
    
    //Mark: - DataSource
    
    private var dinnerCollectionViewDD: DinnerCollectionViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var dinners: [Dinner] = []
    
    // MARK: - IBoulets
    
    @IBOutlet weak var dinnerCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        
        bind()
        viewModel.viewDidLoad()
    }
    
    func prepare() {
        // Flow Dinners
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: view.frame.width - 24, height: 140.0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 12
        dinnerCollectionView.collectionViewLayout = flow
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.loadDatasources = loadDatasources
        viewModel.presentDinnerDetail = presentDinnerDetail
    }

    /**
    Carga la lista de eventos
    - Parameters:
       - datasources: lista de eventos
    */
    func loadDatasources(datasource: DinnerDatasources) {
        dinnerCollectionViewDD = DinnerCollectionViewDatasourceAndDelegate(items: datasource.items, viewModel: viewModel)
        dinnerCollectionView.dataSource = dinnerCollectionViewDD
        dinnerCollectionView.delegate = dinnerCollectionViewDD
        self.dinners = datasource.items
        self.dinnerCollectionView.reloadData()
    }
    
    func presentDinnerDetail() {
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
