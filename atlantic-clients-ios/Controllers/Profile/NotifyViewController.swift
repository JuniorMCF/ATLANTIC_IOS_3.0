//
//  AgendaViewController.swift
//  atlantic-clients-ios
//
//  Created by Junior on 2/26/20.
//  Copyright © 2020 Atlantic City. All rights reserved.
//

import UIKit

class NotifyViewController: UIViewController {
    var viewModel: NotifyViewModelProtocol! = NotifyViewModel()
    private var agendaCollectionViewDD: NotifyDatasourceAndDelegate!
    var agendaList = [Notify]()
    @IBOutlet var agendaCollectionView: UICollectionView!
    @IBOutlet weak var btnHideNotification: UIButton!
    @IBOutlet weak var notifyView: UIView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var  notifySelectId = ""
    var position = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }
    func bind(){
        viewModel.loadDatasources = loadDatasources(datasource:)
        viewModel.showTitles = showTitles(items:)
        viewModel.successHideNotify = successHideNotify
    }
    func showTitles(items: [Notify]){
        
    }
    
    func loadDatasources(datasource: [Notify]) {
        agendaCollectionViewDD = NotifyDatasourceAndDelegate(items: datasource, viewModel: viewModel, parentView: self)
        agendaCollectionView.dataSource = agendaCollectionViewDD
        agendaCollectionView.delegate = agendaCollectionViewDD
        self.agendaList = datasource
        self.agendaCollectionView.reloadData()
    }
    
    
    @IBAction func hideNotify(_ sender: Any) {
        viewModel.hideNofity(clienteId: appDelegate.usuario.clienteId, notifySelectId: notifySelectId)
    }
    
    func showViewOption(posX:CGFloat, posY:CGFloat,notifySelectID: String,position:Int){
        self.notifyView.alpha = 1
        self.notifyView.isUserInteractionEnabled = true
        self.notifySelectId = notifySelectID
        self.position = position
        self.btnHideNotification.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self.btnHideNotification.titleLabel?.font.pointSize)!)
        
        self.btnHideNotification.frame = CGRect(x: posX - self.btnHideNotification.frame.width, y: posY - self.btnHideNotification.frame.height, width: self.btnHideNotification.frame.width, height: self.btnHideNotification.frame.height)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideNotifyView(sender:)))
        notifyView.isUserInteractionEnabled = true
        notifyView.addGestureRecognizer(tap)
        
    }
    
    @objc func hideNotifyView( sender: UITapGestureRecognizer){
        self.notifyView.alpha = 0
        self.notifyView.isUserInteractionEnabled = false
    }
    
    func successHideNotify(){
        self.notifyView.alpha = 0
        self.notifyView.isUserInteractionEnabled = false
        self.agendaCollectionViewDD.items.remove(at: position)
        self.agendaCollectionView.reloadData()
        self.position = -1
        print("success hide notification")
        
    }
    
    func errorHideNotify(){
        self.notifyView.alpha = 0
        self.notifyView.isUserInteractionEnabled = false
        print("error hide notification")
    }
    
}
