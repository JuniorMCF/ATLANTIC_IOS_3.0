//
//  CustomEvent.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/1/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class CustomEvent: UIViewController {
    
    var viewParent : UIViewController!
    var titleP : String!
    var message : String!
    var eventDetailViewModel : EventDetailViewModel!
    var progressController : CustomEvent!
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
        self.init(parent: UIViewController(),title: "", message: "", viewModel: EventDetailViewModel(),id:"", horarioId:"", acompanantes: 0 )
    }

    init(parent: UIViewController,title: String, message: String,viewModel: EventDetailViewModel,id:String, horarioId: String, acompanantes: Int ){
        self.viewParent = parent
        self.titleP = title
        self.message = message
        self.eventDetailViewModel = viewModel
        self.id = id
        self.horarioId = horarioId
        self.acompanantes = acompanantes
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
        ok.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        ok.layer.cornerRadius = 15.0
        cancel.setTitle("CANCELAR", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        cancel.layer.cornerRadius = 15.0
    }
    
    @IBAction func tapOk(_ sender: Any) {
        
        self.eventDetailViewModel.saveData(id: id, horarioId: horarioId, acompanantes: acompanantes)
        
    }
    
    @IBAction func tapCancel(_ sender: Any) {
            self.hideProgress()
    }
    func showProgress(){
        let storyboard = UIStoryboard(name: "CustomEvent", bundle: nil)
        progressController = (storyboard.instantiateViewController(withIdentifier: "customEvent") as! CustomEvent)
       
        progressController.modalPresentationStyle = .overFullScreen
        
        viewParent.tabBarController?.view.addSubview(progressController.view)
       
        
        
       // viewParent.view.addSubview(progressController.view)
        self.progressController.titleProgress.text = self.titleP
        self.progressController.messageProgress.text = self.message
       /* viewParent.navigationController?.present(progressController, animated: false, completion: {
            self.progressController.titleProgress.text = self.titleP
            self.progressController.messageProgress.text = self.message
        })*/
    }
    
    func hideProgress(){
        
        progressController.view.removeFromSuperview()
      
        //progressController.dismiss(animated: false, completion: nil)
    }
    
    

}
