//
//  AppGroupCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/06.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    var appGroup: AppGroup? {
        didSet {
            self.titleLabel.text = appGroup?.feed.title
            self.horizontalController.appGroup = appGroup
            self.horizontalController.collectionView.reloadData()
        }
    }
    
    let titleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
    
    let horizontalController = AppsHorizontalCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        horizontalController.collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
