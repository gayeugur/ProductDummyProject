//
//  ExpandableCell.swift
//  DummyProject
//
//  Created by gayeugur on 11.01.2026.
//

import UIKit

final class ExpandableCell: UICollectionViewCell {
    
    // MARK: - ıboutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - propertıes
    static let reuseId = "ExpandableCell"
    private var viewModel: ExpandableSectionViewModel?
    var onItemTapped: (() -> Void)?
    
    // MARK: - ınıt
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        onItemTapped = nil
        collectionView.isHidden = true
    }
    
    // MARK: - functıons
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(
            UINib(nibName: "ExpandableItemCell", bundle: nil),
            forCellWithReuseIdentifier: ExpandableItemCell.reuseId
        )
    }
    
    func configure(with viewModel: ExpandableSectionViewModel) {
        self.viewModel = viewModel
        collectionView.isHidden = !viewModel.isExpanded
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource
extension ExpandableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ExpandableItemCell.reuseId,
            for: indexPath
        ) as? ExpandableItemCell,
              let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        let item = viewModel.item(at: indexPath.item)
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ExpandableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemTapped?()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExpandableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else {
            return CGSize(width: collectionView.bounds.width, height: 20)
        }
        
        let width = collectionView.bounds.width
        let height = viewModel.itemHeight(at: indexPath.item, width: width)
        return CGSize(width: width, height: height)
    }
}
