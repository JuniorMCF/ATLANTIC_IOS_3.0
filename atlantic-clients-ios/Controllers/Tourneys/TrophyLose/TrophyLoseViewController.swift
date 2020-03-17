//
//  TrophyLoseViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/27/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class TrophyLoseViewController: UIViewController {
    // Mark: - ViewModel
    
    private var viewModel: TrophyLoseViewModelProtocol = TrophyLoseViewModel()
    
    //Mark: - DataSource & Delegate
    
    private var trophyLoseCollectionViewDD: TrophyLoseCollectionViewDatasourceAndDelegate!
    
    
    
    @IBOutlet var trophyLoseCollectionView: UICollectionView!
    // Mark: - Properties
    var torneo = Tournament()
    
    @IBOutlet var fechaLabel: Label!
  
    @IBOutlet var puestoLabel: Label!
    
    @IBOutlet var posicionLabel: Label!
    
    @IBOutlet var puntosLabel: Label!
    
    
    @IBOutlet var PuestoTitle: Label!
    @IBOutlet var NombreTitle: Label!
    @IBOutlet var puntosTitle: Label!
    @IBOutlet var PremioLabel: Label!
    
    @IBOutlet var terminosLabel: Label!
    @IBOutlet var FechaActualizacionLabel: Label!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var category: [TournamentTable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.viewDidLoad(promocionId: String(torneo.pomocion_id))
        presentTitles(data: torneo)
    }
    
    func bind() {
        viewModel.loadDatasources = loadDatasources
    }
    func presentTitles(data:Tournament){
        PuestoTitle.text = "Puesto"
        NombreTitle.text = "Nombre"
        puntosTitle.text = "Puntos"
        PremioLabel.text = "Premio"
        let fecha = (torneo.fechaActualizacion as NSString).doubleValue
        let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

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
        
        FechaActualizacionLabel.setDateModify(with: "actualizado el \(txtFecha) a las \(txtHour) hrs")
        
        
        
        fechaLabel.setSubTitleViewLabelCenter(with: "Fecha "+torneo.fechaTexto+"")
        puestoLabel.setSubTitleViewLabelCenter(with: "Usted ocupa el puesto")
        puntosLabel.setSubTitleViewLabelCenter(with: "Tiene hasta el momento "+String(torneo.puntaje)+" puntos")
        posicionLabel.setTitleForgotViewLabel(with: ""+String(torneo.posicion)+"°")
        terminosLabel.setRafflesSubUnderline(with: "Ver términos y condiciones")
        terminosLabel.isUserInteractionEnabled = true
        terminosLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerminos)))

    }
    @objc func tapTerminos(){
        let terminos = Terminos(parent: self, url: "http://clienteatlantic.azurewebsites.net/admin/upload/documento/Terminos_y_condiciones_de_Promocionales.pdf")
        terminos.showProgress()
    }
    
    func loadDatasources(datasource: [TournamentTable]) {
        trophyLoseCollectionViewDD = TrophyLoseCollectionViewDatasourceAndDelegate(items: datasource, viewModel: viewModel,pos: self.torneo.posicion)
        trophyLoseCollectionView.dataSource = trophyLoseCollectionViewDD
        trophyLoseCollectionView.delegate = trophyLoseCollectionViewDD
        self.category = datasource
        self.trophyLoseCollectionView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
