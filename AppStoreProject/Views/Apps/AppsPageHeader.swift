//
//  AppsPageHeader.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/10.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let appsHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appsHeaderHorizontalController.view)
        appsHeaderHorizontalController.view.fillSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
