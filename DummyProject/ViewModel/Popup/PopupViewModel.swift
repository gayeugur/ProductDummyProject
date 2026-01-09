//
//  PopupViewModel.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

protocol PopupViewModelProtocol {
    var title: String? { get }
    var message: String? { get }
    var actions: [PopupAction] { get }
}

final class PopupViewModel: PopupViewModelProtocol {
    
    private let config: PopupConfiguration
    
    init(config: PopupConfiguration) {
        self.config = config
    }
    
    var title: String? {
        config.title
    }
    
    var message: String? {
        config.message
    }
    
    var actions: [PopupAction] {
        config.actions
    }
}
