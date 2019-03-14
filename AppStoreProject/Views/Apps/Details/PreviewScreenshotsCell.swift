//
//  PreviewScreenshotsCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/14.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class PreviewScreenshotsCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(imageView)
        imageView.fillSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
