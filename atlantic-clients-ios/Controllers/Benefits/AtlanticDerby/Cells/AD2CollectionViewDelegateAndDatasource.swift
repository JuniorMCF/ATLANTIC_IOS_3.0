//
//  AD2CollectionViewDelegateAndDatasource.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/21/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AD2CollectionViewDelegateAndDatasource: NSObject {
    private var items: [Puestos] = []
    private var viewModel: AtlanticDerby2ViewModelProtocol
    
    init(items: [Puestos], viewModel: AtlanticDerby2ViewModelProtocol) {
        self.items = items
        self.viewModel = viewModel
    }
}

extension AD2CollectionViewDelegateAndDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AD2CellID", for: indexPath) as? AD2CollectionViewCell else {
            return UICollectionViewCell()
        }
        let positions = items[indexPath.row]
        cell.prepare(data: positions)
        return cell
    }
    
}
extension AD2CollectionViewDelegateAndDatasource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didItemSelected(indexPath)
    }
}
extension AD2CollectionViewDelegateAndDatasource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
    }
}
