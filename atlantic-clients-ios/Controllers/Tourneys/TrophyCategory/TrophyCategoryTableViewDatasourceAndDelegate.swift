//
//  TrophyCategoryTableViewDatasourceAndDelegate.swift
//  clients-ios
//
//  Created by Jhona on 9/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class TrophyCategoryTableViewDatasourceAndDelegate: NSObject {
    
    private var items: [Tournament] = []
    private var viewModel: TrophyCategoryViewModelProtocol
    
    init(items: [Tournament], viewModel: TrophyCategoryViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension TrophyCategoryTableViewDatasourceAndDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrophyCategoryCellID") as? TrophyCategoryTableViewCell else {
            return UITableViewCell()
        }
        let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
        AF.request(dominio + items[indexPath.row].logo).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell.trophyImageView.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        let trophyCategory = items[indexPath.row]
        cell.prepare(trophyCategory: trophyCategory)
        return cell
        
    }
    
}

extension TrophyCategoryTableViewDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectTrophyCategory(items[indexPath.row])
    }
}
