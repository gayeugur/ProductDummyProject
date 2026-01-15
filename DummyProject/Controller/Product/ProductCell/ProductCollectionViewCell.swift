//
//  ProductCollectionViewCell.swift
//  DummyProject
//
//  Created by gayeugur on 7.01.2026.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - properties
    static let reuseId = "ProductCollectionViewCell"
    
    // MARK: - ıboutlet
    @IBOutlet private weak var containerView: UIStackView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var stockLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var isStockLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - properties
    func configure(with viewModel: ProductCellViewModel, isHiddenImage: Bool = false) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.priceText
        stockLabel.text = viewModel.stockText
        discountLabel.text = viewModel.discountText
        isStockLabel.text = viewModel.isStockText
        isStockLabel.textColor = viewModel.stockStatus.color
        starRatingView.configure(with: viewModel.starRatingViewModel)
        iconImageView.isHidden = isHiddenImage
        
        guard let url = viewModel.imageURL, !isHiddenImage else { return }
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            self?.iconImageView.image = image
        }
    }
}
