//
//  TabBarViewController.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.point_color], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.point_color], for: .normal)
        
        tabBar.tintColor = Colors.point_color
        
        let homeVC = HomeViewController()
        let likeVC = LikeViewController()
        
        self.delegate = self
        
        navigationItem.title = "홈"

        let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house")?.withTintColor(.red), selectedImage: UIImage(systemName: "house.fill"))
        let likeTabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        homeVC.tabBarItem = homeTabBarItem
        likeVC.tabBarItem = likeTabBarItem
        
        viewControllers = [homeVC, likeVC]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HomeViewController {
            navigationItem.title = "홈"
        }
        
        if viewController is LikeViewController {
            navigationItem.title = "좋아요"
        }
    }
}
