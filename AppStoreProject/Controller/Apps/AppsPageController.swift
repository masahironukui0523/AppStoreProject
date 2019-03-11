//
//  AppController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/06.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "gaflghai"
    fileprivate let headerId = "ahgaiwpgh"
    fileprivate let apiUrls = [
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/50/explicit.json"
    ]
    fileprivate var appGroups = [AppGroup]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.backgroundColor = .white
        
        fetchData(urlStrings: apiUrls)

    }
    
    fileprivate func fetchData(urlStrings: [String]) {
        for urlString in urlStrings {
            Service.shared.fetchGames(urlString: urlString) { (data, err) in
                if let err = err {
                    print("Failed to fetch data:", err)
                    return
                }
                guard let data = data else { return }
                self.appGroups.append(data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        
        return CGSize(width: width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        let appGroup = appGroups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
        
}
