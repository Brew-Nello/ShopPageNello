//
//  HomeViewModel.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/24.
//

import Foundation
import Moya
import RxSwift

final class HomeViewModel {
    // MARK: - Properties
    let provider = MoyaProvider<HomeAPI>()
    var homeDataObservable = PublishSubject<HomeModel>()
    var pageDataObservable = PublishSubject<PageModel>()
    
    var goodDataListObservable = PublishSubject<[GoodVO]>()
    
    func initialization() {
        provider.request(.initialization) { result in
            switch result {
            case let .success(response):
                if let data = try? response.map(HomeModel.self) {
                    self.homeDataObservable.onNext(data)
                    self.homeDataObservable.onCompleted()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func pagination(lastId: Int) {
        provider.request(.pagination(lastId)) { result in
            switch result {
            case let .success(response):
                if let data = try? response.map(PageModel.self) {
                    self.pageDataObservable.onNext(data)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
