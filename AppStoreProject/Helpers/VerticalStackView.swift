//
//  VerticalStackView.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/04.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangeSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangeSubviews.forEach {(addArrangedSubview($0))}
        self.axis = .vertical
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
