//
//  Int+.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/25.
//

import Foundation

// MARK: - 숫자 단위(,) 표시
extension Int {
    func toPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let priceString = numberFormatter.string(from: NSNumber(value: self)) else { return "" }
        return priceString
    }
}
