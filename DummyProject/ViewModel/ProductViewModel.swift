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
