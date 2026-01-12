//
//  ImageItemCell.swift
//  DummyProject
//
//  Created by gayeugur on 11.01.2026.
//

import UIKit

class ImageItemCell: UICollectionViewCell {
    
    static let reuseId = "ImageItemCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var currentURL: String?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        currentURL = nil
    }
    
    func configure(with urlString: String) {
        currentURL = urlString
        
        ImageLoader.shared.loadImage(from: urlString) { [weak self] image in
            guard let self,
                  self.currentURL == urlString else { return }
            self.imageView.image = image
        }
    }
}
