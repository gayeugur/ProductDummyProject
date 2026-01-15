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
                    ExpandableItem(icon: nil, text: product.shippingInformation),
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
                    ExpandableItem(icon: nil, text: "Dimensions: \(product.dimensions.width) x \(product.dimensions.height) x \(product.dimensions.depth)"),
                    ExpandableItem(icon: nil, text: "Availability: \(product.availabilityStatus)"),
                    ExpandableItem(icon: nil, text: "Minimum Order: \(product.minimumOrderQuantity)")
                ],
                isExpanded: true
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
