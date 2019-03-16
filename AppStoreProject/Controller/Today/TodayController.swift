//
//  TodayController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/16.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "todayahksdho"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = #colorLiteral(red: 0.9654570222, green: 0.9597174525, blue: 0.9698687196, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        let redView = appFullscreenController.view!
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
            
        view.addSubview(redView)
        addChild(appFullscreenController)
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        // expand view as much as cell size.
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        redView.frame = startingFrame
        redView.layer.cornerRadius = 18
        self.startingFrame = startingFrame
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            redView.frame = self.view.frame
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
        
    }
    
    var startingFrame: CGRect?
    
    @objc func handleRemoveRedView(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            gesture.view?.frame = self.startingFrame ?? .zero
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { _ in
            gesture.view?.removeFromSuperview()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - 64
        return .init(width: width, height: 450)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
}
