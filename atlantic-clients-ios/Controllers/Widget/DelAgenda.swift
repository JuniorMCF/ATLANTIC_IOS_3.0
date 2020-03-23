//
//  DelAgenda.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class DelAgenda: UIViewController {
    
    var viewParent : UIViewController!
    var titleP : String!
    var message : String!
    var eventDetailViewModel :EventDetailViewModelProtocol =   EventDetailViewModel()
    var progressController : DelAgenda!
    var isHome = false
    //variables para enviar
    var id = ""
    var horarioId = ""
    var acompanantes = 0
    @IBOutlet var titleProgress: UITextView!
    @IBOutlet var messageProgress: UITextView!
    @IBOutlet var vContainer: UIView!
    @IBOutlet var ok: UIButton!
    @IBOutlet var cancel: UIButton!
    var tipo = ""
    
    convenience init() {
        self.init(parent: UIViewController(),title: "", message: "")
    }

    init(parent: UIViewController,title: String, message: String ){
        self.viewParent = parent
        self.titleP = title
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [UIColor.init(red: 115/255, green: 88/255, blue: 88/255, alpha: 1)]
        activityIndicator.radius = 30.0
        activityIndicator.strokeWidth = 6
        vContainer.layer.cornerRadius = 10.0
        activityIndicator.startAnimating()
        ok.setTitle("ACEPTAR", for: .normal)
        ok.setTitleColor(.white, for: .normal)
        ok.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        cancel.setTitle("CANCELAR", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
    }
    
    @IBAction func tapOk(_ sender: Any) {
        self.hideProgress()
       
    }
    
    @IBAction func tapCancel(_ sender: Any) {
            self.hideProgress()
    }
    func showProgress(){
        let storyboard = UIStoryboard(name: "DelAgenda", bundle: nil)
        progressController = (storyboard.instantiateViewController(withIdentifier: "delAgendaID") as! DelAgenda)
       
        progressController.modalPresentationStyle = .overFullScreen
        
        viewParent.tabBarController?.view.addSubview(progressController.view)
       
        
        progressController.viewParent = self.viewParent
       // viewParent.view.addSubview(progressController.view)
        self.progressController.titleProgress.text = self.titleP
        self.progressController.messageProgress.text = self.message
       /* viewParent.navigationController?.present(progressController, animated: false, completion: {
            self.progressController.titleProgress.text = self.titleP
            self.progressController.messageProgress.text = self.message
        })*/
    }
    
    func hideProgress(){
        
        self.view.removeFromSuperview()
      
        //progressController.dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}