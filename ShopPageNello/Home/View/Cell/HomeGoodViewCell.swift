//
//  HomeItemViewCell.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/23.
//

import UIKit
import SnapKit
import SDWebImage
import RxSwift
import RxCocoa

protocol HomeGoodViewCellDelegate {
    func selectLike(data: GoodVO)
    func deSelectLike(data: GoodVO)
}
/// 상품 아이템 Cell
final class HomeGoodViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier: String = String(describing: HomeGoodViewCell.self)
    private var data: GoodVO?
    private let disposeBag = DisposeBag()
    var delgate: HomeGoodViewCellDelegate?
    // MARK: - UI
    /// 썸네일 이미지
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 찜 버튼
    let likeButton: UIButton = {
        let normal = UIImage(systemName: "heart")!
        let selected = UIImage(systemName: "heart.fill")!
        let button = UIButton()
        button.tintColor = Colors.point_color
        button.setImage(normal, for: .normal)
        button.setImage(selected, for: .selected)
        return button
    }()
    
    /// 할인율
    private let salePercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.point_color
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    /// 가격
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.text_primary
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    /// 상품명
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.text_secondary
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    /// 구매중 갯수
    private let sellCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.text_secondary
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    /// NEW 뱃지
    private let newBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.textColor = Colors.text_secondary
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .center
        label.layer.borderColor = Colors.text_secondary.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    private let seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.seperate_color
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setBindingButton()
        addSubviews()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    func setData(_ data: GoodVO) {
        self.data = data
        thumbnailImageView.sd_setImage(with: URL(string: data.image))
        salePercentLabel.text = String(100 - (data.price * 100) / data.actual_price) + "%"
        priceLabel.text = data.price.toPrice()
        nameLabel.text = data.name
        newBadgeLabel.isHidden = !data.is_new
        if data.sell_count < 10 {
            sellCountLabel.text = data.sell_count.toPrice() + "개"
        } else {
            sellCountLabel.text = data.sell_count.toPrice() + "개 구매중"
        }
    }
    
    // MARK: - Set Binding
    private func setBindingButton() {
        likeButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.likeButton.isSelected.toggle()
            if
                let data = self?.data,
                let isSelected = self?.likeButton.isSelected {
                if isSelected {
                    self?.delgate?.selectLike(data: data)
                } else {
                    self?.delgate?.deSelectLike(data: data)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Set Layout
    private func addSubviews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(likeButton)
        
        contentView.addSubview(salePercentLabel)
        contentView.addSubview(priceLabel)
        
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(newBadgeLabel)
        bottomStackView.addArrangedSubview(sellCountLabel)
        
        contentView.addSubview(seperatorLineView)
    }
    
    private func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
            
            $0.width.height.equalTo(100)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top).inset(8)
            $0.trailing.equalTo(thumbnailImageView.snp.trailing).inset(8)
            
            $0.width.height.equalTo(20)
        }
        
        salePercentLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            
            $0.height.equalTo(24)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.top)
            $0.leading.equalTo(salePercentLabel.snp.trailing).offset(8)
            
            $0.height.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(salePercentLabel.snp.bottom).offset(4)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            
            $0.height.equalTo(20)
        }
        
        newBadgeLabel.snp.makeConstraints {
            $0.width.equalTo(32)
        }
        
        seperatorLineView.snp.makeConstraints {
            $0.top.equalTo(bottomStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-1)
            
            $0.height.equalTo(1)
        }
    }
}
