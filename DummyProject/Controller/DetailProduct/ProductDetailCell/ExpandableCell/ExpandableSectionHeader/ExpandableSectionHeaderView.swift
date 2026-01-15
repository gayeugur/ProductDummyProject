//
//  ExpandableSectionHeaderView.swift
//  DummyProject
//
//  Created by gayeugur on 12.01.2026.
//

import UIKit

final class ExpandableSectionHeaderView: UICollectionReusableView {
    static let reuseId = "ExpandableSectionHeaderView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.image = UIImage(systemName: "chevron.down")
    }
    
    var tapAction: (() -> Void)?

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    @objc private func headerTapped() {
        tapAction?()
    }

    func configure(title: String, isExpanded: Bool) {
        titleLabel.text = title
        let iconName = isExpanded ? "chevron.down" : "chevron.right"
        iconImageView.image = UIImage(systemName: iconName)
    }
}

