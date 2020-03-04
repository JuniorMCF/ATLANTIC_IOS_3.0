//
//  File.swift
//  clients-ios
//
//  Created by Jhona on 8/1/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
class PaymentsTableViewDelegateAndDatasource: NSObject {
    private var items: [Cobros] = []

    init(items: [Cobros]) {
        self.items = items
    }
}

extension PaymentsTableViewDelegateAndDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCellID") as? PaymentTableViewCell else {
            return UITableViewCell()
        }
        let payment = items[indexPath.row]
        let dominio = "https://clienteatlantic.azurewebsites.net/admin/upload/promocion/"
        AF.request(dominio + items[indexPath.row].logoUrl).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell.payImageView.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        cell.prepare(payment: payment)
        return cell
    }

}
