//
//  StarRatingViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 15.01.2026.
//

import Foundation

struct StarRatingViewModel {
    
    enum StarState {
        case filled
        case half
        case empty
    }
    
    let stars: [StarState]
    
    static func make(rating: Double, maxStars: Int = 5) -> StarRatingViewModel {
        let filledCount = Int(rating)
        let hasHalfStar = (rating - Double(filledCount)) >= 0.5
        
        let stars: [StarState] = (0..<maxStars).map { index in
            if index < filledCount {
                return .filled
            } else if index == filledCount && hasHalfStar {
                return .half
            } else {
                return .empty
            }
        }
        
        return StarRatingViewModel(stars: stars)
    }
}
