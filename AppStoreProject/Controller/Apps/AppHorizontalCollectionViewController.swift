//
//  AppHorizontalControllerCollectionViewController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/06.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppHorizontalCollectionViewController: HolizontalSnappingController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "ghalhi"
    fileprivate let topBottomPadding: CGFloat = 12
    fileprivate let lineSpacing: CGFloat = 10
    var appGroup: AppGroup?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        
        cell.appRowItem = appGroup?.feed.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - topBottomPadding * 2 - lineSpacing * 2) / 3
        return CGSize(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
}
