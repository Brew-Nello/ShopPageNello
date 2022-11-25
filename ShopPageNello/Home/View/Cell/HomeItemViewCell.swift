//
//  HomeItemViewCell.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/23.
//

import UIKit

/// 상품 아이템
final class HomeItemViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier: String = String(describing: HomeItemViewCell.self)
    
    // MARK: - UI
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "아이디"
        return textField
    }()
    
    let idTextFieldLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var termCheckButton: UIButton = {
        let checked_normal = UIImage(systemName: "person.circle.fill")!
        let unchecked_normal = UIImage(systemName: "person.circle.fill")!
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(unchecked_normal, for: .normal)
        button.setImage(checked_normal, for: .selected)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .yellow
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
    
    // MARK: - Actions
    func setData(_ data: GoodVO) {
        print(data)
    }
}
