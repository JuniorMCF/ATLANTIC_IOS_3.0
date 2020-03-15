//
//  BenefitsTableViewDelegateAndDatasource.swift
//  clients-ios
//
//  Created by Jhona on 8/9/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class BenefitsTableViewDelegateAndDatasource: NSObject {
    
    private var items: [Benefits] = []
    private var viewModel: BenefitsViewModelProtocol
    
    init(items: [Benefits], viewModel: BenefitsViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension BenefitsTableViewDelegateAndDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BenefitsCellID") as? BenefitsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let benefit = items[indexPath.row]
        
        let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
        AF.request(dominio + items[indexPath.row].logo).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell.benefitImageView.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        
        cell.prepare(benefit: benefit)
        return cell
    }
    
}

extension BenefitsTableViewDelegateAndDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectBenefits(self.items[indexPath.row])
    }
}
