//
//  PreviewScreenshotsController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/14.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HolizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var app: Result? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let cellId = "aghlsgakhlghda"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PreviewScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height
        return CGSize(width: 250, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PreviewScreenshotsCell
        let screenshotUrl = self.app?.screenshotUrls[indexPath.item]
        let url = URL(string: screenshotUrl ?? "")
        cell.imageView.sd_setImage(with: url, completed: nil)
        return cell
    }
    
}
