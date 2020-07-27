import UIKit

class BenefitsCategoryViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: BenefitsCategoryViewModelProtocol = BenefitsCategoryViewModel()
    
    //Mark: - DataSource
    
    private var benefitsCategoryCollectionViewDD: BenefitsCategoryCollectionViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var benefitsCategory: [BenefitsCategory] = []
    
    // MARK: - IBoulets
    var benefit = Benefits()
    
    @IBOutlet weak var spectacularButton: Button!
    @IBOutlet weak var benefitsCategoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        
        bind()
        viewModel.viewDidLoad()
    }
    
    func prepare() {
        // Flow Promotions
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: view.frame.width - 24, height: 120.0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 12
        benefitsCategoryCollectionView.collectionViewLayout = flow
    }

    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.loadDatasources = loadDatasources(datasource: )
        viewModel.presentBenefitsCategory = presentRecognitionDetail
        
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
     - Parameters:
        - data : titulos de todos los elementos
    */
    func showTitles(titles: BenefitsCategoryTitles) {
        spectacularButton.setRemindButton(with: titles.spectacularTitle)
        
    }
    
    /**
    Carga la lista de beneficios
    - Parameters:
       - datasources: lista de beneficios
    */
    func loadDatasources(datasource: BenefitsCategoryDatasource) {
        benefitsCategoryCollectionViewDD = BenefitsCategoryCollectionViewDatasourceAndDelegate(items: datasource.items, viewModel: viewModel)
        benefitsCategoryCollectionView.dataSource = benefitsCategoryCollectionViewDD
        benefitsCategoryCollectionView.delegate = benefitsCategoryCollectionViewDD
        self.benefitsCategory = datasource.items
        self.benefitsCategoryCollectionView.reloadData()
    }
    
    func presentRecognitionDetail(type: BenefitsCategoryTypes) {
        switch type {
        case .agenda2019:
            let storyboard = UIStoryboard(name: "BenefitDetail", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "BenefitDetailID")
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
            return
        case .copasHelado:
            print("No presenta diseño")
            return
        case .coronaNavideña:
            print("No presenta diseño")
            return
            
        case .maletinCooler:
            print("No presenta diseño")
            return
        }
    }

}
