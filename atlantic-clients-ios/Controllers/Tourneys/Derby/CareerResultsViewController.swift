import UIKit

class CareerResultsViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: CareerResultViewModelProtocol = CareerResultViewModel()
    
    // Mark: - Properties
    
    var titles: [CareerResultTitles] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var hourLabel: Label!
    @IBOutlet weak var headerView: View!
    
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var post1Label: Label!
    @IBOutlet weak var post2Label: Label!
    @IBOutlet weak var post3Label: Label!
    @IBOutlet weak var postView: View!
    
    @IBOutlet weak var nextCarrerLabel: Label!
    @IBOutlet weak var categoryCarrerLabel: Label!
    
    @IBOutlet weak var remindButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()
        postView.addCornerRadius(radius: 20)
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeaderView)))

        bind()
        viewModel.viewDidLoad()
    }
    
    @objc private func tapHeaderView() {
        viewModel.tapCareerAward()
    }
    
    /**
    Inicializar el viewmodel
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentCareerAward = presentCareerAward
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
    - Parameters:
       - titles : titulo de todos los elementos
    */
    func showTitles(titles: CareerResultTitles) {
        
        titleLabel.setCareerTitle(with: titles.title)
        dateLabel.setCareerSub(with: titles.date)
        hourLabel.setCareerSub(with: titles.hour)
        resultLabel.setCareerSub(with: titles.resultsTitle)
        post1Label.setClubTitle(with: titles.postfi1)
        post2Label.setClubTitle(with: titles.postfi2)
        post3Label.setClubTitle(with: titles.postfi3)
        nextCarrerLabel.setCareerSub(with: titles.nextCarrer)
        categoryCarrerLabel.setCareerSubTitle(with: titles.categoryCarrer)
        remindButton.setRemindButton(with: titles.reminderTitle)
        
    }
    
    /**
     Dirigirse a la vista de carreras
     */
    func presentCareerAward() {
        let storyboard = UIStoryboard(name: "CareerAward", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CareerAwardID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
