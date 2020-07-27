import UIKit
import CarbonKit
class AgendaViewController: UIViewController {
        // Mark: - ViewModel
        
        private var viewModel: AgendaViewModelProtocol = AgendaViewModel()
        
        //Mark: - DataSource
        
        private var AgendaCollectionViewDD: AgendaCollectionViewDatasourceAndDelegate!
        
        // Mark: - Properties
        
        var agenda = Event()
        var items = [Event]()
        var tipo = ""
        
        var estimateWidth = 300.0
        var cellMarginSize = 16.0
        var carbonkit : ProfileAgendaViewController!
        var viewPager: UIView!
        var indexAgend:Int!
        var index : UInt!
        // MARK: - IBoulets
        
        @IBOutlet weak var collectionView: UICollectionView!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var progress :CustomProgress!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.register(UINib(nibName: "AgendaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AgendaCellID")
            // SetupGrid view
            self.setupGridView()
            progress = CustomProgress(parent: self, title: "Eventos", message: "Obteniendo eventos ...")
            progress.isHome = true
            progress.showProgress()
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
            flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
            flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        }

        /**
        Inicializa el viewmodel.
        */
        func bind() {
            viewModel.loadDatasources = loadDatasources(datasource:)
            viewModel.presentEventDetail = presentEventDetail(item:)
            viewModel.actualizarLista = actualizarLista(eventoRegistroId: clienteId: index:)
            viewModel.presentToast = show(message:)
            viewModel.presentReloadData = reloadCarbonKit(eventos:)
            viewModel.removeItemEvent = removeItemEvent(index:)
        }
        /**
        Muestra un mensaje en la pantalla
        */
        func show(message:String){
            showToast(message: message)
        }
        /**
        Remueve un evento de una categoria
        - Parameters:
            - index: Posicion de la categoria
        */
        func removeItemEvent(index:Int){
            items.remove(at: index)
            self.indexAgend = index
            reloadCarbonKit(eventos: items)
        }
        /**
        Notifica al viewmodel para modificar la lista de categoria de eventos
        - Parameters:
            - eventoRegistroId : id del evento
            - clienteId: id del cliente
            - index : posicion de la categoria
        */
        func actualizarLista(eventoRegistroId:String,clienteId:String,index:Int){
            //
            viewModel.deleteData(eventoRegistroId: eventoRegistroId, clienteId: clienteId,index: index)
            
        }
        /**
        Actualiza la data del viewcontroller
        */
        func presentReloadData(list:[Event]){
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  list,viewModel: viewModel, viewParent: self)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = self
            self.collectionView.reloadData()
        }
        
        /**
        Cargar la data traida desde el servidor y lo posiciona en un collectionview
        - Parameters:
            - datasource: objeto BreakfastDatasources
        */
        func loadDatasources(datasource:BreakfastDatasources) {
           
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  items,viewModel: viewModel,viewParent: self)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = AgendaCollectionViewDD
            self.collectionView.reloadData()
            progress.hideProgress()
            
        }
    
        /**
        Dirige a la pantalla de detalle de eventos.
        - Parameters:
            - item: datos del evento seleccionoado
        */
        func presentEventDetail(item:Event){
            let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailID") as! EventsDetailViewController
            viewController.event = item
            viewController.tipo = "0"
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    func reloadData(){
        if(AgendaCollectionViewDD != nil){
            AgendaCollectionViewDD.items.removeAll()
            AgendaCollectionViewDD.items = items
            collectionView.reloadData()
        }
        
    }
    /**
     Actualiza la data de las categorias
     - Parameters:
        - eventos: lista de eventos
     */
    func reloadCarbonKit(eventos:[Event]){
       
            AgendaCollectionViewDD = AgendaCollectionViewDatasourceAndDelegate(items:  eventos,viewModel: viewModel, viewParent: self)
            collectionView.dataSource = AgendaCollectionViewDD
            collectionView.delegate = self
            self.collectionView.reloadData()
        
            print(eventos)
            var tipoList = [String]()
            for data in eventos{
                tipoList.append(data.nombreTipo)
            }
            if(tipoList.count == 0){
                carbonkit.removeTabCarbonKit(index: Int(index))
            
            }else{
                AgendaCollectionViewDD.items.removeAll()
                AgendaCollectionViewDD.items = eventos
                collectionView.reloadData()
                carbonkit.reloadTabCarbonKit(index: indexAgend)
                
            }
    }

    }

    extension AgendaViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = self.calculateWith()
            return CGSize(width: width, height: width/3)
        }
        
        func calculateWith() -> CGFloat {
            let estimatedWidth = CGFloat(estimateWidth)
            let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
            
            let margin = CGFloat(cellMarginSize * 2)
            let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
            return width
        }
    }
    extension AgendaViewController: UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            viewModel.didEventSelected(event: items[indexPath.row])
        }
    }
