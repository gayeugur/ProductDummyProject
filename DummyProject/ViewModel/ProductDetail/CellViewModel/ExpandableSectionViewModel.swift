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
}

struct ExpandableItem {
    let icon: UIImage?
    let text: String
}
