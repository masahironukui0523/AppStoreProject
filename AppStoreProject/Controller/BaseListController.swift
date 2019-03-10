//
//  BaseListController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/06.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
