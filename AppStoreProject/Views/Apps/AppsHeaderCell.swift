//
//  AppHeaderCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/10.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    var headerItem: SocialItem? {
        didSet {
            self.companyLabel.text = headerItem?.name
            self.titleLabel.text = headerItem?.tagline
            guard let imageUrl = headerItem?.imageUrl else {
                print("Failed to get image")
                return
            }
            let url = URL(string: imageUrl)
            self.imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    var companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    var titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    var imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 2
        companyLabel.textColor = .blue
        
        let stackView = VerticalStackView(arrangeSubviews: [
            companyLabel, titleLabel, imageView
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
