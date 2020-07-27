import UIKit
import Alamofire
import AlamofireImage
class BreakfastViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: BreakfastViewModelProtocol = BreakfastViewModel()
    
    //Mark: - DataSource
    
    private var BreakfastCollectionViewDD: BreakfastCollectionViewDatasourceAndDelegate!
    
    // Mark: - Properties
    
    var breakfast: [Breakfast] = []
    var items = [Event]()
    var tipo = ""
    var fotoList : [UIImage]!
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    // MARK: - IBoulets
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        // SetupGrid view
        self.setupGridView()
        
        bind()
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 10
        flow.minimumLineSpacing = 10
        let width = (collectionView.frame.width - 10) / 2
        flow.itemSize = CGSize(width: width, height: width * 1.35)
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.loadDatasources = loadDatasources(datasource:)
        viewModel.presentEventDetail = presentEventDetail(item:)
    }
    
    /**
    Carga la lista de eventos
    - Parameters:
       - datasources: lista de eventos
    */
    func loadDatasources(datasource:BreakfastDatasources) {
        fotoList = []
        for _ in 0 ..< items.count{
            fotoList.append(Image())
        }
        BreakfastCollectionViewDD = BreakfastCollectionViewDatasourceAndDelegate(items:  items)
        BreakfastCollectionViewDD.fotoList = fotoList
        collectionView.dataSource = BreakfastCollectionViewDD
        collectionView.delegate = self
        self.breakfast = datasource.items
        self.collectionView.reloadData()
        
        
        var count = 0
        for data in items{
            
            for foto in data.fotos{
                
                if foto.esPrincipal{
                    foto.foto = foto.foto.replacingOccurrences(of: "\"", with: "")
                    foto.pos = count
                    
                    count += 1
                    print(count)
                    print(self.items.count)
                    if (foto.foto == ""){
                        fotoList.append(UIImage(named: "img_desayuno")!)
                    }else{
                        let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/evento/"
                        AF.request(dominio + foto.foto).responseImage { response in
                                   
                                       switch response.result {
                                             case .success(let value):
                                                
                                                self.fotoList[foto.pos] = value
                                                if(count == self.items.count){
                                                    self.BreakfastCollectionViewDD.fotoList = self.fotoList
                                                    self.collectionView.reloadData()
                                                }
                                             case .failure(let error):
                                                 print(error)
                                                 
                                             }
                        }
                    }
                    break;
                }
            }
        }
    }
    /**
     Dirige hacia los detalles del evento
     - Parameters:
        - item: evento seleccionado
     */
    func presentEventDetail(item:Event){
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailID") as! EventsDetailViewController
        viewController.event = item
       // viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension BreakfastViewController: UICollectionViewDelegateFlowLayout {
    
    
}


extension BreakfastViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didBreakfastSelected(items[indexPath.row])
    }
}
