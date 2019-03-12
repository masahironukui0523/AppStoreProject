//
//  DetailsController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/13.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    var passedItem: FeedResult? {
        didSet {
            let label = UILabel(text: passedItem?.name ?? "", font: .systemFont(ofSize: 20))
            view.addSubview(label)
            label.fillSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
