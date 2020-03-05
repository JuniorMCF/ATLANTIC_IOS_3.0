//
//  AD3CollectionViewDelegateAndDatasource.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/22/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AD3CollectionViewDelegateAndDatasource: NSObject {
    private var items: [Puestos] = []
        private var viewModel: AtlanticDerby3ViewModelProtocol
        
        init(items: [Puestos], viewModel: AtlanticDerby3ViewModelProtocol) {
            self.items = items
            self.viewModel = viewModel
        }
    }

    extension AD3CollectionViewDelegateAndDatasource: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AD3CellID", for: indexPath) as? AD3CollectionViewCell else {
                return UICollectionViewCell()
            }
            let positions = items[indexPath.row]
            cell.prepare(data: positions)
            return cell
        }
        
    }
    extension AD3CollectionViewDelegateAndDatasource: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //viewModel.didItemSelected(indexPath)
        }
    }
    extension AD3CollectionViewDelegateAndDatasource: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        }
    }
