//
//  HomeData.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/24.
//

import Foundation

struct HomeModel: Decodable {
    var banners: [BannerVO]
    var goods: [GoodVO]
}

