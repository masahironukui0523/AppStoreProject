//
//  TodayMultipleAppsController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/30.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "todaymultidgashio"
    fileprivate let spacing: CGFloat = 16
    
    var items: [FeedResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
        
        Service.shared.fetchGames(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: { (apps, err) in
            self.items = apps?.feed.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, items?.count ?? 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.appRowItem = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 3 * spacing) / 4
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
}
