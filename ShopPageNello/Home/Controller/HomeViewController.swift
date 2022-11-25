//
//  HomeViewController.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/22.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

/// 홈 화면
final class HomeViewController: UIViewController {
    // MARK: - Properties
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    var homeData: HomeModel?
    var goodList = [GoodVO]()
    
    // MARK: - UI
    fileprivate let homeView = HomeView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
        setBinding()
        viewModel.initialization()
        viewModel.pagination(lastId: 10)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Configure
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
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    func configureCollectionView() {
        homeView.collectionView.delegate = self
        // homeView.collectionView.dataSource = self
    }
    
    // MARK: - Set Binding
    private func setBinding() {
        viewModel.homeDataObservable
            .asObserver()
            .subscribe(onNext: { [weak self] model in
                self?.initialization(model)
            }).disposed(by: disposeBag)
        
        viewModel.pageDataObservable
            .asObserver()
            .subscribe(onNext: { [weak self] model in
                self?.loadNextPage(model)
            }).disposed(by: disposeBag)
        
        viewModel.goodDataListObservable
            .bind(to: homeView.collectionView.rx.items(cellIdentifier: HomeItemViewCell.identifier, cellType: HomeItemViewCell.self)) { [weak self] index, item, cell in
                cell.setData(item)
            }.disposed(by: disposeBag)
        
        
    }
    
    // MARK: - Actions
    private func initialization(_ model: HomeModel) {
        homeData = model
        goodList = model.goods
        viewModel.goodDataListObservable.onNext(goodList)
        print(goodList)
    }
    
    private func loadNextPage(_ model: PageModel) {
        goodList += model.goods
        viewModel.goodDataListObservable.onNext(goodList)
        print(goodList)
    }
    
    
    
}


// MARK: - Extensions
// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeView.collectionView {
            let cellWidth: CGFloat = UIScreen.main.bounds.size.width
            let cellHeight: CGFloat = 44 + 40 // 높이: 44, bottom: 40
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        return CGSize.zero
        
    }
}
