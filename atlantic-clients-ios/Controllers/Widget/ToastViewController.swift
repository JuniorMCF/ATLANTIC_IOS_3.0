//
//  ToastViewController.swift
//  atlantic-clients-ios
//
//  Created by admin on 4/6/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {
    @IBOutlet weak var txtMessage: UILabel!
    public var message = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMessage.text = message
    }
    

   

}
