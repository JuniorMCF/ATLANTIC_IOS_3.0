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
    private var viewModel : EventDetailViewModelProtocol!
    init(horarios : [Horario],viewModel:EventDetailViewModelProtocol){
            self.horarios = horarios
            self.viewModel = viewModel
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
        
        if(horarios[indexPath.row].seleccionado == 0){
            cell.contentView.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }else{
            cell.contentView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
        }
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indice = indexPath
        let cell = collectionView.cellForItem(at:indice )!
        if(horarios[indice.row].seleccionado == 0){
            cell.contentView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.4549019608, blue: 0.3176470588, alpha: 1)
            horarios[indice.row].seleccionado = 1
            viewModel.setHorario(horarioId: String(horarios[indice.row].id))
            for index in 0...horarios.count-1{
                if (index != indice.row){
                    horarios[index].seleccionado = 0
                }
            }
            collectionView.reloadData()
        }
        
    }
 
  }
