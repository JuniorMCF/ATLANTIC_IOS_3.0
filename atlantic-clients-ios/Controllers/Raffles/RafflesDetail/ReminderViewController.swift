//
//  ReminderViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: ReminderViewModelProtocol = ReminderViewModel()
    
    // Mark: - Properties
    
    var titles: [ReminderTitles] = []
    var sorteo = Sorteo()
    
    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var acceptButton: Button!
    @IBOutlet weak var declineButton: Button!
    @IBOutlet weak var  notificationView: View!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationView.addCornerRadius(radius: 20)
        
        bind()
        viewModel.viewDidLoad()
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        viewModel.tapAccept()
    }
    
    @IBAction func declineButton(_ sender: Any) {
        viewModel.tapDecline()
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.dismisViewController = dismisViewController
        
    }
    
    func showTitles(titles: ReminderTitles) {
        titleLabel.setRafflesSubTitle(with: titles.reminderTitle)
        acceptButton.setWitheButton(with: titles.acceptTitle)
        declineButton.setWitheButton(with: titles.declineTitle)
 
    }
    

    func dismisViewController() {
        dismiss(animated: false, completion: nil)
    }

}
