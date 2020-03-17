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
        
    var request : URLRequest!
       
    @IBAction func hideTerms(_ sender: Any) {
        self.hideProgress()
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
            
           
        }

        
        func showProgress(){
            let storyboard = UIStoryboard(name: "Terminos", bundle: nil)
            progressController = (storyboard.instantiateViewController(withIdentifier: "TerminosID") as! Terminos)
           
            progressController.modalPresentationStyle = .overCurrentContext
            
             viewParent.navigationController?.present(progressController, animated: false, completion: {
                self.request = URLRequest(url: URL(string: self.url)!)
                self.webView.load(self.request)
                })
            }
               
        func hideProgress(){
                if(progressController != nil){
                       progressController.dismiss(animated: false, completion: nil)
                        //progressController.view.removeFromSuperview()
                }
                   
                   //progressController.dismiss(animated: false, completion: nil)
        }
        
        

    }
