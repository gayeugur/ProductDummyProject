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
            return "Geçersiz URL"
        case .noData:
            return "Veri bulunamadı"
        case .decodingError:
            return "Veri çözümlenemedi"
        case .serverError(let code):
            return "Sunucu hatası: \(code)"
        }
    }
}
