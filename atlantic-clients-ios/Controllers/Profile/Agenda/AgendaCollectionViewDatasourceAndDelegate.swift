//
//  AgendaCollectionViewDatasourceAndDelegate.swift
//  atlantic-clients-ios
//
//  Created by Junior on 3/10/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class AgendaCollectionViewDatasourceAndDelegate: NSObject {
    private var items: [Event] = []
    private var viewModel: AgendaViewModelProtocol
    init(items: [Event],viewModel: AgendaViewModelProtocol) {
            self.items = items
            self.viewModel = viewModel
        }
    }

extension AgendaCollectionViewDatasourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.92,  height: collectionView.frame.height/6)
    }
}

extension AgendaCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(items.count)
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCellID", for: indexPath) as? AgendaCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let breakfast = items[indexPath.row].fotos
            var foto = ""
            for data in breakfast{
                if(data.esPrincipal == true){
                    foto = data.foto
                }
            }
            cell.eliminarAgendaButton.tag = indexPath.row
            cell.eliminarAgendaButton.addTarget(self, action: #selector(delAgenda(_:)), for: .touchUpInside)
            cell.prepare(foto: foto,event:items[indexPath.row])
            return cell
                
            }
        @objc func delAgenda(_ sender: UIButton){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let agendaSelectId = items[sender.tag].agendaId
            viewModel.deleteData(eventoRegistroId: String(agendaSelectId), clienteId: String(appDelegate.usuario.clienteId))
            for data in items{
                if data.id == items[sender.tag].id{
                    items.remove(at: data.id)
                }
            }
            
        }
}
