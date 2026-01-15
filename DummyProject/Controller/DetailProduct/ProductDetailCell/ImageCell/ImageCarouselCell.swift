//
//  ImageCarouselCell.swift
//  DummyProject
//
//  Created by gayeugur on 10.01.2026.
//

import UIKit

final class ImageCarouselCell: UICollectionViewCell {
    
    // MARK: - ıboutlet
    @IBOutlet weak var imagecollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - properties
    static let reuseId = "ImageCarouselCell"
    private var viewModel: ImageCarouselViewModel?
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - functions
    private func setup() {
        imagecollectionView.dataSource = self
        imagecollectionView.delegate = self
        imagecollectionView.showsHorizontalScrollIndicator = false
        imagecollectionView.register(
            UINib(nibName: "ImageItemCell", bundle: nil),
            forCellWithReuseIdentifier: ImageItemCell.reuseId
        )
    }
    
    func configure(with viewModel: ImageCarouselViewModel) {
        self.viewModel = viewModel
        pageControl.numberOfPages = viewModel.numberOfPages
        pageControl.currentPage = 0
        imagecollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ImageCarouselCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageItemCell.reuseId,
            for: indexPath) as? ImageItemCell,
              let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        
        let url = viewModel.imageURL(at: indexPath.item)
        cell.configure(with: url)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageCarouselCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalInset: CGFloat = 5
        let height: CGFloat = 300
        let width = collectionView.bounds.width - (horizontalInset * 2)
        return CGSize(width: width, height: height)
    }
}

// MARK: - UIScrollViewDelegate
extension ImageCarouselCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
}

