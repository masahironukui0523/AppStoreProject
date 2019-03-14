//
//  DetailsController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/13.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppDetailsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "gasgakjlghagj"
    fileprivate let prevCellId = "prevnsaghaogn"
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (res: SearchResult?, err) in
                if let err = err {
                    print("Failed to fetch data: ", err)
                    return
                }
                let app = res?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    
    var label = UILabel()
    
    var apiUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: prevCellId)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        
        if indexPath.item == 0 {
            
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: width, height: 1000))
            
            return CGSize(width: width, height: estimatedSize.height)
            
        } else {
            return CGSize(width: width, height: 500)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prevCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.app = app
            return cell
        }
        
    }
    
}
