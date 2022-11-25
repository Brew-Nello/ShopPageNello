//
//  LikeViewController.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/25.
//

import UIKit

/// 찜 화면 Controller
final class LikeViewController: UIViewController {
    // MARK: - Properties
    var likeList = [GoodVO]()
    
    // MARK: - UI
    private let likeView = LikeView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        initialization()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Configure
    func configureCollectionView() {
        likeView.collectionView.dataSource = self
    }
    
    
    // MARK: - Actions
    private func initialization() {
        if let data = SaveManager.loadObject(key: SaveManagerKey.likes) {
            if let likeList = try? PropertyListDecoder().decode([GoodVO].self, from: data) {
                self.likeList = likeList
                likeView.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Extensions
// MARK: - UICollectionViewDataSource
extension LikeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeGoodViewCell.identifier, for: indexPath) as? LikeGoodViewCell {
            let data = likeList[indexPath.row]
            cell.setData(data)
            return cell
        }
        
        return UICollectionViewCell()
    }
}
