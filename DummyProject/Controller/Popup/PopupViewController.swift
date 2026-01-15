//
//  PopupViewController.swift
//  DummyProject
//
//  Created by gayeugur on 9.01.2026.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var dimView: UIView! 
    
    private let viewModel: PopupViewModelProtocol
    
    init(viewModel: PopupViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
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
    
    @IBAction func firstButtonAction(_ sender: Any) {
        handleAction(at: 0)
    }
    
    @IBAction func secondButtonAction(_ sender: Any) {
        handleAction(at: 1)
    }
}
