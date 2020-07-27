import UIKit
import CarbonKit

class ProfileAgendaViewController: UIViewController , CarbonTabSwipeNavigationDelegate {
    
    var viewModel : ProfileAgendaViewModelProtocol = ProfileAgendaViewModel()
    var items : EventDetailPreview!
    var keys = [String]()
    var position : UInt = 0
    @IBOutlet weak var searchAgend: UISearchBar!
    @IBOutlet var viewPager: UIView!
    var carbonTabSwipeNavigation : CarbonTabSwipeNavigation!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Agenda", message: "Obteniendo eventos")
        
        bind()
        viewModel.viewDidLoad()
        items = EventDetailPreview()
        
        if #available(iOS 13.0, *) {
        
            searchAgend.searchBarStyle = .default
            searchAgend.searchTextField.backgroundColor = UIColor.white
            searchAgend.searchTextField.layer.borderColor = UIColor.black.cgColor
            
            searchAgend.searchTextField.textColor = .black
            
            
            
            let glassIconView = searchAgend.searchTextField.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .gray
        }
        searchAgend.delegate = self
        searchAgend.placeholder = "Buscar"
        
    }
    /**
    Inicializa el viewmodel.
    */
    func bind(){
        viewModel.showTitles = showTitles(titles:)
        viewModel.reloadTabs = reloadTabs(titles:)
    }
    /**
    Proporciona estilo a los elementos de la vista.
    - Parameters:
       - titles : titulo de todos los elementos
    */
    func showTitles(titles:EventDetailPreview){

        items = titles
        if(titles.tipoList.count == 0){
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)

            
        }else{
            
            for data in titles.tipoList{
               buscarEnLista(element: data)
            }
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : keys, delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth/keys.count
            print(tam)
            for i in 0...keys.count-1 {
                carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: i)
            }
            
        }

    }
    /**
     Recarga las categorias de eventos y muestra los elementos de cada uno de ellos
     - Parameters:
        - titles: elemento que contiene los detalles de los eventos
     */
    func reloadTabs(titles: EventDetailPreview){
        items = titles
        if(carbonTabSwipeNavigation != nil){
            position = carbonTabSwipeNavigation.currentTabIndex
            carbonTabSwipeNavigation.setCurrentTabIndex(position, withAnimation: true)
        }
        let screen =  carbonTabSwipeNavigation.viewControllers[position] as! AgendaViewController
        if(items.list.count > 0){
            screen.items = items.list[Int(position)]
        }else{
            screen.items = [Event]()
        }
        screen.reloadData()
    }
    
    /**
     Busca un elemento de la agenda
     - Parameters:
        - element: palabra clave para buscar
     */
    func buscarEnLista(element:String){
        print(keys)
        print(element)
        if(keys.count == 0){
            keys.append(element)
            return
        }
        if( keys.firstIndex(of: element) == nil){
            keys.append(element)
            return
        }
      
    }
    
    /**
     Remueve una categoria en caso no existan eventos en ella
     - Parameters:
        - index: Posicion de la categoria
     */
    func removeTabCarbonKit(index:Int){
        
        items.list.remove(at: Int(carbonTabSwipeNavigation.currentTabIndex))
        keys.remove(at: Int(carbonTabSwipeNavigation.currentTabIndex))
        carbonTabSwipeNavigation.view.removeFromSuperview()
        if(keys.count == 0){
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : [""], delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: 0)

            
        }else{
            carbonTabSwipeNavigation =  CarbonTabSwipeNavigation ( items : keys, delegate : self)
            carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewPager)
            carbonTabSwipeNavigation.setIndicatorColor(.black)
            carbonTabSwipeNavigation.setNormalColor(.black, font: UIFont(name: "Avenir-Medium", size: 13.0)!)
            carbonTabSwipeNavigation.setSelectedColor(.black)
            carbonTabSwipeNavigation.toolbar.isTranslucent = true
            carbonTabSwipeNavigation.toolbar.shadow = true
            
            carbonTabSwipeNavigation.toolbar.barTintColor = UIColor.white
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = Int(screenSize.width)
            let tam = screenWidth/keys.count
            print(tam)
            for i in 0...keys.count-1 {
                carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tam), forSegmentAt: i)
            }
        }
       //carbonTabSwipeNavigation.setCurrentTabIndex(0, withAnimation: false)
       // self.viewDidLoad()
    }
    /**
     Recarga una categoria
     - Parameters:
        - index: posicion de la categoria
     */
    func reloadTabCarbonKit(index:Int){
        items.list[Int(carbonTabSwipeNavigation.currentTabIndex)].remove(at: index)
    }
    
   
    /**
     Navegacion entre categorias
     */
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {
        let screen = carbonTabSwipeNavigation.viewControllers[index] as! AgendaViewController
        if(items.list.count > 0){
            screen.items = items.list[Int(index)]
            screen.reloadData()
        }else{
            screen.items = [Event]()
            screen.reloadData()
        }
        
    }
    
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "AgendaID") as! AgendaViewController
        if(keys.count>0){
            screen.items = items.list[Int(index)]
            screen.carbonkit = self
            screen.viewPager = viewPager
            screen.index = index
        }
        return screen
    }

}

extension ProfileAgendaViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchText)
        
    }
    
}
