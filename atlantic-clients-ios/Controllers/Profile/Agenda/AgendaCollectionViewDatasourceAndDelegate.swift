import UIKit

class AgendaCollectionViewDatasourceAndDelegate: NSObject {
    var items: [Event] = []
    private var viewModel: AgendaViewModelProtocol
    private var viewParent: AgendaViewController
    private var index = -1
    init(items: [Event],viewModel: AgendaViewModelProtocol,viewParent: AgendaViewController) {
            self.items = items
            self.viewModel = viewModel
            self.viewParent = viewParent
            
        }
    }

extension AgendaCollectionViewDatasourceAndDelegate: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10,  height: collectionView.frame.height/5)
    }
}

extension AgendaCollectionViewDatasourceAndDelegate: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            let ind = sender.tag
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            
            
            appDelegate.delAgenda = DelAgendaAlert(parent: viewParent, title: "Agenda", message: "¿Está seguro de Eliminar este evento de su agenda?",eventoRegistroId: String(agendaSelectId), clienteId: String(appDelegate.usuario.clienteId),viewModel: self.viewModel,index:ind)
           
            appDelegate.delAgenda.showAlert()
            /*
            let agendaSelectId = items[sender.tag].agendaId
            viewModel.deleteData(eventoRegistroId: String(agendaSelectId), clienteId: String(appDelegate.usuario.clienteId))
            
            viewModel.reloadData(data:items)
            
            */
        }
}
