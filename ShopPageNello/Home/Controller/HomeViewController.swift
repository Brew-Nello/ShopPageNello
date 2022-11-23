//
//  HomeViewController.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/22.
//

import UIKit

/// 홈 화면
class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 네비게이션 바
    private func configureNavigationBar() {
        // 타이틀
        self.navigationItem.titleView = {
            let label = UILabel()
            label.text = "홈"
            label.textColor = .black
            label.font = .systemFont(ofSize: 16, weight: .bold)
            return label
        }()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        // // 스크롤할 때 배경 white로 고정
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
    }
    
    
}
