import UIKit

class BenefitsViewController: UIViewController {
    
    // Mark: - ViewModel
    
    private var viewModel: BenefitsViewModelProtocol = BenefitsViewModel()
    
    //Mark: - DataSource
    
    private var benefitsTableViewDD: BenefitsTableViewDelegateAndDatasource!
    
    // Mark: - Properties
    
    var benefits: [Benefits] = []
    
    // Mark: - Outlets
    
    @IBOutlet weak var benefitsTableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.progressDialog = CustomProgress(parent: self, title: "Beneficios", message: "Obteniendo beneficios ...")        
        bind()
        viewModel.viewDidLoad()
        
    }
    
    /**
    Inicializa el viewmodel.
    */
    func bind() {
        viewModel.loadDatasources = loadDatasources(datasource: )
        viewModel.presentBenefit = presentBenefit(type: )
        
    }
    
    
    /**
    Carga la lista de beneficios
    - Parameters:
       - datasources: lista de beneficios
    */
    
    func loadDatasources(datasource: [Benefits]) {
        benefitsTableViewDD = BenefitsTableViewDelegateAndDatasource(items: datasource, viewModel: viewModel)
        benefitsTableView.dataSource =  benefitsTableViewDD
        benefitsTableView.delegate = benefitsTableViewDD
        self.benefits = datasource
        self.benefitsTableView.reloadData()
    }
    
    /**
     Dirige hacia una pantalla especifica, de acuerdo a la condicion del beneficio
     - Parameters:
        - type: beneficio seleccionado
     */
    
    func presentBenefit(type: Benefits) {
        let mr: ComparisonResult = type.tipo.compare("Martes Regalones", options: NSString.CompareOptions.caseInsensitive)
        let dr: ComparisonResult = type.tipo.compare("Domingos Regalones", options: NSString.CompareOptions.caseInsensitive)
   
        if (mr == .orderedSame || dr == .orderedSame){
                // Esta vista fue modificada para parecerse a la de listBenefits
                let storyboard = UIStoryboard(name: "AllBenefits", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "AllBenefitsID") as! AllBenefitsViewController
                viewController.modalPresentationStyle = .fullScreen
                viewController.benefit = type
                viewController.tipo = 0 //martes y domingo regalon
                self.navigationController?.pushViewController(viewController, animated: true)
                return
        }else{
             
            if(type.esCarrera == nil){

                    let storyboard = UIStoryboard(name: "AllBenefits", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "AllBenefitsID") as! AllBenefitsViewController
                    viewController.modalPresentationStyle = .fullScreen
                    viewController.benefit = type
                    viewController.tipo = 1 //otros detalles
                    self.navigationController?.pushViewController(viewController, animated: true)
                    return
            }else{
                //variable key:Int
                //1: no hay carrera hoy

                //2: faltan puntos para participar
                //3: cliente participa de carrera
                //4: gano carrera
                //5: perdio carrera
                var key = 0

                if(type.esCarrera!){

                    if(type.carrera_participa){
                        key = 3
                    }
                    else if(!type.carrera_participa){
                        key = 2
                    }
                    if(!type.carrera_pendiente){

                        if(type.posicion <= 3 && type.premio != 0.0){
                            key = 4
                        }else{
                            key = 5
                        }
                    }
                }else{
                    key = 1
                }
                
     

                    //5 casos segun el key se inflan los AtlanticDerby
	                    switch key {
                        case 1  :
                            //atlantic derby5
                            let storyboard = UIStoryboard(name: "AtlanticDerby5", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby5ID") as! AtlanticDerby5ViewController
                            viewController.modalPresentationStyle = .fullScreen
                            viewController.benefit = type
                            self.navigationController?.pushViewController(viewController, animated: true)
                            break /* optional */
                        case 2 :
                            //atlantic derby
                            let storyboard = UIStoryboard(name: "AtlanticDerby", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerbyID") as! AtlanticDerbyViewController
                            viewController.modalPresentationStyle = .fullScreen
                            viewController.benefit = type
                            self.navigationController?.pushViewController(viewController, animated: true)
                            break /* optional */
                        case 3 :
                            //atlantic derby4
                            let storyboard = UIStoryboard(name: "AtlanticDerby4", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby4ID") as! AtlanticDerby4ViewController
                            viewController.modalPresentationStyle = .fullScreen
                            viewController.benefit = type
                            self.navigationController?.pushViewController(viewController, animated: true)
                            break /* optional */
                        case 4 :
                            //atlantic derby3
                            let storyboard = UIStoryboard(name: "AtlanticDerby3", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby3ID") as! AtlanticDerby3ViewController
                            viewController.modalPresentationStyle = .fullScreen
                            viewController.benefit = type
                            self.navigationController?.pushViewController(viewController, animated: true)
                            break /* optional */
                        case 5 :
                            //atlantic derby2
                            let storyboard = UIStoryboard(name: "AtlanticDerby2", bundle: nil)
                            let viewController = storyboard.instantiateViewController(withIdentifier: "AtlanticDerby2ID") as! AtlanticDerby2ViewController
                            viewController.modalPresentationStyle = .fullScreen
                            viewController.benefit = type
                            self.navigationController?.pushViewController(viewController, animated: true)
                            break /* optional */
                      
                        /* you can have any number of case statements */
                        default : /* Optional */
                          print("default value")
                    }

                }



            }

        }
        


}
