//
//  ClubTableViewDatasourceAndDelegate.swift
//  clients-ios
//
//  Created by Jhona on 9/7/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit

class ClubTableViewDatasourceAndDelegate: NSObject {
    
    private var items: [ClubCategory] = []
    private var viewModel: ClubViewModelProtocol
    
    init(items: [ClubCategory], viewModel: ClubViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension ClubTableViewDatasourceAndDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCellID") as? ClubTableViewCell else {
            return UITableViewCell()
        }
        let category = items[indexPath.row]
        cell.prepare(category: category)
        return cell
    }
}

extension ClubTableViewDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectClub(indexPath)
    }
}

