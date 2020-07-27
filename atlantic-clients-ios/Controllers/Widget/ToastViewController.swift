import UIKit
/**
 Vista que muestra un mensaje en pantalla.
 */
class ToastViewController: UIViewController {
    @IBOutlet weak var txtMessage: UILabel!
    public var message = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMessage.text = message
    }
    

   

}
