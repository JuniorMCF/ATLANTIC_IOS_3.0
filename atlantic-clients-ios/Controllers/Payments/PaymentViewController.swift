import UIKit

class PaymentViewController: UIViewController {

    // Mark: - ViewModel
    
    private var viewModel: PaymentsViewModelProtocol = PaymentsViewModel()
    
    //Mark: - DataSource
    
    private var paymentsTableViewDD: PaymentsTableViewDelegateAndDatasource!
    
    // Mark: - Properties
    
    @IBOutlet weak var paymentSearchBar: UISearchBar!
    @IBOutlet weak var paymentsTableView: UITableView!
    
    var payments: [Cobros] = []
    var currentPaymentsArray: [Cobros] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
        
            paymentSearchBar.searchBarStyle = .default
            paymentSearchBar.searchTextField.backgroundColor = UIColor.white
            paymentSearchBar.searchTextField.layer.borderColor = UIColor.black.cgColor
            
            let glassIconView = paymentSearchBar.searchTextField.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .gray
            
            paymentSearchBar.searchTextField.textColor = .black
            
        }
        
    
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Cobros", message: "Obteniendo cobros ...")
        
        bind()
        var promotionListid : [String] = []
        for data in payments{
            promotionListid.append(data.id)
        }
    
        viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fecha: Utils().getFechaActual(), promocionIdList:promotionListid)
        
        viewModel.viewDidLoad()
        addTapGesture()
        paymentSearchBar.delegate = self
        paymentSearchBar.placeholder = "Buscar"
    }
    
    /**
    Inicializa el viewmodel.
    */
       
    func bind() {
        viewModel.loadDatasources = loadDatasources(datasource:)
        viewModel.reloadDatasource = loadDatasources(datasource:)
    }
    /**
     Cargar la data traida desde el servidor y lo posiciona en un tableView.
     */
    
    func loadDatasources(datasource:[Cobros]) {
        paymentsTableViewDD = PaymentsTableViewDelegateAndDatasource(items: datasource)
        paymentsTableView.dataSource = paymentsTableViewDD
        self.payments = datasource
        self.paymentsTableView.reloadData()
    }
    /**
     Recarga los elementos del tableview
     */
    
    func reloadDatasource(datasource: [Cobros]) {
        self.payments = datasource
        self.paymentsTableView.reloadData()
    }
    /**
     Accion click sobre una vista
     */
    private func addTapGesture() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension PaymentViewController: UISearchBarDelegate {
    /**
     Notifica al viewmodel para buscar un cobro
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchText)
    }
    
}
