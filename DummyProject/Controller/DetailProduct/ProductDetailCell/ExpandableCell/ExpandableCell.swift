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
        configureLayout()
        registerCells()
    }
    
    private func configureLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
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

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        onItemTapped = nil
        collectionView.isHidden = true
    }
}

extension ExpandableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ExpandableItemCell.reuseId,
            for: indexPath
        ) as? ExpandableItemCell,
              let item = viewModel?.items[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configure(with: item)
        return cell
    }
}

extension ExpandableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemTapped?()
    }
}

extension ExpandableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = viewModel?.items[indexPath.item] else {
            return CGSize(width: collectionView.bounds.width, height: 20)
        }
        
        let horizontalPadding: CGFloat = 16
        let verticalPadding: CGFloat = 4
        let minimumHeight: CGFloat = 20
        
        let width = collectionView.bounds.width
        let font = UIFont.systemFont(ofSize: 16)
        let textHeight = item.text.heightWithConstrainedWidth(
            width: width - horizontalPadding,
            font: font
        )
        let finalHeight = max(textHeight + verticalPadding, minimumHeight)
        return CGSize(width: width, height: finalHeight)
    }
}
