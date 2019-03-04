//
//  AppSearchController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/02/27.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class AppSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "asghaligha"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchITunesApps()
        
    }
    
    fileprivate var appResults = [Result]()
    
    fileprivate func fetchITunesApps() {
        Service.shared.fetchApps { (result, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            self.appResults = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            print("Finished fetching data")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let appResult = appResults[indexPath.item]
        cell.nameLabel.text =  appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: " + String(appResult.averageUserRating ?? 0)
        
        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

