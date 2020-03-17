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

       var progressController : Terminos!

        //variables para enviar
        var url = ""
     
        @IBOutlet var vContainer: UIView!
    
        @IBOutlet var webView: WKWebView!
    
       
    @IBAction func hideTerms(_ sender: Any) {
        print("aca")
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

            let request = URLRequest(url: URL(string: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones.pdf")!)
            webView.load(request)
        }

        
        func showProgress(){
            let storyboard = UIStoryboard(name: "Terminos", bundle: nil)
            progressController = (storyboard.instantiateViewController(withIdentifier: "TerminosID") as! Terminos)
           
            progressController.modalPresentationStyle = .overFullScreen
            
            viewParent.tabBarController?.view.addSubview(progressController.view)
            
           // viewParent.view.addSubview(progressController.view)
           /* viewParent.navigationController?.present(progressController, animated: false, completion: {
                self.progressController.titleProgress.text = self.titleP
                self.progressController.messageProgress.text = self.message
            })*/
        }
        
        func hideProgress(){
            
            progressController.view.removeFromSuperview()
          
           // progressController.dismiss(animated: false, completion: nil)
        }
        
        

    }
