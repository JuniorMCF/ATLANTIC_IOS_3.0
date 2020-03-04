//
//  AgendaDatasourceAndDelegate.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/26/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class NotifyDatasourceAndDelegate: NSObject {
        private var items: [Notify] = []
       private var viewModel: NotifyViewModelProtocol
       
       init(items: [Notify], viewModel: NotifyViewModelProtocol) {
           self.items = items
           self.viewModel = viewModel
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
        
        let positions = items[indexPath.row]
        cell.prepare(item: positions)
        return cell
    }
    
}
extension NotifyDatasourceAndDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didItemSelected(indexPath)
        print("ga1")
    }
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)-> UICollectionViewCell{
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NotifyCellID", for: indexPath) as! NotifyCollectionViewCell
        //añades algo para identificarlo, pero al botón, por ejemplo
        cell.ocultarNotifyButton.tag = indexPath.row
        //añades el target
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        cell.ocultarNotifyButton.addGestureRecognizer(tap)
        cell.ocultarNotifyButton.isUserInteractionEnabled = true
        return cell
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        
        print("gaaa")
    }
    
    
    @objc func tapOcultarNOtify(){
        print("gaaa") //no sale :V no va a dar click
    }
   
}
extension NotifyDatasourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width -  collectionView.frame.width/9.5,  height: collectionView.frame.height/5)
    }
}
