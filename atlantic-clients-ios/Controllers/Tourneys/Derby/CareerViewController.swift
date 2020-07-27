import UIKit

class CareerViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: CareerViewModelProtocol = CareerViewModel()
    
    // Mark: - Properties
    
    var titles: [CareerTitles] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var hourLabel: Label!
    @IBOutlet weak var headerView: View!
    
    @IBOutlet weak var pointsTitleLabel: Label!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var pointsSlider: UISlider!
    
    @IBOutlet weak var nextCarrerLabel: Label!
    @IBOutlet weak var categoryCarrerLabel: Label!

    @IBOutlet weak var remindButton: Button!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pointsSlider.setThumbImage(UIImage(named: "icon-horse-gray1"), for: .normal)
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeaderView)))

        bind()
        viewModel.viewDidLoad()
    }
    
    @objc private func tapHeaderView() {
        viewModel.tapCareerResult()
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentCareerResult = presentCareerResult
    }
    
    /**
    Proporciona estilo a los elementos de la vista.
    - Parameters:
       - titles : titulo de todos los elementos
    */
    func showTitles(titles: CareerTitles) {
        
        titleLabel.setCareerTitle(with: titles.title)
        dateLabel.setCareerSub(with: titles.date)
        hourLabel.setCareerSub(with: titles.hour)
        pointsTitleLabel.setCareerSubTitle(with: titles.haveTitle)
        pointsLabel.setCareerSub(with: titles.lackTitle)
        nextCarrerLabel.setCareerSub(with: titles.nextCarrer)
        categoryCarrerLabel.setCareerSubTitle(with: titles.categoryCarrer)
        remindButton.setRemindButton(with: titles.reminderTitle)
        
    }
    
    /**
     Dirigirse a la pantalla de resultados de la carrera
     */
    func presentCareerResult() {
        let storyboard = UIStoryboard(name: "CareerResults", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CareerResultsID")
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
