//
//  UIViewController.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

import UIKit

extension UIViewController {

    private static let loadingTag = 999999

    func showLoading() {
        guard view.viewWithTag(Self.loadingTag) == nil else { return }

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.startAnimating()
        indicator.tag = Self.loadingTag

        view.addSubview(indicator)
    }

    func hideLoading() {
        view.viewWithTag(Self.loadingTag)?.removeFromSuperview()
    }
}
