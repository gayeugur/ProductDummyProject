//
//  ImageCarouselCell.swift
//  DummyProject
//
//  Created by gayeugur on 10.01.2026.
//

import UIKit

final class ImageCarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var imagecollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    static let reuseId = "ImageCarouselCell"
    
    private var viewModel: ImageCarouselViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
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
        pageControl.numberOfPages = viewModel.imageURLs.count
        pageControl.currentPage = 0
        imagecollectionView.reloadData()
    }
}

extension ImageCarouselCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel?.imageURLs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageItemCell.reuseId,
            for: indexPath) as? ImageItemCell else {
            return UICollectionViewCell()
        }
        
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let url = viewModel.imageURLs[indexPath.item]
        cell.configure(with: url)
        return cell
    }
}

extension ImageCarouselCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalInset: CGFloat = 5
        let height: CGFloat = 300
        
        var width = collectionView.bounds.width - (horizontalInset * 2)
        width = 370
        return CGSize(width: width, height: height)
    }
}

extension ImageCarouselCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
}

