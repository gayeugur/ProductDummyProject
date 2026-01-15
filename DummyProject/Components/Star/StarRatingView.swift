//
//  StarRatingView.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

import UIKit

final class StarRatingView: UIView {
    
    // MARK: - ıboutlet
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private var starImageViews: [UIImageView]!
    
    // MARK: - properties
    private let filledImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
    private let halfImage = UIImage(systemName: "star.lefthalf.fill")?.withRenderingMode(.alwaysTemplate)
    private let emptyImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
    
    // MARK: - ınıt
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - functıons
    private func commonInit() {
        let nib = UINib(nibName: "StarRatingView", bundle: .main)
        nib.instantiate(withOwner: self)
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        starImageViews.forEach {
            $0.tintColor = .systemYellow
        }
    }
    
    func configure(with viewModel: StarRatingViewModel) {
        for (index, state) in viewModel.stars.enumerated() {
            let imageView = starImageViews[index]
            
            switch state {
            case .filled:
                imageView.image = filledImage
            case .half:
                imageView.image = halfImage
            case .empty:
                imageView.image = emptyImage
            }
        }
    }
}
