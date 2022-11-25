//
//  HomeBannerImageViewCell.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/25.
//

import UIKit
import SnapKit

/// 배너 이미지 Cell
final class HomeBannerImageViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier: String = String(describing: HomeBannerImageViewCell.self)
    private var data: BannerVO?
    // MARK: - UI
    private let bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    func setData(_ data: BannerVO) {
        self.data = data
        bannerImage.sd_setImage(with: URL(string: data.image))
    }
    
    // MARK: - Set Layout
    
    private func addSubviews() {
        contentView.addSubview(bannerImage)
    }
    
    private func setLayout() {
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
