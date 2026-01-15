//
//  ImageItemCell.swift
//  DummyProject
//
//  Created by gayeugur on 11.01.2026.
//

import UIKit

class ImageItemCell: UICollectionViewCell {
    
    // MARK: - ıboutlet
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - properties
    static let reuseId = "ImageItemCell"
    private var currentURL: String?
    
    // MARK: - ınıt
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        currentURL = nil
    }
    
    // MARK: - functions
    func configure(with urlString: String) {
        currentURL = urlString
        
        ImageLoader.shared.loadImage(from: urlString) { [weak self] image in
            guard let self,
                  self.currentURL == urlString else { return }
            self.imageView.image = image
        }
    }
}
