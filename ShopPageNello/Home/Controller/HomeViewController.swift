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

/// 홈 화면 Controller
final class HomeViewController: UIViewController {
    // MARK: - Properties
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    var goodList = [GoodVO]()
    var likeList = [GoodVO]()
    var bannerList = [BannerVO]()
    var homeBannerViewCell: HomeBannerViewCell?
    
    var bannerCollectionView: UICollectionView?
    
    
    // MARK: - UI
    private let homeView = HomeView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

        setBinding()
        
        viewModel.initialization()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Configure
    func configureCollectionView() {
        homeView.collectionView.dataSource = self

        refreshControl.tintColor = Colors.text_secondary
        refreshControl.addTarget(self, action: #selector(loadNextPage), for: .valueChanged)
        homeView.collectionView.alwaysBounceVertical = true
        homeView.collectionView.refreshControl = refreshControl
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
                self?.setNextPage(model)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    private func initialization(_ model: HomeModel) {
        if let data = SaveManager.loadObject(key: SaveManagerKey.likes) {
            if let likeList = try? PropertyListDecoder().decode([GoodVO].self, from: data) {
                self.likeList = likeList
            }
        }
        goodList = model.goods.sorted(by: { $0.id > $1.id })
        bannerList = model.banners
        homeView.collectionView.reloadData()
        bannerCollectionView?.reloadData()
    }
    
    private func setNextPage(_ model: PageModel) {
        goodList = model.goods.sorted(by: { $0.id > $1.id }) + goodList
        homeView.collectionView.reloadData()
        stopRefresher()
    }
    
    @objc func loadNextPage() {
        homeView.collectionView.refreshControl?.beginRefreshing()
        if let id = goodList.first?.id {
            viewModel.pagination(lastId: id)
        }
    }
    
    func stopRefresher() {
        homeView.collectionView.refreshControl?.endRefreshing()
    }
    
}

// MARK: - Extensions
// MARK: - HomeGoodViewCellDelegate
extension HomeViewController: HomeGoodViewCellDelegate {
    func selectLike(data: GoodVO) {
        likeList.insert(data, at: 0)
        SaveManager.saveObject(object: likeList, key: SaveManagerKey.likes)
    }
    
    func deSelectLike(data: GoodVO) {
        if let index = likeList.firstIndex(where: { $0.id == data.id }) {
            likeList.remove(at: index)
            SaveManager.saveObject(object: likeList, key: SaveManagerKey.likes)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.collectionView {
            return goodList.count + 1 // 배너 셀 1개 포함
        }
        
        if collectionView == bannerCollectionView {
            return bannerList.count
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.collectionView {
            if indexPath.row == 0 {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerViewCell.identifier, for: indexPath) as? HomeBannerViewCell {
                    cell.collectionView.dataSource = self
                    cell.collectionView.delegate = self
                    cell.setData(bannerList)
                    homeBannerViewCell = cell
                    bannerCollectionView = cell.collectionView
                    
                    return cell
                }
            } else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGoodViewCell.identifier, for: indexPath) as? HomeGoodViewCell {
                    let data = goodList[indexPath.row - 1]
                    cell.likeButton.isSelected = likeList.contains(where: { $0.id == data.id })
                    cell.setData(data)
                    cell.delgate = self
                    return cell
                }
            }
        }
        
        if collectionView == bannerCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerImageViewCell.identifier, for: indexPath) as? HomeBannerImageViewCell {
                cell.setData(bannerList[indexPath.row])
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let width = scrollView.bounds.size.width
        let currentPage = Int(ceil(x / width)) + 1
        homeBannerViewCell?.bannerCountLabel.text = "\(currentPage)/\(bannerList.count)"
    }
}

