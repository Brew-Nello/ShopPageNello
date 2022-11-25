//
//  HomeView.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/22.
//

import UIKit

/// 홈 화면
final class HomeView: UIView {
    
    // MARK: - UI
    
    let collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumInteritemSpacing = spacing
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        registerCell()
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure() {
        backgroundColor = .white
    }
    
    
    // MARK: - Actions
    func registerCell() {
        collectionView.register(HomeBannerViewCell.self, forCellWithReuseIdentifier: HomeBannerViewCell.identifier)
        collectionView.register(HomeItemViewCell.self, forCellWithReuseIdentifier: HomeItemViewCell.identifier)
    }
    
    // MARK: - Layouts
    func addSubviews() {
        addSubview(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

