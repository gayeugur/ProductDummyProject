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
    @IBOutlet weak var starRatingView: StarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: ProductCellViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.priceText
        stockLabel.text = viewModel.stockText
        discountLabel.text = viewModel.discountText
        isStockLabel.text = viewModel.isStockText
        isStockLabel.textColor = viewModel.stockColor
        starRatingView.configure(rating: viewModel.rating ?? 0)
        
        guard let url = viewModel.imageURL else { return }
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            self?.iconImageView.image = image
        }
    }
}
