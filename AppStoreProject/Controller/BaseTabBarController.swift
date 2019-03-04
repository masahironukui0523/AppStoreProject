//
//  BaseTabBarController.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/02/27.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayVC = createNavController(rootViewController: UIViewController(), title: "Today", image: #imageLiteral(resourceName: "today_icon"))
        let appVC = createNavController(rootViewController: UIViewController(), title: "Apps", image: #imageLiteral(resourceName: "apps"))
        let searchVC = createNavController(rootViewController: AppSearchController(), title: "Search", image: #imageLiteral(resourceName: "search"))
        
        viewControllers = [
            todayVC,
            appVC,
            searchVC
        ]
                
        self.selectedViewController = searchVC
        
    }
    
    private func createNavController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let rootVC = rootViewController
        rootVC.view.backgroundColor = .white
        let navC = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.title = title
        navC.tabBarItem.image = image
        navC.navigationBar.prefersLargeTitles = true
        
        return navC
        
    }
    
}
