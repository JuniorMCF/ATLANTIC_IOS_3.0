//
//  EventsDetailViewController.swift
//  clients-ios
//
//  Created by Jhona on 9/4/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class EventsDetailViewController: UIViewController,YTPlayerViewDelegate  {
    
    // Mark: - ViewModel
    
    private var viewModel  = EventDetailViewModel()
    
    private var bannerCollectionViewDD: BannerCollectionViewDatasourceAndDelegate!
    private var horarioCollectionViewDD: HorarioCollectionViewDatasourceAndDelegate!
    
    private var buffetCollectionViewDD : BuffetCollectionViewDataAndDelegate!
    
    private var constraint : NSLayoutConstraint!
    // Mark: - Properties
    
    public var imagesBanner: [String] = []
    var coinsDetail: [EventDetailTitles] = []
    var event = Event()
    var tipo = "1"
    
    // MARK: - IBoulets
    @IBOutlet weak var cvBuffet: UICollectionView!
    @IBOutlet weak var viewBuffet: UIView!

    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var hoursLabel: Label!
    @IBOutlet var horarioCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var buffetTitleLabel: Label!
    
    @IBOutlet var showLabel: Label!
    
    @IBOutlet weak var showTitleLabel: Label!
    @IBOutlet weak var nameShowLabel: Label!

    @IBOutlet var webview: YTPlayerView!
    @IBOutlet weak var assistantLabel: Label!
    @IBOutlet weak var numberssistantLabel: Label!
    @IBOutlet weak var registerButton: Button!
    private var isOpen = true
    private var sizeCollectionView:CGFloat = 0
    var playerVars : NSDictionary = [
        "playsinline" : 1
    ]
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func tapRegister(_ sender: Any) {
        
        appDelegate.customEvent = CustomEvent(parent: self,title: "Eventos", message: "Esta seguro que se quiere registrar en este evento",viewModel: viewModel,id: appDelegate.usuario.clienteId, horarioId: String(event.horarioId), acompanantes: total )
        appDelegate.customEvent.showProgress()
        //viewModel.saveData()
        
    }
    @IBAction func lessAcompanantes(_ sender: Any) {
        let nAcompanantes = (event.nAcompanantes as NSString).integerValue
        if(total > 0){
            total -= 1
            numberssistantLabel.text = String(total)
        }
        
    }
    
    @IBAction func moreAcompanantes(_ sender: Any) {
        let nAcompanantes = (event.nAcompanantes as NSString).integerValue
        if(total < nAcompanantes){
            total += 1
            numberssistantLabel.text = String(total)
        }
        
    }
    
    var total = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        //webview.load(withVideoId: "M7lc1UVf-VE",playerVars:playerVars as! [AnyHashable : Any])
        
        bind()
        prepareCollectionViews()
        presentBanner()
        viewModel.viewDidLoad(eventoId: event.id)
        viewModel.loadDatasources = loadDatasources(datasources:)
    }
    
    func prepareCollectionViews() {
        // Flow Promotions
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: view.frame.width, height: bannerCollectionView.frame.height)
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        
        bannerCollectionView.collectionViewLayout = flow
        bannerCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.loadDatasources = loadDatasources(datasources:)
        viewModel.loadBuffets = loadBuffets(buffets:)
    }
    func presentBanner(){
        var fotos = event.fotos
        var listFotos = [String]()
        if(tipo == "1"){
            if(fotos.count == 1){
                listFotos.append("")
            }else{
                fotos.remove(at:0)
                for dat in fotos{
                    if(dat.foto == nil){
                        listFotos.append("")
                    }else{
                        listFotos.append(dat.foto)
                    }
                }
            }
        }else{
            if(fotos[0].foto.count == 0){
                listFotos.append("")
            }else{
                for foto in fotos[0].foto{
               
                }
            }

        }
        bannerCollectionViewDD = BannerCollectionViewDatasourceAndDelegate(items: listFotos , pageControl: bannerPageControl)
        bannerCollectionView.dataSource = bannerCollectionViewDD
        bannerCollectionView.delegate = bannerCollectionViewDD
    }
    

    
    
    @IBAction func openCloseBuffet(_ sender: Any) {
        if(isOpen){
            constraint.constant = 0
            constraint.isActive = true
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            isOpen = false
        }else{
            constraint.constant = sizeCollectionView
            constraint.isActive = true
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            isOpen = true
        }
    }
    
    
    func showTitles(titles: EventDetailTitles){
        //metodo para inflar el video con youtube_ios_player_helper
        let streamUrl = event.video
        var urlId = ""
        let index = streamUrl.endIndex(of: "?v=")
        if(index != nil){
            urlId = streamUrl.substring(from: index!)
           
        }
        print("id:",urlId)
        print("url: ",event.video)
        webview.load(withVideoId: urlId,playerVars:playerVars as? [AnyHashable : Any])
        titleLabel.setDetailTitle(with: event.nombre.uppercased())
        //fecha
        let fecha = (event.fecha as NSString).doubleValue
        let date = Date(timeIntervalSince1970: TimeInterval(fecha/1000.0))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd"
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.timeZone = TimeZone(abbreviation: "GMT")
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "MM"
        dateFormatter3.locale = NSLocale.current
        dateFormatter3.timeZone = TimeZone(abbreviation: "GMT")
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
        let myComponents = myCalendar!.components(.weekday, from: date)
        let weekDay = myComponents.weekday
        var txtDia = ""
        txtDia = getDia(weekDay: weekDay!)
        let txtDiaNumero = dateFormatter2.string(from: date)
        let mes = dateFormatter3.string(from: date)
        let txtMes = getMonth(month:mes)
        dateLabel.setDetailSubTitle(with: txtDia + " " + txtDiaNumero + " " + txtMes)
        hoursLabel.setDetailSubTitle(with: titles.hours)

        
        buffetTitleLabel.setDetailSubTitle(with: titles.buffetTitle)
       
        
        showTitleLabel.setDetailSubTitle(with: titles.showTitle)
        nameShowLabel.setDetailSub(with: event.tituloShow)
        showLabel.setDetailSub(with: event.show)
        
    
        
        assistantLabel.setDetailSubTitle(with: titles.assistant)
        numberssistantLabel.setDetailSubTitleCenter(with: "0")
        registerButton.setRemindButton2(with: titles.registerTitle)
        
    }
    func getDia(weekDay:Int)->String{
        var txtDia = ""
        if(weekDay == 1){
            txtDia = "DOMINGO"
        }
        if(weekDay == 2){
            txtDia = "LUNES"
        }
        if(weekDay == 3){
            txtDia = "MARTES"
        }
        if(weekDay == 4){
            txtDia = "MIERCOLES"
        }
        if(weekDay == 5){
            txtDia = "JUEVES"
        }
        if(weekDay == 6){
            txtDia = "VIERNES"
        }
        if(weekDay == 7){
            txtDia = "SABADO"
        }
        return txtDia
    }
    func getMonth(month:String)->String{
        var txtMes = ""
        if(month == "01"){
            txtMes = "ENERO"
        }
        if(month == "02"){
            txtMes = "FEBRERO"
        }
        if(month == "03"){
            txtMes = "MARZO"
        }
        if(month == "04"){
            txtMes = "ABRIL"
        }
        if(month == "05"){
            txtMes = "MAYO"
        }
        if(month == "06"){
            txtMes = "JUNIO"
        }
        if(month == "07"){
            txtMes = "JULIO"
        }
        if(month == "08"){
            txtMes = "AGOSTO"
        }
        if(month == "09"){
            txtMes = "SETIEMBRE"
        }
        if(month == "10"){
            txtMes = "OCTUBRE"
        }
        if(month == "11"){
            txtMes = "NOVIEMBRE"
        }
        if(month == "12"){
            txtMes = "DICIEMBRE"
        }
        return txtMes
    }
    func loadDatasources(datasources: [Horario]) {
        /*
        var horarioslist = [Horario]()
        let horarios = Horario()
        horarios.fecha = "2:0"
        horarioslist.append(horarios)
        horarioslist.append(horarios)
        horarioslist.append(horarios)
        */
        //horarios collectionview
        horarioCollectionViewDD = HorarioCollectionViewDatasourceAndDelegate(horarios: datasources)
        horarioCollectionView.dataSource = horarioCollectionViewDD
        horarioCollectionView.delegate = horarioCollectionViewDD
        
        
       
    }
    
    
    func loadBuffets(buffets: [[String]]){
        print(buffets)
        buffetCollectionViewDD = BuffetCollectionViewDataAndDelegate(buffets: buffets)
        cvBuffet.dataSource = buffetCollectionViewDD
        cvBuffet.delegate = buffetCollectionViewDD
        
        sizeCollectionView = self.cvBuffet.collectionViewLayout.collectionViewContentSize.height
        self.viewBuffet.translatesAutoresizingMaskIntoConstraints = false
        constraint = self.viewBuffet.heightAnchor.constraint(equalToConstant: sizeCollectionView)
        constraint.isActive = true
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
        
        
     
        
    }
    
    

}

//encontrar el indice en el video
extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                indices.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
