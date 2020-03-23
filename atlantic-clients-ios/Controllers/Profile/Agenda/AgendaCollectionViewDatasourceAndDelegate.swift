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
    private var viewParent: AgendaViewController
    private var index = -1
    init(items: [Event],viewModel: AgendaViewModelProtocol,viewParent: AgendaViewController) {
            self.items = items
            self.viewModel = viewModel
            self.viewParent = viewParent
            
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
            let agendaSelectId = items[sender.tag].agendaId
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            for index in 0...items.count-1{
                if items[index].id == items[sender.tag].id{
                    self.index = index
                }
            }
            
            
            appDelegate.delAgenda = DelAgenda(parent: viewParent, title: "Agenda", message: "¿Está seguro de Eliminar este evento de su agenda?",eventoRegistroId: String(agendaSelectId), clienteId: String(appDelegate.usuario.clienteId),viewModel: self.viewModel,index:self.index)
           
            appDelegate.delAgenda.showProgress()
            /*
            let agendaSelectId = items[sender.tag].agendaId
            viewModel.deleteData(eventoRegistroId: String(agendaSelectId), clienteId: String(appDelegate.usuario.clienteId))
            
            viewModel.reloadData(data:items)
            
            */
        }
}
