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
    
    let items: [TodayItem] = [
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "description: All the tools and apps you need to intelligently organize your life the right way.", backGroundColor: .white),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on aBudget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everithing!", backGroundColor: #colorLiteral(red: 1, green: 0.9959574342, blue: 0.8265045285, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = #colorLiteral(red: 0.9654570222, green: 0.9597174525, blue: 0.9698687196, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    var appFullscreenController: AppFullscreenController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint:  NSLayoutConstraint?
    var widthConstraint:  NSLayoutConstraint?
    var heightConstraint:  NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.item]
        appFullscreenController.dismissHandler = {
            self.handleRemove()
            
        }
        
        let fullScreenView = appFullscreenController.view!
        fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemove)))
            
        view.addSubview(fullScreenView)
        addChild(appFullscreenController)
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        // expand view as much as cell size.
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        fullScreenView.frame = startingFrame
        fullScreenView.layer.cornerRadius = 16
        self.startingFrame = startingFrame
        
        self.collectionView.isUserInteractionEnabled = false
        
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            fullScreenView.frame = self.view.frame
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded() // starts animation
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    var startingFrame: CGRect?
    
    @objc func handleRemove(gesture: UITapGestureRecognizer = UITapGestureRecognizer() ) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero
            
            guard let staringFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = staringFrame.origin.y
            self.leadingConstraint?.constant = staringFrame.origin.x
            self.widthConstraint?.constant = staringFrame.width
            self.heightConstraint?.constant = staringFrame.height
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 24
            cell.layoutIfNeeded()
        }) { _ in
            gesture.view?.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
            self.appFullscreenController.view.removeFromSuperview()
            self.collectionView.isUserInteractionEnabled = true
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        let item = items[indexPath.item]
        cell.todayItem = item
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
