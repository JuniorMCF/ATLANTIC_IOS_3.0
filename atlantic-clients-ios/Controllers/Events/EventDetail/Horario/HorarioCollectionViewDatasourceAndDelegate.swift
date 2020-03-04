//
//  HorarioCollectionViewDatasourceAndDelegate.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/3/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class HorarioCollectionViewDatasourceAndDelegate: NSObject {
    private var horarios = [Horario]()
        
        init(horarios : [Horario]){
            self.horarios = horarios
        }
    }


extension HorarioCollectionViewDatasourceAndDelegate: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horarios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorarioCellID", for: indexPath) as! HorarioCollectionViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let date = dateFormatter.date(from: horarios[indexPath.row].fecha)
        dateFormatter.dateFormat = "hh:mm a"
        let Date12 = dateFormatter.string(from: date!)
        
        
        
        cell.hora.setTitle(Date12,for: .normal)
        cell.hora.tintColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.hora.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 14)!
        
        
        
        return cell
    }
    
    
    
    
  
    
}

extension HorarioCollectionViewDatasourceAndDelegate: UICollectionViewDelegateFlowLayout{
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width/3.1, height: 30)
      }
 
  }
