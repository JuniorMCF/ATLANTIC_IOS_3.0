//
//  Terminos.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/16/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit
import WebKit
import MaterialComponents.MaterialActivityIndicator

class Terminos: UIViewController
{

        var viewParent : UIViewController!
        var encuesta = ""
        //variables para enviar
        var url = ""
     
        @IBOutlet var vContainer: UIView!
        
    @IBOutlet weak var wkWebView: WKWebView!
        
    @IBAction func close(_ sender: Any) {
        if(!encuesta.isEmpty){
            self.hideProgress()
            if(Constants().getFirstInit()){
                (viewParent as! NewsViewController).showTutorial()
            }
        }else{
            self.hideProgress()
        }
        
    }
    
    
        convenience init() {
            self.init(parent: UIViewController(),url: "")
        }

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

        
        func showProgress(){
            let storyboard = UIStoryboard(name: "Terminos", bundle: nil)
            let controller = (storyboard.instantiateViewController(withIdentifier: "TerminosID") as! Terminos)
           
            controller.modalPresentationStyle = .overFullScreen
            controller.url = self.url
            controller.encuesta = self.encuesta
            controller.viewParent = self.viewParent
            
           // present(controller, animated: false, completion: nil)
            //viewParent.present(controller, animated: false, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            viewParent.navigationController?.present(controller, animated: false, completion: {
                controller.url = self.url
               // self.progressController.messageProgress.text = self.message
            })
    }
               
        func hideProgress(){
            //self.view.removeFromSuperview()
            self.dismiss(animated: false, completion: nil)
        }
        
        

    }
