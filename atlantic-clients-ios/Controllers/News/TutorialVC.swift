import UIKit

class TutorialVC: UIViewController {

    @IBOutlet weak var btnSiguiente: UIButton!
    @IBOutlet weak var btnSaltar: UIButton!
    var bubbleCase : BubbleShowCase!
    var position = 0
    @IBAction func nextOption(_ sender: Any) {
        bubbleCase.animateDisappearance()
    }
    
    @IBAction func exitTutorial(_ sender: Any) {
        bubbleCase.exitTutorial()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants().saveFistInit(isFirst: false)
        btnSiguiente.layer.borderWidth = 2.0
        btnSiguiente.layer.borderColor = UIColor.white.cgColor
        btnSiguiente.layer.cornerRadius = 15.0
        
        btnSaltar.layer.borderWidth = 2.0
        btnSaltar.layer.borderColor = UIColor.white.cgColor
        btnSaltar.layer.cornerRadius = 15.0

        if(position == 0){
            btnSiguiente.alpha = 0
            btnSiguiente.isUserInteractionEnabled = false
            btnSaltar.alpha = 0
            btnSaltar.isUserInteractionEnabled = false
        }else{
            btnSiguiente.alpha = 1
            btnSiguiente.isUserInteractionEnabled = true
            btnSaltar.alpha = 1
            btnSaltar.isUserInteractionEnabled = true
        }
    }
    /**
     Muestra los botones siguiente y saltar del tutorial
     */
    func showButtons(){
        if(position == 0){
            btnSiguiente.alpha = 0
            btnSiguiente.isUserInteractionEnabled = false
            btnSaltar.alpha = 0
            btnSaltar.isUserInteractionEnabled = false
        }else{
            btnSiguiente.alpha = 1
            btnSiguiente.isUserInteractionEnabled = true
            btnSaltar.alpha = 1
            btnSaltar.isUserInteractionEnabled = true
        }
    }
    


}
