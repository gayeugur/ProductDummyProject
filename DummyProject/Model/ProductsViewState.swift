//
//  ProductsViewState.swift
//  DummyProject
//
//  Created by gayeugur on 7.01.2026.
//

enum ProductsViewState {
    case idle
    case loading
    case loaded([Product])
    case error(String)
}
