//
//  PopupViewController.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

import UIKit

class PopupViewController: UIViewController {
    // MARK: - ıboutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var dimView: UIView! 
    
    // MARK: - properties
    private let viewModel: PopupViewModelProtocol
    
    // MARK: - init
    init(viewModel: PopupViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - funitions
    private func bind() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.message
        firstButton.setTitle(viewModel.actions[0].title, for: .normal)
        secondButton.setTitle(viewModel.actions[1].title, for: .normal)
    }
    
    private func handleAction(at index: Int) {
        guard viewModel.actions.indices.contains(index) else { return }

        let action = viewModel.actions[index]
        dismiss(animated: true)
        action.handler?()
    }
    
    // MARK: - ıbaction
    @IBAction func firstButtonAction(_ sender: Any) {
        handleAction(at: 0)
    }
    
    @IBAction func secondButtonAction(_ sender: Any) {
        handleAction(at: 1)
    }
}
