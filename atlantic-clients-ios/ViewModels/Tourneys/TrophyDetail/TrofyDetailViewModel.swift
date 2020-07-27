//
//  TrofyDetailViewModel.swift
//  clients-ios
//
//  Created by Jhona on 9/10/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation

struct TrophyDetailTitles {
    
    var stateTitle: String = "Usted está en el:"
    var position: String = "1er"
    var positionTitle: String = "puesto en el ranking"
    var pointsTitle = "Tiene hasta el momento"
    var points: String = "25187 Pts"
    
    var titlePosition = "PUESTO"
    var titleName = "NOMBRE"
    var titlePoints = "PUNTOS"
    var titleAwards = "PREMIOS"
    
}

public struct Positions {
    
    var position: String
    var name: String
    var points: String
    var awards: String
}

class PositionsDatasource {
    
    var items: [Positions] = [
        Positions(position: "1", name: "Pedro G.", points: "25168", awards: "$1000"),
        Positions(position: "2", name: "María S.", points: "18523", awards: "$500"),
        Positions(position: "3", name: "Daniel O.", points: "15201", awards: "$300"),
        Positions(position: "4", name: "Rocio R.", points: "13258", awards: "$100")
    ]
}

protocol TrophyDetailViewModelProtocol {
    
    // Mark: - Inputs
    
    func viewDidLoad()
    func tapPosition()

    
    // Mark: - Outputs (Closures)
    
    var showTitles: ((TrophyDetailTitles) -> Void)? { get set }
    var loadDatasources: ((PositionsDatasource) -> Void)? { get set }
    var presentPositionDetail: (() -> Void)? { get set }
    
}

class TrophyDetailViewModel: TrophyDetailViewModelProtocol {
    
    var showTitles: ((TrophyDetailTitles) -> Void)?
    var loadDatasources: ((PositionsDatasource) -> Void)?
    var presentPositionDetail: (() -> Void)?
    
    /**
     muestra los trofeos
     */
    func viewDidLoad() {
        
        let titles = TrophyDetailTitles()
        showTitles?(titles)
        let datasource = PositionsDatasource()
        loadDatasources?(datasource)
    }
    
    /**
     muestra las posiciones finales de la carrera
     */
    func tapPosition() {
        presentPositionDetail?()
    }
    
}
