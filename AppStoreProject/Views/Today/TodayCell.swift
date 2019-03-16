//
//  TodayCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/16.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
        imageView.contentMode = .scaleAspectFill
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
