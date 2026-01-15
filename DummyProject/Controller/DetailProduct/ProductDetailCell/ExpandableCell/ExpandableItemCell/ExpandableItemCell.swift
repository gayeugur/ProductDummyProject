//
//  ExpandableItemCell.swift
//  DummyProject
//
//  Created by gayeugur on 12.01.2026.
//

import UIKit

class ExpandableItemCell: UICollectionViewCell {
    
    // MARK: - propertıes
    static let reuseId = "ExpandableItemCell"
    
    // MARK: - ıboutlet
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - ınıt
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - functıons
    func configure(with item: ExpandableItem) {
        textLabel.text = item.text
    }
}
