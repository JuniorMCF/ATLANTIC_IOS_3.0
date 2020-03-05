//
//  AgendaDatasourceAndDelegate.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/26/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class NotifyDatasourceAndDelegate: NSObject {
       var items: [Notify] = []
       private var viewModel: NotifyViewModelProtocol
       private var parentView : NotifyViewController!
       
    init(items: [Notify], viewModel: NotifyViewModelProtocol, parentView : NotifyViewController) {
           self.items = items
           self.viewModel = viewModel
           self.parentView = parentView
       }
}

extension NotifyDatasourceAndDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotifyCellID", for: indexPath) as? NotifyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.ocultarNotifyButton.tag = indexPath.row
        let positions = items[indexPath.row]
        cell.prepare(item: positions)
        cell.ocultarNotifyButton.addTarget(self, action: #selector(hideNotify(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func hideNotify(_ sender: UIButton){
        var buttonCenter = CGPoint(x: sender.bounds.origin.x + sender.bounds.size.width/2,
                                   y: sender.bounds.origin.y + sender.bounds.size.height/2);
        
        let point = sender.convert(buttonCenter, to: self.parentView.notifyView)
        let notifySelectId = items[sender.tag].id
        parentView.showViewOption(posX: point.x + sender.frame.width, posY: point.y - sender.frame.height,notifySelectID: notifySelectId,position: sender.tag)
    }
    
}
extension NotifyDatasourceAndDelegate: UICollectionViewDelegate {

    
   
}
extension NotifyDatasourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width -  collectionView.frame.width/9.5,  height: collectionView.frame.height/5)
    }
}
