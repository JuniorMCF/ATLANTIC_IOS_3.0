//
//  OnBoardingViewController.swift
//  clients-ios
//
//  Created by Jhona on 7/21/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imageNameArray = [String]()
    var titleArray = [String]()
    var containerParent : NewsViewController!
    var viewModel: OnBoardingViewModelProtocol! = OnBoardingViewModel()
    
    // MARK: - IBOulet
    
    @IBOutlet weak var skipButton: Button!
    @IBOutlet weak var onBoardingCollectioView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var encuesta = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {
        viewModel.showTitles = showTitles(titles:)
        viewModel.presentFotos = presentFotos(fotoList:encuesta:)
        viewModel.presentImages = presentImages(titles:)
    }
    
    func showTitles(titles: OnBoardingTitles) {
        skipButton.setSkipButton()
        //skipButton.setOnBoardButton(with: titles.skitTitle)
        //nextButton.setOnBoardButton(with: titles.nextTitle)
    }
    func presentImages(titles:[Route]){
        /*for data in titles{
            print(data.ruta)
            titleArray.append(data)
        }
        onBoardingCollectioView.reloadData()
        print("gaaa")*/
    }
    
    func presentFotos(fotoList:[String], encuesta : String){
        self.encuesta = encuesta
        for data in fotoList{
            titleArray.append(data)
        }
        onBoardingCollectioView.reloadData()
    }
   
    @IBAction func tapSkip(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        if(!encuesta.isEmpty){
            let terminos = Terminos(parent: containerParent, url: encuesta+"?cliente_id="+appDelegate.usuario.clienteId)
            terminos.encuesta = self.encuesta
            terminos.showTerms()
        }
        
        else{
            if(Constants().getFirstInit()){
                containerParent.showTutorial()
            }
        }
        
        
        
        
    }
    
    
    // MARK: - CollectinView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.pageControl.numberOfPages = self.titleArray.count
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? OnBoardingCollectionViewCell
        
        let dominio = "http://clienteatlantic.azurewebsites.net/admin/upload/imagen/"
        
        AF.request(dominio +  titleArray[indexPath.row]).responseImage { response in
                   
                       switch response.result {
                             case .success(let value):
                                cell?.onBoardingImage.image = value
                             case .failure(let error):
                                 print(error)
                                 
                             }

        }
        cell?.titleLabel.text = titleArray[indexPath.row]
        return cell!
    }
    
    // MARK: - CollectinView Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.tag == 0) {
            let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
            if let ip = self.onBoardingCollectioView.indexPathForItem(at: center) {
                self.pageControl.currentPage = ip.row
            }
        }
    }

}
