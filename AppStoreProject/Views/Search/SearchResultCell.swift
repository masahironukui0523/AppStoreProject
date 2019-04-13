//
//  SearchResultCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/02/28.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var appResult: Result! {
        didSet {
            nameLabel.text =  appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "Rating: " + String(appResult.averageUserRating ?? 0)
            
            let appIconUrl = URL(string: appResult.artworkUrl100)
            appIconImage.sd_setImage(with: appIconUrl)
            
            for (i, url) in (appResult.screenshotUrls?.enumerated())! {
                let screenshotImage = screenshotImages[i]
                screenshotImage.sd_setImage(with: URL(string: url), completed: nil)
                if i == 2 {
                    break
                }
            }
        }
    }
    
    let appIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "App Name"
        return nameLabel
    }()
    
    let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = "Photos & Video"
        return categoryLabel
    }()
    
    let ratingsLabel: UILabel = {
        let ratingsLabel = UILabel()
        ratingsLabel.text = "9.26M"
        return ratingsLabel
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8810923696, green: 0.8758550286, blue: 0.8851185441, alpha: 1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 13
        return button
    }()
    
    lazy var screenshotImages = [self.createScreenShotImageView(), self.createScreenShotImageView(), self.createScreenShotImageView()]
    
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStackView = VerticalStackView(arrangeSubviews: [
            nameLabel, categoryLabel, ratingsLabel
            ])
        
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImage,labelStackView, getButton
            ])
        
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [
            screenshotImages[0], screenshotImages[1], screenshotImages[2]
            ])
        
        screenShotsStackView.spacing = 16
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangeSubviews: [infoTopStackView, screenShotsStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
