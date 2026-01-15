//
//  ExpandableSectionViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 11.01.2026.
//

import UIKit

final class ExpandableSectionViewModel {
    
    let title: String
    let items: [ExpandableItem]
    var isExpanded: Bool
    
    init(title: String,
         items: [ExpandableItem],
         isExpanded: Bool = false) {
        self.title = title
        self.items = items
        self.isExpanded = isExpanded
    }
    
    // MARK: - Data Source Methods
    var numberOfItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> ExpandableItem {
        return items[index]
    }
    
    func itemHeight(at index: Int, width: CGFloat) -> CGFloat {
        let item = items[index]
        let horizontalPadding: CGFloat = 16
        let verticalPadding: CGFloat = 4
        let minimumHeight: CGFloat = 20
        
        let font = UIFont.systemFont(ofSize: 16)
        let textHeight = item.text.heightWithConstrainedWidth(
            width: width - horizontalPadding,
            font: font
        )
        return max(textHeight + verticalPadding, minimumHeight)
    }
    
    func expandedHeight(for width: CGFloat) -> CGFloat {

          let cardPadding: CGFloat = 16
          let labelPadding: CGFloat = 16
          let itemVerticalPadding: CGFloat = 4
          let itemSpacing: CGFloat = 2
          let collectionViewPadding: CGFloat = 8
          let minimumItemHeight: CGFloat = 20
          let minimumTotalHeight: CGFloat = 50

          let labelWidth = width - cardPadding - labelPadding
          let font = UIFont.systemFont(ofSize: 16)

          var totalHeight: CGFloat = items.reduce(0) { height, item in
              let textHeight = item.text.heightWithConstrainedWidth(
                  width: labelWidth,
                  font: font
              )
              return height + max(textHeight + itemVerticalPadding, minimumItemHeight)
          }

          if items.count > 1 {
              totalHeight += CGFloat(items.count - 1) * itemSpacing
          }

          totalHeight += collectionViewPadding
          return max(totalHeight, minimumTotalHeight)
      }
    
}

struct ExpandableItem {
    let icon: UIImage?
    let text: String
}
