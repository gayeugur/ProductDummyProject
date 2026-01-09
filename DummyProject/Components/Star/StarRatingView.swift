//
//  StarRatingView.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

import UIKit

final class StarRatingView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet private var starImageViews: [UIImageView]!

    private let filledImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
    private let halfImage = UIImage(systemName: "star.lefthalf.fill")?.withRenderingMode(.alwaysTemplate)
    private let emptyImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let nib = UINib(nibName: "StarRatingView", bundle: .main)
        nib.instantiate(withOwner: self)
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        starImageViews.forEach {
            $0.tintColor = .systemYellow
        }
    }

    // MARK: - Public API

    func configure(rating: Double, maxStars: Int = 5) {
        let filledStars = Int(rating)
        let hasHalfStar = (rating - Double(filledStars)) >= 0.5

        for index in 0..<maxStars {
            let imageView = starImageViews[index]

            if index < filledStars {
                imageView.image = filledImage
            } else if index == filledStars && hasHalfStar {
                imageView.image = halfImage
            } else {
                imageView.image = emptyImage
            }
        }
    }
    
    func configure(rating: Int) {
        configure(rating: Double(rating))
    }
}
