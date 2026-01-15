//
//  ExpandableItemCell.swift
//  DummyProject
//
//  Created by gayeugur on 12.01.2026.
//

import UIKit

class ExpandableItemCell: UICollectionViewCell {
    
    static let reuseId = "ExpandableItemCell"
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
    }
    
    func configure(with item: ExpandableItem) {
        textLabel.text = item.text
        print("🟣 ExpandableItemCell configured with text: \(item.text.prefix(50))")
    }
}
