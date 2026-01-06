//
//  NetworkManager.swift
//  DummyProject
//
//  Created by gayeugur on 6.01.2026.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()
    private init() {}

    func request<T: Decodable>(
        urlString: String,
        responseType: T.Type
    ) async throws -> T {

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
