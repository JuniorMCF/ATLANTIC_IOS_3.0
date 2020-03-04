//
//  BenefitsCAtegoryViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct BenefitsCategoryTitles {
    
    var spectacularTitle: String = "ESPECTACULARES"
    
}

public struct BenefitsCategory {
    
    var title: String
    var date: String
    var points: String
    var nameImage: String
    
}

class BenefitsCategoryDatasource {
    
    var items: [BenefitsCategory] = [
        BenefitsCategory(title: "Agenda 2019", date: "13 de Noviembre", points: "100 puntos", nameImage: ""),
        BenefitsCategory(title: "Set de copas de helado", date: "13 de Noviembre", points: "100 puntos", nameImage: ""),
        BenefitsCategory(title: "Corona Navideña", date: "20 de Noviembre", points: "100 puntos", nameImage: ""),
        BenefitsCategory(title: "Maletín Cooler", date: "6 de Noviembre", points: "100 puntos", nameImage: "")
    ]
}

protocol BenefitsCategoryViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func didSelectBenefitsCategory(_ indexPath: IndexPath)
    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((BenefitsCategoryTitles) -> Void)? { get set }
    var loadDatasources: ((BenefitsCategoryDatasource) -> Void)? { get set }
    var presentBenefitsCategory: ((BenefitsCategoryTypes) -> Void)? { get set }
}

class BenefitsCategoryViewModel: BenefitsCategoryViewModelProtocol {
    
    var showTitles: ((BenefitsCategoryTitles) -> Void)?
    var loadDatasources: ((BenefitsCategoryDatasource) -> Void)?
    var presentBenefitsCategory: ((BenefitsCategoryTypes) -> Void)?
    
    func viewDidLoad() {
        let titles = BenefitsCategoryTitles()
        showTitles?(titles)
        let datasources = BenefitsCategoryDatasource()
        loadDatasources?(datasources)
    }
    
    func didSelectBenefitsCategory(_ indexPath: IndexPath) {
        guard let type = BenefitsCategoryTypes(rawValue: indexPath.row) else { return }
        presentBenefitsCategory?(type)
    }
    
}

enum BenefitsCategoryTypes: Int {
    
    case agenda2019 = 0
    case copasHelado = 1
    case coronaNavideña = 2
    case maletinCooler = 3
}
