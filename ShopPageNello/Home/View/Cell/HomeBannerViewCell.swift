//
//  HomeBannerViewCell.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/23.
//

import UIKit
import SnapKit

/// 배너 이미지
final class HomeBannerViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: HomeBannerViewCell.self)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set Layout
    
    func addSubviews() {
        
    }
    
    func setLayout() {
        
    }
    
}
