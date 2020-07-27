import UIKit

class CareerAwardViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: CareerAwardViewModelProtocol = CareerAwardViewModel()
    
    // Mark: - Properties
    
    var titles: [CareerAwardTitles] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var postLabel: Label!
    @IBOutlet weak var awardLabel: Label!
    
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var post1Label: Label!
    @IBOutlet weak var post2Label: Label!
    @IBOutlet weak var post3Label: Label!
    @IBOutlet weak var paymentsTitle: Button!
    @IBOutlet weak var postView: View!
    
    @IBOutlet weak var nextCarrerLabel: Label!
    @IBOutlet weak var categoryCarrerLabel: Label!
    
    @IBOutlet weak var remindButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()
        postView.addCornerRadius(radius: 20)
        
        bind()
        viewModel.viewDidLoad()
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.showTitles = showTitles(titles: )
        viewModel.presentPayments = presentPayments
    }
    
    @IBAction func tapPayments(_ sender: Any) {
        viewModel.tapPayments()
    }
    
    /**
       Proporciona estilo a los elementos de la vista.
       - Parameters:
          - titles : titulo de todos los elementos
       */
    func showTitles(titles: CareerAwardTitles) {
        
        titleLabel.setAwardTitle(with: titles.title)
        postLabel.setCareerSub(with: titles.date)
        awardLabel.setAwardTitle(with: titles.hour)
        resultLabel.setAwardTitle(with: titles.resultsTitle)
        post1Label.setClubTitle(with: titles.postfi1)
        post2Label.setClubTitle(with: titles.postfi2)
        post3Label.setClubTitle(with: titles.postfi3)
        paymentsTitle.setFirstButton(with: titles.paymentsTitle)
        nextCarrerLabel.setCareerSub(with: titles.nextCarrer)
        categoryCarrerLabel.setCareerSubTitle(with: titles.categoryCarrer)
        remindButton.setRemindButton(with: titles.reminderTitle)
        
    }
    /**
     Dirigirse a la ventana de pagos
     */
    func presentPayments() {
        navigationController?.popToRootViewController(animated: true)
        //navigationController?.tabBarController?.selectedIndex = 2
    }


}
