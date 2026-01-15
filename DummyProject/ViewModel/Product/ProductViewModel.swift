//
//  ProductViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 7.01.2026.
//

import Foundation

protocol ProductViewModelDelegate: AnyObject {
    func didUpdate(state: ProductsViewState)
}

final class ProductViewModel {
    weak var delegate: ProductViewModelDelegate?
    
    private(set) var products: [Product] = []
    
    private(set) var state: ProductsViewState = .idle {
        didSet {
            delegate?.didUpdate(state: state)
        }
    }
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Data Source Methods
    var numberOfProducts: Int {
        return products.count
    }
    
    func product(at index: Int) -> Product {
        return products[index]
    }
    
    func cellViewModel(at index: Int) -> ProductCellViewModel {
        let product = products[index]
        return ProductCellViewModel(product: product)
    }
    
    func fetchProducts() {
        state = .loading
        
        Task { // async func
            do {
                let response = try await networkManager.request(urlString: Constant.Network.baseURL +
                                                                Constant.Network.Endpoint.products,
                                                                responseType: ProductsResponse.self)
                products = response.products
                state = .loaded(response.products)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
