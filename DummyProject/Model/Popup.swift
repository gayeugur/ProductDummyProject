//
//  Popup.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

struct PopupAction {
    let title: String
    let style: ActionStyle
    let handler: (() -> Void)?

    enum ActionStyle {
        case primary
        case secondary
        case destructive
    }
}

struct PopupConfiguration {
    let title: String?
    let message: String?
    let actions: [PopupAction]
}
