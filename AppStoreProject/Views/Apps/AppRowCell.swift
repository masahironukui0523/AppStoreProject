//
//  AppRowCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/07.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit
import SDWebImage

class AppRowCell: UICollectionViewCell {
    
    var appRowItem: FeedResult? {
        didSet {
            self.nameLabel.text = appRowItem?.name
            self.companyLabel.text = appRowItem?.artistName
            guard let urlString = appRowItem?.artworkUrl100 else { return }
            let url = URL(string: urlString)
            self.imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    let imageView = UIImageView(cornerRadius: 8)
    var nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
    var companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = #colorLiteral(red: 0.9725088477, green: 0.9667271972, blue: 0.9769527316, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32/2
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        let infoStack = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
        infoStack.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView ,infoStack, getButton
            ])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
