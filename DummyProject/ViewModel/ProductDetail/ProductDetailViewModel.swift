//
//  ProductDetailViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 10.01.2026.
//

final class ProductDetailViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var pruductV: Product {
        product
    }
    
    var productBrand: String {
        product.brand ?? ""
    }
    
    var titleText: String {
        product.title
    }
    
    var priceText: String {
        "\(product.price) ₺"
    }
    
    var imageCarouselVM: ImageCarouselViewModel {
        ImageCarouselViewModel(
            imageURLs: product.images
        )
    }
    
    var productVM: ProductCellViewModel {
        ProductCellViewModel(product: product)
    }
    
    // MARK: - Expandable Sections
    var expandableSections: [ExpandableSectionViewModel] {
        [
            ExpandableSectionViewModel(
                title: "Ürün Açıklaması",
                items: [ExpandableItem(icon: nil, text: product.description)],
                isExpanded: true
            ),
            ExpandableSectionViewModel(
                title: "Teslimat & Garanti",
                items: [
                    ExpandableItem(icon: nil, text: "Ships in 3-5 business days"),
                    ExpandableItem(icon: nil, text: product.warrantyInformation),
                    ExpandableItem(icon: nil, text: product.returnPolicy)
                ],
                isExpanded: true
            ),
            ExpandableSectionViewModel(
                title: "Ürün Bilgileri",
                items: [
                    ExpandableItem(icon: nil, text: "SKU: \(product.sku)"),
                    ExpandableItem(icon: nil, text: "Weight: \(product.weight)g"),
                    ExpandableItem(icon: nil, text: "Dimensions: \(product.dimensions.width) x \(product.dimensions.height) x \(product.dimensions.depth)")
                ],
                isExpanded: false
            ),
            ExpandableSectionViewModel(
                title: "Yorumlar (\(product.reviews.count))",
                items: product.reviews.map { review in
                    ExpandableItem(icon: nil, text: "\(review.reviewerName): \(review.comment)")
                },
                isExpanded: false
            )
        ]
    }
}
