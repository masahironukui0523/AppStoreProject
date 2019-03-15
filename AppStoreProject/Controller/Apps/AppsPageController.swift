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
    
    fileprivate let activityIndecatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    fileprivate let apiUrls = [
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json",
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/50/explicit.json"
    ]
    
    fileprivate var appGroups = [AppGroup]()
    fileprivate var socialItems: [SocialItem]?
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.backgroundColor = .white
        view.addSubview(activityIndecatorView)
        activityIndecatorView.fillSuperview()
        fetchData(urlStrings: apiUrls)

    }
    
    fileprivate func fetchData(urlStrings: [String]) {
        for urlString in urlStrings {
            dispatchGroup.enter()
            Service.shared.fetchGames(urlString: urlString) { (data, err) in
                self.dispatchGroup.leave()
                if let err = err {
                    print("Failed to fetch data:", err)
                    return
                }
                guard let data = data else { return }
                self.appGroups.append(data)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (items, err) in
            self.dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch data: ", err)
                return
            }
            self.socialItems = items
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndecatorView.stopAnimating()
            self.collectionView.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appsHeaderHorizontalController.socialItems = self.socialItems
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
        cell.appGroup = appGroups[indexPath.item]
        cell.horizontalController.didSelectHandler = { [weak self] item in
            let vc = AppDetailsController()
            // 先にdidSetを使っている方に値を入れてしまうと他の値が渡される前にviewdidloatが呼ばれnilになってしまうため(addsubviewがあるため)、最後に渡す
            vc.appId = item.id
            vc.apiUrls = self?.apiUrls ?? ["something"]
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
        
}
