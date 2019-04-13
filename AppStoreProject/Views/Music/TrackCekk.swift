//
//  TrackCekk.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/04/13.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    var imageView = UIImageView(cornerRadius: 16)
    var nameLabel = UILabel(text: "Track Name", font: .boldSystemFont(ofSize: 18))
    var subtitleLable = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constrainWidth(constant: 80)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangeSubviews: [
                nameLabel,
                subtitleLable
                ], spacing: 4)
            ], customSpacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
