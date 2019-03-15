//
//  ReviewCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/14.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    var review: Entry! {
        didSet {
            self.titleLabel.text = review.title.label
            self.authorLabal.text = review.author.name.label
            self.bodyLabel.text = review.content.label
            
            for (index, view) in self.starsStackView.arrangedSubviews.enumerated() {
                if let rating = Int(review.rating.label) {
                    if index >= rating {
                        view.alpha = 0
                    } else {
                        view.alpha = 1
                    }
                }
            }
        }
    }
    
    var titleLabel = UILabel(text: "Review's title", font: .boldSystemFont(ofSize: 16))
    
    var authorLabal = UILabel(text: "Author", font: .systemFont(ofSize: 14))
    
    var starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        }
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    var bodyLabel = UILabel(text: "Review body", font: .systemFont(ofSize: 14), numberOfLines: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9357684255, green: 0.9302055836, blue: 0.9400444627, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
                
        let stackView = VerticalStackView(arrangeSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel, UIView(), authorLabal
                ], customSpacing: 8),
            starsStackView,
            bodyLabel
            ], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabal.textAlignment = .right
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
