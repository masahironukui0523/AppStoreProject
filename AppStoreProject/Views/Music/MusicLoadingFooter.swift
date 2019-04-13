//
//  MusicLoadingFooter.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/04/13.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        let stackView = VerticalStackView(arrangeSubviews: [
            aiv, label
            ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
