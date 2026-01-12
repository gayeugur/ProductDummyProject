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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let tapView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        // Başlık
        contentView.addSubview(titleLabel)
        tapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tapView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),
            tapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tapView.heightAnchor.constraint(equalToConstant: 44)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        tapView.addGestureRecognizer(tap)
        tapView.isUserInteractionEnabled = true

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
        titleLabel.text = viewModel.title
        collectionView.reloadData()
        updateHeight(animated: false)
        // collectionView.isHidden = !viewModel.isExpanded // kaldırıldı, yükseklik ile kontrol edilecek
    }

    private func updateHeight(animated: Bool) {
        guard let viewModel else { return }
        collectionView.layoutIfNeeded()
        let minHeight: CGFloat = 1 // Başlık için min yükseklik, 0 olursa tüm hücre kaybolur
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
        titleLabel.text = nil
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
