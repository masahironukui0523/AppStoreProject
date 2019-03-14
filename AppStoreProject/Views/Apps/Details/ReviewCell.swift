//
//  ReviewCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/14.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review's title", font: .boldSystemFont(ofSize: 16))
    
    let authorLabal = UILabel(text: "Author", font: .systemFont(ofSize: 14))
    
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    
    let bodyLabel = UILabel(text: "Review body", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9357684255, green: 0.9302055836, blue: 0.9400444627, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangeSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel, UIView(), authorLabal
                ], customSpacing: 8),
            starsLabel,
            bodyLabel
            ], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabal.textAlignment = .right
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
