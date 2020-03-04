//
//  RafflesTableViewDatasourceAndDelegate.swift
//  clients-ios
//
//  Created by Jhona on 9/7/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class RafflesTableViewDatasourceAndDelegate: NSObject {
    
    private var items: [Sorteo] = []
    private var viewModel: RafflesViewModelProtocol
    
    init(items: [Sorteo], viewModel: RafflesViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension RafflesTableViewDatasourceAndDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RafflesCellID") as? RafflesTableViewCell else {
            return UITableViewCell()
        }
        let raffles = items[indexPath.row]
        
        let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
        AF.request(dominio + items[indexPath.row].logoUrl).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell.rafflesImageView.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        
        
        cell.prepare(raffles: raffles)
        return cell
    }
    
}

extension RafflesTableViewDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRaffles(items[indexPath.row])
    }
}
