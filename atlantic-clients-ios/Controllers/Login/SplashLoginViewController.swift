
import UIKit

class SplashLoginViewController: UIViewController {
    var viewParent : UIViewController!
    var splashController : SplashLoginViewController!
    
    convenience init(){
        self.init(parent: UIViewController())
    }
    
    init(parent: UIViewController){
        self.viewParent = parent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    /**
     Muestra el splash screen
     */
    func showSplash(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
         splashController = (storyboard.instantiateViewController(withIdentifier: "splashLogin") as! SplashLoginViewController)
         splashController.modalPresentationStyle = .overFullScreen
        if(splashController != nil){
            viewParent.view.addSubview(splashController.view)
        }
         
         
    }
    /**
     Oculta el splash screen
     */
    func hideSplash(){
        if(splashController != nil){
             splashController.view.removeFromSuperview()
        }
    }

}
