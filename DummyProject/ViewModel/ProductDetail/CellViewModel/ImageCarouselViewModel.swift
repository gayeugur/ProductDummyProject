//
//  ImageCarouselViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 10.01.2026.
//

import Foundation

struct ImageCarouselViewModel {
    let imageURLs: [String]
    
    init(imageURLs: [String]) {
        self.imageURLs = imageURLs
    }
    
    var numberOfItems: Int {
        imageURLs.count
    }
    
    func imageURL(at index: Int) -> String {
        imageURLs[index]
    }
}
