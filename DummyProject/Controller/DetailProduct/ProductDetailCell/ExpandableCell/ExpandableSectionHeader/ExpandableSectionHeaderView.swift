//
//  ExpandableSectionHeaderView.swift
//  DummyProject
//
//  Created by gayeugur on 12.01.2026.
//

import UIKit

final class ExpandableSectionHeaderView: UICollectionReusableView {
    
    // MARK: - properties
    static let reuseId = "ExpandableSectionHeaderView"
    var tapAction: (() -> Void)?
    
    // MARK: - ıboutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - ınıt
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.image = UIImage(systemName: "chevron.down")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - functıons
    @objc private func headerTapped() {
        tapAction?()
    }
    
    func configure(title: String, isExpanded: Bool) {
        titleLabel.text = title
        let iconName = isExpanded ? "chevron.down" : "chevron.right"
        iconImageView.image = UIImage(systemName: iconName)
    }
}

