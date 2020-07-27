import UIKit

class TrophyLoseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var container: UIView!
    @IBOutlet var puesto: Label!
    @IBOutlet var nombre: Label!
    @IBOutlet var puntos: Label!
    @IBOutlet var precio: Label!
    func prepare(item: TournamentTable){
        
        puesto.setSubTitleViewLabel(with: String(item.posicion))
        nombre.setSubTitleViewLabel(with: item.nombre)
        puntos.setSubTitleViewLabel(with: String(item.puntaje))
        precio.setSubTitleViewLabel(with: String(item.premio))
    }
}
