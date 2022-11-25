//
//  LikeView.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/25.
//

import UIKit

/// 찜 화면 View
final class LikeView: UIView {
    // MARK: - UI
    let collectionView: UICollectionView = {
        
        let width = UIScreen.main.bounds.size.width
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(width / 1.42)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
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
        collectionView.register(LikeGoodViewCell.self, forCellWithReuseIdentifier: LikeGoodViewCell.identifier)
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


