//
//  Untitled.swift
//  DummyProject
//
//  Created by gayeugur on 6.01.2026.
//

import Foundation

struct ProductsResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String
    let sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let meta: Meta
    let images: [String]
    let thumbnail: String
}

struct Dimensions: Decodable {
    let width: Double
    let height: Double
    let depth: Double
}

struct Review: Decodable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}

struct Meta: Decodable {
    let createdAt: String
    let updatedAt: String
    let barcode: String
    let qrCode: String
}
