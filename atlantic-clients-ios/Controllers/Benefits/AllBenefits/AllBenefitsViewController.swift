//
//  AllBenefitsViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/14/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class AllBenefitsViewController: UIViewController {
    
    private var allBenefitsCollecionViewDD : AllBenefitsCollectionViewDelegateAndDatasource!
    // Mark: - ViewModel
    
    private var viewModel: AllBenefitsViewModelProtocol = AllBenefitsViewModel()
    
    // Mark: - Properties
    
    var titles: [AllBenefitsTitles] = []
    var fotos = [Foto]()
    var tipo = -1
    var benefit = Benefits()
    // Mark: - Outlets
    var posicion = 0
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var underLineView: UIView!
    @IBOutlet var tabBar: UINavigationItem!
    @IBOutlet weak var dateSwapLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var reminderButton: Button!
    @IBOutlet weak var pointsLabel: Label!
    @IBOutlet weak var awardTitleLabel: Label!
    
    //VISTA  1
    @IBOutlet var viewParentHidden: UIView!
    @IBOutlet var vHidden: UIView!// ocultar esta vista cuando sea domingos regalones y reducir el tamaño del contenedor en 100
    @IBOutlet var buttonView: UIView!//mover esta vista en domingos regalones
    
    @IBOutlet var titlePuntosLabel: Label!
    @IBOutlet var puntosLabel: Label!
    @IBOutlet var winLabel: Label!
    @IBOutlet var haGanadoLabel: Label!
    @IBOutlet var leFaltanLabel: Label!
    //VISTA 2
    
    @IBOutlet var view2: UIView!
    @IBOutlet var terminosLabel2: Label!
    @IBOutlet var fechaActualizacionLabel2: Label!
    @IBOutlet var titleLabel2: Label!
    @IBOutlet var puntosLabel2: Label!
    @IBOutlet var leFaltanLabel2: Label!
    @IBOutlet var remindButton2: Button!
    @IBOutlet var newFechaLabel: Label!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        view2.alpha = 0
        view2.isUserInteractionEnabled = false
        
        bind()
        if(tipo == 0){
            let fechaActual = Utils().getFechaActual()
            viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: benefit.nombre, promocionId: String(benefit.promocion_id))
        }else if(tipo == 1){
            let fechaActual = Utils().getFechaActual()
            viewModel.onStart(clienteId: appDelegate.usuario.clienteId, fechaIngreso: fechaActual, nombrePromocion: benefit.nombre, promocionId: String(benefit.promocion_id))
        }
        
        
        
        
        viewModel.viewDidLoad()
    }
    
    @IBAction func rightCV(_ sender: Any) {
        if(posicion < fotos.count-1){
            let lastSection = collectionView.numberOfSections - 1

            let indexPath = IndexPath(row: posicion+1, section: lastSection)

            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            posicion += 1
        }
        
    }
    
    @IBAction func leftCV(_ sender: Any) {
        if(posicion > 0){
            let lastSection = collectionView.numberOfSections - 1

            let indexPath = IndexPath(row: posicion-1, section: lastSection)

            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            posicion -= 1
        }
    }
    
    
    @IBAction func CreateReminder(_ sender: Any) {
        let fecha = (benefit.fecha as NSString)
        Utils().saveEvent(title: benefit.nombre, fecha: fecha,parent: self)
        
    }
    
    

    func bind() {
        viewModel.showTitles = showTitles(titles: )
        loadDatasources(datasource:benefit)
        
    }
    func loadDatasources(datasource: Benefits) {
        if(datasource.fotos.count == 1){
            pageControl.isUserInteractionEnabled = false
            pageControl.alpha = 0.0
            leftButton.isUserInteractionEnabled = false
            rightButton.isUserInteractionEnabled = false
            leftButton.alpha = 0.0
            rightButton.alpha = 0.0
        }
        
        
        allBenefitsCollecionViewDD = AllBenefitsCollectionViewDelegateAndDatasource(items:datasource.fotos, viewModel: viewModel, pageControl: self.pageControl,collectionView: collectionView)
        collectionView.dataSource =  allBenefitsCollecionViewDD
        collectionView.delegate = allBenefitsCollecionViewDD
        self.fotos = datasource.fotos
        self.collectionView.reloadData()
    }
    
    func showTitles(titles: AllBenefitsTitles) {
        if(benefit.nombre == "Domingos Regalones" || benefit.nombre == "Martes Regalones"){
            //mostramos la vista encima  y anulamos los botones de la vista que se encuentra atras
            //dateLabel.setBenefitDetailTitle(with: "Fecha: "+benefit.fechaTexto)
            
            view2.alpha = 1
            view2.isUserInteractionEnabled = true
            notInteractive()
            titleLabel2.setSubTitleViewLabel(with: "Hasta el momento tiene:")
            tabBar.title = benefit.nombre
            dateSwapLabel.setRafflesTitleGold(with: benefit.nombre)
            let fechaTexto = benefit.fechaTexto
            if(!benefit.fechaTexto.isEmpty || benefit.fechaTexto.caseInsensitiveCompare("null") == .orderedSame){
                dateLabel.setBenefitDetailTitle(with: "Fecha: "+benefit.fechaTexto)
            }else{
                dateLabel.setBenefitDetailTitle(with: "Fecha: ")
            }
            
            
            leFaltanLabel2.setSubTitleViewLabel(with: "Le faltan "+String(benefit.puntos_falta)+" puntos para canjear su regalo")
            
            underLineView.alpha = 1.0
            remindButton2.setRemindButton(with: titles.reminderTitle)
            
            let fecha = (benefit.fechaActualizacion as NSString).doubleValue
            let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))
            //transformar el formato de fecha  dd/MM/yy    y   la hora  hh:mm
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"
            dateFormatter.locale = NSLocale.current
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm"
            dateFormatter2.locale = NSLocale.current
            dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")
            let txtFecha = dateFormatter.string(from: date)
            let txtHour = dateFormatter2.string(from: date)
            terminosLabel2.setRafflesSubUnderline(with: "Vér terminos y condiciones")
            fechaActualizacionLabel2.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
            terminosLabel2.isUserInteractionEnabled = true
            terminosLabel2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos2)))
            //CASOS PARA FILTRAR LOS LABELS
            if (benefit.puntos == -2){
                
                puntosLabel2.alpha = 0
                puntosLabel2.setSubTitleViewLabelRed(with: " ")
                newFechaLabel.alpha = 0
                newFechaLabel.setSubTitleViewLabel(with: " ")
                titleLabel2.alpha = 0
                titleLabel2.setSubTitleViewLabel(with: " ")
                leFaltanLabel2.alpha = 0
                leFaltanLabel2.setSubTitleViewLabel(with: " ")
                
            }else if (benefit.puntos == -1){

                puntosLabel2.alpha = 0
                puntosLabel2.setSubTitleViewLabelRed(with: " ")
                
                puntosLabel2.setSubTitleViewLabelCenter(with:"Usted ya canjeó su regalo ¡disfrútelo!")
                newFechaLabel.alpha = 0
                leFaltanLabel2.setSubTitleViewLabelCenter(with: " ")
                
                newFechaLabel.setSubTitleViewLabel(with: "Próxima fecha: "+benefit.fechaProximaTexto)
                titleLabel2.setSubTitleViewLabel(with: " ")
                
            }else if ( benefit.puntos >= 0){
                puntosLabel2.setSubTitleViewLabelRed(with: String(benefit.puntos)+" puntos")
                if(benefit.puntos == 0){
                    newFechaLabel.setSubTitleViewLabel(with: "Usted todavia no ha empezado a acumular puntos")
                }else if(benefit.puntos < benefit.puntos_minimo){
                    let progress = (benefit.puntos*100)/benefit.puntos_minimo
                   
                   // new fecha sera la secciond e puntos faltantes
                    newFechaLabel.setSubTitleViewLabelRed(with: "Le faltan "+String(benefit.puntos_falta)+"puntos")
                }else{
                    let progress = (benefit.puntos*100)/benefit.puntos_minimo
                    
                    puntosLabel2.setSubTitleViewLabelCenter(with: "Ya puede canjear su regalo")
                    newFechaLabel.alpha = 0
                    newFechaLabel.setSubTitleViewLabelRed(with: "¡Ya puede acercarse a canjear su regalo!")

                }

            }
            
            
        }else{
            if(benefit.esCarrera == nil){   // TOP 100
                tabBar.title = "Beneficios"
                dateSwapLabel.setRafflesTitleGold(with: benefit.nombre)
                dateLabel.setBenefitDetailTitle(with: "Fecha: "+benefit.fechaTexto)
                underLineView.alpha = 0.0
                reminderButton.setRemindButton(with: titles.reminderTitle)
                
                let fecha = (benefit.fechaActualizacion as NSString).doubleValue
                let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))
                //transformar el formato de fecha  dd/MM/yy    y   la hora  hh:mm
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yy"
                dateFormatter.locale = NSLocale.current
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "HH:mm"
                dateFormatter2.locale = NSLocale.current
                dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")
                let txtFecha = dateFormatter.string(from: date)
                let txtHour = dateFormatter2.string(from: date)
                
                //transformar el formato de fecha  dd/MM/yy    y   la hora  hh:mm
                pointsLabel.setRafflesSubUnderline(with: "Vér terminos y condiciones")
                awardTitleLabel.setDateModify(with: "actualizado el "+txtFecha+" a las "+txtHour+" hrs")
                pointsLabel.isUserInteractionEnabled = true
                pointsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))
                // vista que se oculta en martes regalones
                
                titlePuntosLabel.setSubTitleViewLabel(with: "")
                puntosLabel.setSubTitleViewLabel(with: "Hasta el momento tiene:")
                winLabel.setSubTitleViewLabelRed(with: String(benefit.puntos)+" puntos")
                haGanadoLabel.setSubTitleViewLabelRedCenter(with: "")
                leFaltanLabel.setSubTitleViewLabel(with: " ")
                
                    if(benefit.puntos_falta <= 0){
                        leFaltanLabel.setSubTitleViewLabel(with: " ")
                        leFaltanLabel.alpha = 0
                    }
                    let tipoBenefit = benefit.nombre
                    if(tipoBenefit.caseInsensitiveCompare("Top 100") == .orderedSame){

                        titlePuntosLabel.setSubTitleViewLabel(with: "Posición: "+String(benefit.posicion))
                        puntosLabel.setSubTitleViewLabel(with: "Usted obtuvo:")
                        haGanadoLabel.setSubTitleViewLabelRedCenter(with: "Está Ganado: "+String(benefit.premio))
                        leFaltanLabel.setSubTitleViewLabel(with: " ")
                    
                        if(benefit.posicion != nil) {

                            if (benefit.posicion > 150) {
                                titlePuntosLabel.alpha = 0
                                puntosLabel.alpha = 0
                                winLabel.alpha = 0
                                haGanadoLabel.alpha = 0
                                leFaltanLabel.alpha = 0
                            // agregar 2 vistas mas
                            
                            }
                        }
                    }
                
            }
        }
        // casos dependiendo de si es en soles o en dolares
            let benefitMoneda = benefit.tipoMoneda
            if(benefitMoneda.caseInsensitiveCompare("soles") == .orderedSame){
                leFaltanLabel.setSubTitleViewLabelCenter(with: "Le faltan "+String(benefit.puntos_falta)+" puntos para ganar: S/"+String(benefit.premio_falta.intValue))
                let tipoBenefit = benefit.nombre
                if((tipoBenefit.caseInsensitiveCompare("Top 100") == .orderedSame)){
                    haGanadoLabel.setSubTitleViewLabelRedCenter(with: "Está ganando $"+String(benefit.premio.intValue))
                }else{
                    haGanadoLabel.setSubTitleViewLabelRedCenter(with:"Ha ganado S/"+String(benefit.premio.intValue))
                }


            }else if(benefitMoneda.caseInsensitiveCompare("dólares") == .orderedSame){
                leFaltanLabel.setSubTitleViewLabelCenter(with: "Le faltan "+String(benefit.puntos_falta)+" puntos para ganar: $"+String(benefit.premio_falta.intValue))
                let tipoBenefit = benefit.nombre
                if((tipoBenefit.caseInsensitiveCompare("Top 100") == .orderedSame)){
                    let benefitMoneda = benefit.tipoMoneda
                    if(benefitMoneda.caseInsensitiveCompare("soles") == .orderedSame){
                       haGanadoLabel.setSubTitleViewLabelRedCenter(with: "Está ganando S/"+String(benefit.premio.intValue))
                    }else if(benefitMoneda.caseInsensitiveCompare("dólares") == .orderedSame){
                        haGanadoLabel.setSubTitleViewLabelRedCenter(with:"Está ganando $"+String(benefit.premio.intValue))
                    }
                }else{
                    let benefitMoneda = benefit.tipoMoneda
                    if(benefitMoneda.caseInsensitiveCompare("soles") == .orderedSame){
                        haGanadoLabel.setSubTitleViewLabelRedCenter(with: "Ha ganado S/"+String(benefit.premio.intValue))
                    }else if(benefitMoneda.caseInsensitiveCompare("dólares") == .orderedSame){
                        haGanadoLabel.setSubTitleViewLabelRedCenter(with:"Ha ganado $"+String(benefit.premio.intValue))
                    }
                }
            }
            if(benefit.puntos == 0){
                let tipoBenefit = benefit.nombre
                if(!(tipoBenefit.caseInsensitiveCompare("Top 100") == .orderedSame)){
                    haGanadoLabel.setSubTitleViewLabelRedCenter(with: " ")
                    haGanadoLabel.alpha = 0
                    
                }
            }


            if(benefit.puntos_falta == 0){
                puntosLabel.setSubTitleViewLabel(with: "Usted obtuvo:")
                let tipoBenefit = benefit.nombre
                if(!(tipoBenefit.caseInsensitiveCompare("Top 100") == .orderedSame)){
                    let benefitMoneda = benefit.tipoMoneda
                    if(benefitMoneda.caseInsensitiveCompare("soles") == .orderedSame){
                        haGanadoLabel.setSubTitleViewLabelRedCenter(with: "Ha ganado S/"+String(benefit.premio.intValue))
                    }else if(benefitMoneda.caseInsensitiveCompare("dólares") == .orderedSame){
                        haGanadoLabel.setSubTitleViewLabelRedCenter(with:"Ha ganado $"+String(benefit.premio.intValue))
                    }

                }
            
            
            
            
        }

        
    }
    func notInteractive(){
        vHidden.isUserInteractionEnabled = false
        buttonView.isUserInteractionEnabled = false
        buttonView.alpha = 0
        titlePuntosLabel.isUserInteractionEnabled = false
        puntosLabel.isUserInteractionEnabled = false
        winLabel.isUserInteractionEnabled = false
        haGanadoLabel.isUserInteractionEnabled = false
        leFaltanLabel.isUserInteractionEnabled = false
    }
    

    @objc func tapTerminos2(){
            let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
            terminos.showTerms()
        }
    @objc func tapTerminos(){
               let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
               terminos.showTerms()
           }
}
