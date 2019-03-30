//
//  TodayMultipleAppCell.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/30.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text =  todayItem.title
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HAck", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    let multipleAppViewController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        multipleAppViewController.view.backgroundColor = .red
        layer.cornerRadius = 16
        let stackView = VerticalStackView(arrangeSubviews: [
            categoryLabel, titleLabel, multipleAppViewController.view
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
