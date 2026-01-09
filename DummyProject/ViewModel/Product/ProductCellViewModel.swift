//
//  ProductCellViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 8.01.2026.
//

import UIKit

final class ProductCellViewModel {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var title: String {
        product.title
    }
    
    var priceText: String {
        "\(product.price) TL"
    }
    
    var stockText: String {
        "(\(product.stock) in stock)"
    }
    
    var discountText: String {
        "\(product.discountPercentage) % off"
    }
    
    var isStockText: String {
        product.availabilityStatus
    }
    
    var stockStatus: StockStatus {
        StockStatus(from: product.availabilityStatus)
    }
    
    var stockColor: UIColor {
        stockStatus.color
    }
    
    var imageURL: String? {
        product.images.first
    }
    
    var rating: Double? {
        product.rating
    }
}
