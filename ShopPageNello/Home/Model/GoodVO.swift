//
//  GoodData.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/24.
//

import Foundation

struct GoodVO: Codable {
    var id: Int
    var name: String
    var image: String
    var actual_price: Int
    var price: Int
    var is_new: Bool
    var sell_count: Int
}
