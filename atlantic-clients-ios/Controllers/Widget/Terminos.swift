import UIKit
import WebKit
import MaterialComponents.MaterialActivityIndicator
/**
 Webview que muestra los terminos del app
 */
class Terminos: UIViewController
{
        var viewParent : UIViewController!
        var encuesta = ""
        //variables para enviar
        var url = ""
     
        @IBOutlet var vContainer: UIView!
        
    @IBOutlet weak var wkWebView: WKWebView!
        
    /**
    Cerrar webview.
     */
    @IBAction func close(_ sender: Any) {
        if(!encuesta.isEmpty){
            self.hideTerms()
            if(Constants().getFirstInit()){
                (viewParent as! NewsViewController).showTutorial()
            }
        }else{
            self.hideTerms()
        }
        
    }
    
    
        convenience init() {
            self.init(parent: UIViewController(),url: "")
        }
    /**
    Inicializacion del webview terminos.
     - Parameters:
        - parent: ViewController donde se mostrara el webview.
        - url: Url de los terminos del app.
     */
        init(parent: UIViewController,url:String ){
            self.viewParent = parent
            self.url = url
            super.init(nibName: nil, bundle: nil)
    
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let request = URLRequest(url: URL(string: self.url)!)
            self.wkWebView.load(request)
        }

        /**
        Muestra la pagina web de los terminos en el WebView
        */
        func showTerms(){
            let storyboard = UIStoryboard(name: "Terminos", bundle: nil)
            let controller = (storyboard.instantiateViewController(withIdentifier: "TerminosID") as! Terminos)
           
            controller.modalPresentationStyle = .overFullScreen
            controller.url = self.url
            controller.encuesta = self.encuesta
            controller.viewParent = self.viewParent
            
            viewParent.navigationController?.present(controller, animated: false, completion: {
                controller.url = self.url

            })
    }
    
    /**
    Oculta el WebView
    */
    func hideTerms(){
        self.dismiss(animated: false, completion: nil)
    }
        
        

    }
