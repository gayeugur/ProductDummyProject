//
//  ExpandableCell.swift
//  DummyProject
//
//  Created by gayeugur on 11.01.2026.
//

import UIKit

final class ExpandableCell: UICollectionViewCell {

    static let reuseId = "ExpandableCell"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    private var viewModel: ExpandableSectionViewModel?
    var onItemTapped: (() -> Void)?

    private let tapView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(
            UINib(nibName: "ExpandableItemCell", bundle: nil),
            forCellWithReuseIdentifier: ExpandableItemCell.reuseId
        )
    }

    func configure(with viewModel: ExpandableSectionViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
        updateHeight(animated: false)
    }

    private func updateHeight(animated: Bool) {
        guard let viewModel else { return }
        collectionView.layoutIfNeeded()
        let minHeight: CGFloat = 1 // Sadece içerik için min yükseklik
        let targetHeight: CGFloat = viewModel.isExpanded
            ? collectionView.collectionViewLayout.collectionViewContentSize.height
            : minHeight
        collectionViewHeightConstraint.constant = targetHeight
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        }
    }

    @objc private func headerTapped() {
        onItemTapped?()
    }

    func toggleExpansion() {
        updateHeight(animated: true)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        onItemTapped = nil
        collectionViewHeightConstraint.constant = 0
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
