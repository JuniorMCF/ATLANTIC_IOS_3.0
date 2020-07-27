import Foundation
import UIKit
/**
 TableView que contiene los elementos de club del app
 */
class ClubTableViewDatasourceAndDelegate: NSObject {
    
     var items: [ClubCategory] = []
    private var viewModel: ClubViewModelProtocol
    
    init(items: [ClubCategory], viewModel: ClubViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}
/**
 TableView DataSource
 */
extension ClubTableViewDatasourceAndDelegate: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCellID") as? ClubTableViewCell else {
            return UITableViewCell()
        }
        let body1 = Constants().getBody(key: "body1")
        let body2 = Constants().getBody(key: "body2")
        let body3 = Constants().getBody(key: "body3")
        if(indexPath.row == 0 && body1){
            cell.icNotify.alpha = 1
        }
        if(indexPath.row == 1 && body2){
            cell.icNotify.alpha = 1
        }
        if(indexPath.row == 2 && body3){
            cell.icNotify.alpha = 1
        }
        let category = items[indexPath.row]
        cell.prepare(category: category)
        return cell
    }
}

/**
 TableView Delegate
 */
extension ClubTableViewDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectClub(indexPath)
    }
}

