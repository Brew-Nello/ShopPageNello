//
//  HomeBannerViewCell.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/23.
//

import UIKit
import SnapKit

/// 배너 이미지 CollectionView을 포함하는 Cell
final class HomeBannerViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier: String = String(describing: HomeBannerViewCell.self)
    private var currentCount = 1
    // MARK: - UI
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.size.width
        let height = width / 1.42
        layout.itemSize = CGSize(width: width, height: height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    private lazy var bannerCountBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let bannerCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        registerCell()
        addSubviews()
        setLayout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    private func registerCell() {
        collectionView.register(HomeBannerImageViewCell.self, forCellWithReuseIdentifier: HomeBannerImageViewCell.identifier)
    }
    
    func setData(_ data: [BannerVO]) {
        bannerCountLabel.text = "\(currentCount)/\(data.count)"
    }
    
    // MARK: - Set Layout
    
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(bannerCountBackgroundView)
        bannerCountBackgroundView.addSubview(bannerCountLabel)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerCountBackgroundView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(40)
            $0.height.equalTo(24)
        }
        
        bannerCountLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
