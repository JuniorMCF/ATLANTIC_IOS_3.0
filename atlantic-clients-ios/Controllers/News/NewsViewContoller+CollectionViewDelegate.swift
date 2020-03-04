//
//  NewsPromotionsViewContoller+CollectionViewDelegate.swift
//  clients-ios
//
//  Created by Jhona on 7/28/19.
//  Copyright © 2019 Jhona Alca. All rights reserved.
//

import Foundation
import UIKit

extension NewsViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if promotionsCollectionView == scrollView {
            if (scrollView.tag == 0) {
                let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
                if let ip = self.promotionsCollectionView.indexPathForItem(at: center) {
                    self.promotionsPageControl.currentPage = ip.row
                }
            }
        }
    }
}
