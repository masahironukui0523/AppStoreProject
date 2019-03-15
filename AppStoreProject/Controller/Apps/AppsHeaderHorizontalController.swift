//
//  AppsHeaderHorizontalController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/10.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HolizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "agblkdashfa"
    
    // if using constant(let), error happens because it cannot be assigned value again.
    var socialItems: [SocialItem]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialItems?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
        cell.headerItem = socialItems?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 48
        let height = view.frame.height
        return CGSize(width: width, height: height)
    }
    
}
