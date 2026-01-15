//
//  NetworkError.swift
//  DummyProject
//
//  Created by gayeugur on 6.01.2026.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data available"
        case .decodingError:
            return "Failed to decode data"
        case .serverError(let code):
            return "Server error: \(code)"
        }
    }
}
