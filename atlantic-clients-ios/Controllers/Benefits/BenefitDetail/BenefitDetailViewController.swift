//
//  BenefitDetailViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit

class BenefitDetailViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: BenefitsDetailViewModelProtocol = BenefitsDetailViewModel()
    
    // Mark: - Properties
    
    var titles: [BenefitDetailTitles] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var descriptionLabel: Label!
    @IBOutlet weak var dateTitleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var reminderButton: Button!
    @IBOutlet weak var pointsTitleLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var haveTitleLabel: Label!
    @IBOutlet weak var pointsSliderLabel: Label!
    @IBOutlet weak var pointsSlider: UISlider!
    @IBOutlet weak var warningLabel: Label!

    override func viewDidLoad() {
        super.viewDidLoad()
        pointsSlider.setThumbImage(UIImage(named: "icon-present"), for: .normal)

        bind()
        viewModel.viewDidLoad()
    }
    
    @IBAction func createReminderButton(_ sender: Any) {
        //viewModel.tapCreateReminder()
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        //viewModel.presentCreateReminder = presentCreateReminder
        
    }
    
    func showTitles(titles: BenefitDetailTitles) {
        
        titleLabel.setRafflesTitle(with: titles.title)
        descriptionLabel.setRafflesSubTitle(with: titles.description)
        dateTitleLabel.setRafflesSubTitle(with: titles.dateTitle)
        dateLabel.setBenefitDetailTitle(with: titles.date)
        reminderButton.setRemindButton(with: titles.reminderTitle)
        pointsTitleLabel.setRafflesSubTitle(with: titles.pointsTitle)
        pointsLabel.setBenefitDetailTitle(with: titles.points)
        haveTitleLabel.setRafflesSub(with: titles.haveTitle)
        pointsSliderLabel.setBenefitDetailTitle(with: titles.pointsSliderTitle)
        warningLabel.setmessageSub(with: titles.message)
        
    }
    
}
