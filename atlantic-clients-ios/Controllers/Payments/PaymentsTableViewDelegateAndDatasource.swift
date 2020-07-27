import Foundation
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
/**
TableView que contiene los elementos de payment
*/
class PaymentsTableViewDelegateAndDatasource: NSObject {
    private var items: [Cobros] = []

    init(items: [Cobros]) {
        self.items = items
    }
}
/**
TableView DataSource
*/
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
