//
//  TodayController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/16.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {

    static let cellSize: CGFloat = 500
    
    var items = [TodayItem]()
    var gameApp: AppGroup?
    var grossingApp: AppGroup?
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    var dispatchGroupe = DispatchGroup()
    
    var appFullscreenController: AppFullscreenController!
    
    var anchoredConstraints: AnchoredConstraints?
    
    var startingFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()

        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        collectionView.backgroundColor = #colorLiteral(red: 0.9654570222, green: 0.9597174525, blue: 0.9698687196, alpha: 1)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    private func fetchData() {
        dispatchGroupe.enter()
        Service.shared.fetchGames(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: { (apps, err) in
            self.dispatchGroupe.leave()
            self.gameApp = apps
        })
        
        dispatchGroupe.enter()
        Service.shared.fetchGames(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json", completion: { (apps, err) in
            self.dispatchGroupe.leave()
            self.grossingApp = apps
        })
        
        dispatchGroupe.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            let grossingApps = self.grossingApp?.feed.results
            let gameApps = self.gameApp?.feed.results
            
            self.items = [
                TodayItem.init(category: "Daily List", title: self.gameApp?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backGroundColor: .white,cellType: .multiple, apps: grossingApps ?? []),
                TodayItem.init(category: "LIFE HACK", title: self.grossingApp?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "description: All the tools and apps you need to intelligently organize your life the right way.", backGroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: self.gameApp?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backGroundColor: .white,cellType: .multiple, apps: gameApps ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on aBudget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everithing!", backGroundColor: #colorLiteral(red: 1, green: 0.9959574342, blue: 0.8265045285, alpha: 1), cellType: .single, apps: [])
            ]
            self.loadViewIfNeeded()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullScreenController = TodayMultipleAppsController(mode: .fullscreen)
        fullScreenController.items = items[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullScreenController), animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullscreen(indexPath: indexPath)
        }
    }
    
    fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
        appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.item]
        appFullscreenController.dismissHandler = {
            self.handleRemove()
        }
        appFullscreenController.view.layer.cornerRadius = 16
    }
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        // expand view as much as cell size.
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupAppFullScreenStartingPosition(indexPath: IndexPath) {
        let fullScreenView = appFullscreenController.view!
        fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemove)))
        
        view.addSubview(fullScreenView)
        addChild(appFullscreenController)
        self.collectionView.isUserInteractionEnabled = false
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        self.anchoredConstraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        view.layoutIfNeeded()
    }
    
    fileprivate func beginAnimationAppFullscreen(indexPath: IndexPath) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            self.view.layoutIfNeeded() // starts animation
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullscreen(indexPath: IndexPath) {
        setupSingleAppFullScreenController(indexPath)
        
        setupAppFullScreenStartingPosition(indexPath: indexPath)
        
        beginAnimationAppFullscreen(indexPath: indexPath)
    }
    
    @objc func handleRemove(gesture: UITapGestureRecognizer = UITapGestureRecognizer() ) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero
            
            guard let staringFrame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = staringFrame.origin.y
            self.anchoredConstraints?.leading?.constant = staringFrame.origin.x
            self.anchoredConstraints?.width?.constant = staringFrame.width
            self.anchoredConstraints?.height?.constant = staringFrame.height
            
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
        
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.todayMultipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handkeMurtipleAppsTap)))
        
        return cell
    }
    
    @objc func handkeMurtipleAppsTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        var superview = collectionView?.superview
        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.items[indexPath.item].apps
                let fullController = TodayMultipleAppsController(mode: .fullscreen)
                fullController.items = apps
                present(fullController, animated: true, completion: nil)
            }
            superview = superview?.superview
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - 64
        return .init(width: width, height: TodayController.cellSize)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
}
