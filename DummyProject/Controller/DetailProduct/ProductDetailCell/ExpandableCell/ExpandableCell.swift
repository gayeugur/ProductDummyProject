//
//  ExpandableCell.swift
//  DummyProject
//
//  Created by gayeugur on 11.01.2026.
//

import UIKit

final class ExpandableCell: UICollectionViewCell {

    static let reuseId = "ExpandableCell"

    @IBOutlet private weak var collectionView: UICollectionView!

    private var viewModel: ExpandableSectionViewModel?
    var onItemTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false

      
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 0
        }


        collectionView.register(
            UINib(nibName: "ExpandableItemCell", bundle: nil),
            forCellWithReuseIdentifier: ExpandableItemCell.reuseId
        )
    }

    func configure(with viewModel: ExpandableSectionViewModel) {
        self.viewModel = viewModel

        // 🔑 Expand / collapse kontrolü
        collectionView.isHidden = !viewModel.isExpanded

        collectionView.reloadData()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        onItemTapped = nil
        collectionView.isHidden = true
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {

        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(
            CGSize(
                width: layoutAttributes.frame.width,
                height: UIView.layoutFittingCompressedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        var frame = layoutAttributes.frame
        frame.size.height = size.height
        layoutAttributes.frame = frame

        return layoutAttributes
    }

}


extension ExpandableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpandableItemCell.reuseId,
                                                            for: indexPath) as? ExpandableItemCell else {
            return UICollectionViewCell()
        }
        guard let item = viewModel?.items[indexPath.item] else { return UICollectionViewCell() }
        cell.configure(with: item)
        return cell
    }
}

extension ExpandableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        onItemTapped?()
    }
    
}
