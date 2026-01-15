//
//  ImageCarouselViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 10.01.2026.
//

import Foundation

struct ImageCarouselViewModel {
    private let imageURLs: [String]
    
    init(imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
    
    // MARK: - Data Source Methods
    var numberOfItems: Int {
        return imageURLs.count
    }
    
    var numberOfPages: Int {
        return imageURLs.count
    }
    
    func imageURL(at index: Int) -> String {
        return imageURLs[index]
    }
}
