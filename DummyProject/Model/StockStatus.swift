//
//  StockStatus.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

import UIKit

enum StockStatus: String {
    case inStock = "in stock"
    case low = "low"
    case outOfStock = "out of stock"
}

extension StockStatus {
    init(from value: String) {
        self = StockStatus(rawValue: value.lowercased()) ?? .outOfStock
    }
}

extension StockStatus {
    var color: UIColor {
        switch self {
        case .inStock:
            return .systemGreen
        case .low:
            return .systemOrange
        case .outOfStock:
            return .systemGray
        }
    }

    var displayText: String {
        switch self {
        case .inStock:
            return "In stock"
        case .low:
            return "Low stock"
        case .outOfStock:
            return "Out of stock"
        }
    }
}
