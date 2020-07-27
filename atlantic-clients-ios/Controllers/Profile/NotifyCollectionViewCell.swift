import UIKit

class NotifyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleAgendaLabel: Label!
    @IBOutlet var messageAgendaLabel: Label!
    @IBOutlet var actionOcutarNotify: UIButton!
    @IBOutlet var subrayadoTitle: UIView!
    @IBOutlet var ocultarNotifyButton: UIButton!
    @IBOutlet var campanaImage: UIImageView!
    var estado = 0 //0: notify no clickeado 1: notify clickeado
    
    func hideItems(){
        titleAgendaLabel.alpha = 0.5
        messageAgendaLabel.alpha = 0.5
        ocultarNotifyButton.alpha = 0.5
        subrayadoTitle.alpha = 0.5
        actionOcutarNotify.alpha = 1.0
        campanaImage.alpha = 0.5
        
        //interactions
        titleAgendaLabel.isUserInteractionEnabled = false
        messageAgendaLabel.isUserInteractionEnabled = false
        actionOcutarNotify.isUserInteractionEnabled = true
        subrayadoTitle.isUserInteractionEnabled = false
        ocultarNotifyButton.isUserInteractionEnabled = true
        campanaImage.isUserInteractionEnabled = false
    }
    func showItems(){
        titleAgendaLabel.alpha = 1.0
        messageAgendaLabel.alpha = 1.0
        ocultarNotifyButton.alpha = 1.0
        subrayadoTitle.alpha = 1.0
        actionOcutarNotify.alpha = 0.0
        campanaImage.alpha = 1.0
        
        //interactions
        titleAgendaLabel.isUserInteractionEnabled = true
        messageAgendaLabel.isUserInteractionEnabled = true
        actionOcutarNotify.isUserInteractionEnabled = false
        subrayadoTitle.isUserInteractionEnabled = true
        ocultarNotifyButton.isUserInteractionEnabled = true
        campanaImage.isUserInteractionEnabled = false
    }

    func prepare(item: Notify) {
        let hoy = Date()
        let fecha = (item.fecha as NSString).doubleValue
        let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

        
        titleAgendaLabel.text = Utils().timeAgoSince(date)
        messageAgendaLabel.text = item.mensaje
        actionOcutarNotify.layer.cornerRadius = 10
       // showItems()
    }

}
