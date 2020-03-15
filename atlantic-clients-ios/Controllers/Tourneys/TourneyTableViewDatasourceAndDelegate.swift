//
//  TourneyTableViewDatasourceAndDelegate.swift
//  clients-ios
//
//  Created by Jhona on 9/8/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class TourneyTableViewDatasourceAndDelegate: NSObject {
    
    private var items: [TournamentDetails] = []
    private var viewModel: TourneyViewModelProtocol
    
    init(items: [TournamentDetails], viewModel: TourneyViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension TourneyTableViewDatasourceAndDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TourneyCellID") as? TourneyTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        //let tourney = items[indexPath.row]
        
        let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
        AF.request(dominio + items[indexPath.row].logo).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell.tourneyImage.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        
        
        //cell.prepare(tourney: tourney)
        return cell
    }
    
}

extension TourneyTableViewDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectTourney(tipo: items[indexPath.row].tipo,isList: items[indexPath.row].isList)
    }
}
