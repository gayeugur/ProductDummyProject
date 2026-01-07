//
//  ProductCollectionViewCell.swift
//  DummyProject
//
//  Created by gayeugur on 7.01.2026.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIStackView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var stockLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var isStockLabel: UILabel!
    
    var product: Product? {
        didSet  {
            configure()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configure() {
        guard let product else { return }
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) TL"
        stockLabel.text = "\(product.stock) in stock"
        discountLabel.text = "\(product.discountPercentage) % off"
        isStockLabel.text = product.stock > 0 ? "In Stock" : "Sold Out"
    }
    
}
